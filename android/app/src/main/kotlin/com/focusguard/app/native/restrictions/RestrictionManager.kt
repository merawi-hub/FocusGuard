package com.focusguard.app.native.restrictions

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Build
import com.focusguard.app.native.receivers.DailyResetReceiver
import com.focusguard.app.native.receivers.EmergencyUnlockReceiver
import java.util.Calendar

class RestrictionManager(private val context: Context) {

    private val prefs: SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    companion object {
        private const val PREFS_NAME = "focusguard_restrictions_pref"
        private const val KEY_RESTRICTED_PACKAGES = "restricted_packages"
        private const val KEY_MONITORED_PACKAGES = "monitored_packages"
        private const val KEY_UNLOCK_PREFIX = "unlock_expiry_"
        private const val KEY_LIMIT_PREFIX = "limit_seconds_"
        private const val KEY_WARNING_PREFIX = "warning_sent_"
        private const val KEY_LAST_RESET_DAY = "last_reset_day_of_year"

        @Volatile
        private var instance: RestrictionManager? = null

        fun getInstance(context: Context): RestrictionManager {
            return instance ?: synchronized(this) {
                instance ?: RestrictionManager(context.applicationContext).also { instance = it }
            }
        }
    }

    init {
        checkAndPerformDailyResetIfNeeded()
    }

    fun setRestrictedPackages(packages: List<String>) {
        checkAndPerformDailyResetIfNeeded()
        prefs.edit().putStringSet(KEY_RESTRICTED_PACKAGES, packages.toSet()).apply()
    }

    fun addRestrictedPackage(packageName: String, limitSeconds: Long = 0) {
        checkAndPerformDailyResetIfNeeded()
        val current = getRestrictedPackages().toMutableSet()
        current.add(packageName)
        val editor = prefs.edit().putStringSet(KEY_RESTRICTED_PACKAGES, current)
        if (limitSeconds > 0) {
            editor.putLong(KEY_LIMIT_PREFIX + packageName, limitSeconds)
        }
        editor.apply()
    }

    fun setMonitoredPackages(packages: List<String>) {
        prefs.edit().putStringSet(KEY_MONITORED_PACKAGES, packages.toSet()).apply()
    }

    fun getMonitoredPackages(): Set<String> {
        return prefs.getStringSet(KEY_MONITORED_PACKAGES, emptySet()) ?: emptySet()
    }

    fun setPackageLimitSeconds(packageName: String, limitSeconds: Long) {
        prefs.edit().putLong(KEY_LIMIT_PREFIX + packageName, limitSeconds).apply()
    }

    fun getPackageLimitSeconds(packageName: String): Long {
        return prefs.getLong(KEY_LIMIT_PREFIX + packageName, 0L)
    }

    fun removeRestrictedPackage(packageName: String) {
        val current = getRestrictedPackages().toMutableSet()
        current.remove(packageName)
        prefs.edit()
            .putStringSet(KEY_RESTRICTED_PACKAGES, current)
            .remove(KEY_UNLOCK_PREFIX + packageName)
            .remove(KEY_LIMIT_PREFIX + packageName)
            .apply()
        cancelEmergencyUnlockAlarm(packageName)
    }

    fun getRestrictedPackages(): Set<String> {
        checkAndPerformDailyResetIfNeeded()
        return prefs.getStringSet(KEY_RESTRICTED_PACKAGES, emptySet()) ?: emptySet()
    }

    fun isPackageRestricted(packageName: String): Boolean {
        checkAndPerformDailyResetIfNeeded()
        if (!getRestrictedPackages().contains(packageName)) {
            return false
        }
        return !isEmergencyUnlocked(packageName)
    }

    fun grantEmergencyUnlock(packageName: String, durationMinutes: Int = 10): Long {
        val expiryTime = System.currentTimeMillis() + (durationMinutes * 60 * 1000L)
        prefs.edit().putLong(KEY_UNLOCK_PREFIX + packageName, expiryTime).apply()
        scheduleEmergencyUnlockExpirationAlarm(packageName, expiryTime)
        return expiryTime
    }

    fun revokeEmergencyUnlock(packageName: String) {
        prefs.edit().remove(KEY_UNLOCK_PREFIX + packageName).apply()
        cancelEmergencyUnlockAlarm(packageName)
    }

    fun isEmergencyUnlocked(packageName: String): Boolean {
        val expiry = prefs.getLong(KEY_UNLOCK_PREFIX + packageName, 0L)
        if (expiry <= 0L) return false

        if (System.currentTimeMillis() < expiry) {
            return true
        } else {
            prefs.edit().remove(KEY_UNLOCK_PREFIX + packageName).apply()
            return false
        }
    }

    fun getRemainingUnlockSeconds(packageName: String): Long {
        val expiry = prefs.getLong(KEY_UNLOCK_PREFIX + packageName, 0L)
        val diff = expiry - System.currentTimeMillis()
        return if (diff > 0) diff / 1000 else 0
    }

    // --- Warning Thresholds Tracking ---

    fun hasSentWarningToday(packageName: String, percentage: Int): Boolean {
        checkAndPerformDailyResetIfNeeded()
        return prefs.getBoolean("${KEY_WARNING_PREFIX}${packageName}_$percentage", false)
    }

    fun markWarningSentToday(packageName: String, percentage: Int) {
        prefs.edit().putBoolean("${KEY_WARNING_PREFIX}${packageName}_$percentage", true).apply()
    }

    // --- Daily Reset Engine ---

    fun checkAndPerformDailyResetIfNeeded(): Boolean {
        val today = Calendar.getInstance().get(Calendar.DAY_OF_YEAR)
        val lastReset = prefs.getInt(KEY_LAST_RESET_DAY, -1)

        if (lastReset != today) {
            performDailyReset(today)
            return true
        }
        return false
    }

    fun performDailyReset(dayOfYear: Int = Calendar.getInstance().get(Calendar.DAY_OF_YEAR)) {
        // Clear all current restrictions for the new day
        val editor = prefs.edit()
        editor.remove(KEY_RESTRICTED_PACKAGES)

        // Clear warning sent flags and unlock expirations
        val allKeys = prefs.all.keys
        for (key in allKeys) {
            if (key.startsWith(KEY_WARNING_PREFIX) || key.startsWith(KEY_UNLOCK_PREFIX)) {
                editor.remove(key)
            }
        }
        editor.putInt(KEY_LAST_RESET_DAY, dayOfYear)
        editor.apply()

        // Schedule next midnight alarm
        scheduleNextMidnightResetAlarm()
    }

    fun clearAllRestrictions() {
        prefs.edit().clear().apply()
    }

    // --- AlarmManager Scheduling ---

    private fun scheduleEmergencyUnlockExpirationAlarm(packageName: String, triggerAtMillis: Long) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager ?: return
        val intent = Intent(context, EmergencyUnlockReceiver::class.java).apply {
            action = EmergencyUnlockReceiver.ACTION_EMERGENCY_UNLOCK_EXPIRED
            putExtra(EmergencyUnlockReceiver.EXTRA_PACKAGE_NAME, packageName)
        }
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            packageName.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, triggerAtMillis, pendingIntent)
            } else {
                alarmManager.setExact(AlarmManager.RTC_WAKEUP, triggerAtMillis, pendingIntent)
            }
        } catch (_: SecurityException) {
            // Fallback for devices restricting exact alarms
            alarmManager.set(AlarmManager.RTC_WAKEUP, triggerAtMillis, pendingIntent)
        }
    }

    private fun cancelEmergencyUnlockAlarm(packageName: String) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager ?: return
        val intent = Intent(context, EmergencyUnlockReceiver::class.java).apply {
            action = EmergencyUnlockReceiver.ACTION_EMERGENCY_UNLOCK_EXPIRED
            putExtra(EmergencyUnlockReceiver.EXTRA_PACKAGE_NAME, packageName)
        }
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            packageName.hashCode(),
            intent,
            PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE
        )
        if (pendingIntent != null) {
            alarmManager.cancel(pendingIntent)
            pendingIntent.cancel()
        }
    }

    fun scheduleNextMidnightResetAlarm() {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager ?: return
        val intent = Intent(context, DailyResetReceiver::class.java).apply {
            action = DailyResetReceiver.ACTION_DAILY_RESET
        }
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            1001,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        // Calculate next 00:00:00
        val calendar = Calendar.getInstance().apply {
            add(Calendar.DAY_OF_YEAR, 1)
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
            } else {
                alarmManager.setExact(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
            }
        } catch (_: SecurityException) {
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
        }
    }
}

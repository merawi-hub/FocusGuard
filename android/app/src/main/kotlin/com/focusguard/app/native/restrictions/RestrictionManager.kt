package com.focusguard.app.native.restrictions

import android.content.Context
import android.content.SharedPreferences

class RestrictionManager(private val context: Context) {

    private val prefs: SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    companion object {
        private const val PREFS_NAME = "focusguard_restrictions_pref"
        private const val KEY_RESTRICTED_PACKAGES = "restricted_packages"
        private const val KEY_UNLOCK_PREFIX = "unlock_expiry_"
        private const val KEY_LIMIT_PREFIX = "limit_seconds_"

        @Volatile
        private var instance: RestrictionManager? = null

        fun getInstance(context: Context): RestrictionManager {
            return instance ?: synchronized(this) {
                instance ?: RestrictionManager(context.applicationContext).also { instance = it }
            }
        }
    }

    fun setRestrictedPackages(packages: List<String>) {
        prefs.edit().putStringSet(KEY_RESTRICTED_PACKAGES, packages.toSet()).apply()
    }

    fun addRestrictedPackage(packageName: String, limitSeconds: Long = 0) {
        val current = getRestrictedPackages().toMutableSet()
        current.add(packageName)
        val editor = prefs.edit().putStringSet(KEY_RESTRICTED_PACKAGES, current)
        if (limitSeconds > 0) {
            editor.putLong(KEY_LIMIT_PREFIX + packageName, limitSeconds)
        }
        editor.apply()
    }

    fun removeRestrictedPackage(packageName: String) {
        val current = getRestrictedPackages().toMutableSet()
        current.remove(packageName)
        prefs.edit()
            .putStringSet(KEY_RESTRICTED_PACKAGES, current)
            .remove(KEY_UNLOCK_PREFIX + packageName)
            .remove(KEY_LIMIT_PREFIX + packageName)
            .apply()
    }

    fun getRestrictedPackages(): Set<String> {
        return prefs.getStringSet(KEY_RESTRICTED_PACKAGES, emptySet()) ?: emptySet()
    }

    fun isPackageRestricted(packageName: String): Boolean {
        if (!getRestrictedPackages().contains(packageName)) {
            return false
        }
        // If an emergency unlock is currently active, it is temporarily not restricted
        return !isEmergencyUnlocked(packageName)
    }

    fun grantEmergencyUnlock(packageName: String, durationMinutes: Int = 10): Long {
        val expiryTime = System.currentTimeMillis() + (durationMinutes * 60 * 1000L)
        prefs.edit().putLong(KEY_UNLOCK_PREFIX + packageName, expiryTime).apply()
        return expiryTime
    }

    fun isEmergencyUnlocked(packageName: String): Boolean {
        val expiry = prefs.getLong(KEY_UNLOCK_PREFIX + packageName, 0L)
        if (expiry <= 0L) return false

        if (System.currentTimeMillis() < expiry) {
            return true
        } else {
            // Unlock has expired, clean up
            prefs.edit().remove(KEY_UNLOCK_PREFIX + packageName).apply()
            return false
        }
    }

    fun getRemainingUnlockSeconds(packageName: String): Long {
        val expiry = prefs.getLong(KEY_UNLOCK_PREFIX + packageName, 0L)
        val diff = expiry - System.currentTimeMillis()
        return if (diff > 0) diff / 1000 else 0
    }

    fun clearAllRestrictions() {
        prefs.edit().clear().apply()
    }
}


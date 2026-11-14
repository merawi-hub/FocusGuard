package com.focusguard.app.native.restrictions

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import com.focusguard.app.native.notifications.NotificationHelper
import com.focusguard.app.native.usage.UsageTracker

class FocusAccessibilityService : AccessibilityService() {

    companion object {
        private const val TAG = "FocusAccessibility"
    }

    private lateinit var restrictionManager: RestrictionManager
    private lateinit var usageTracker: UsageTracker
    private val mainHandler = Handler(Looper.getMainLooper())
    private var currentForegroundPackage: String? = null

    private val activeForegroundCheckRunnable = object : Runnable {
        override fun run() {
            val pkg = currentForegroundPackage ?: return
            checkAndEnforceForActivePackage(pkg)
            // Re-schedule check every 15 seconds while user is active in this package
            mainHandler.postDelayed(this, 15000L)
        }
    }

    override fun onCreate() {
        super.onCreate()
        restrictionManager = RestrictionManager.getInstance(this)
        usageTracker = UsageTracker(this)
        Log.i(TAG, "FocusAccessibilityService initialized")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null || event.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            return
        }

        val packageName = event.packageName?.toString() ?: return

        // Skip our own package to prevent recursive blocking
        if (packageName == applicationContext.packageName) {
            return
        }

        currentForegroundPackage = packageName
        mainHandler.removeCallbacks(activeForegroundCheckRunnable)

        // Check if package is already restricted and not currently unlocked
        if (restrictionManager.isPackageRestricted(packageName)) {
            Log.w(TAG, "Restricted app launched: $packageName. Intercepting...")
            launchBlocker(packageName)
            return
        }

        // If package is monitored with a limit, start active usage watch
        val limit = restrictionManager.getPackageLimitSeconds(packageName)
        if (limit > 0) {
            checkAndEnforceForActivePackage(packageName)
            mainHandler.postDelayed(activeForegroundCheckRunnable, 15000L)
        }
    }

    private fun checkAndEnforceForActivePackage(packageName: String) {
        val limit = restrictionManager.getPackageLimitSeconds(packageName)
        if (limit <= 0) return

        if (restrictionManager.isEmergencyUnlocked(packageName)) {
            return
        }

        val usedSeconds = usageTracker.getUsageSecondsToday(packageName)
        val limitMinutes = (limit / 60).toInt()
        val usedMinutes = (usedSeconds / 60).toInt()

        if (usedSeconds >= limit) {
            Log.w(TAG, "Limit reached during active session for $packageName ($usedSeconds >= $limit s)")
            restrictionManager.addRestrictedPackage(packageName, limit)

            if (!restrictionManager.hasSentWarningToday(packageName, 100)) {
                restrictionManager.markWarningSentToday(packageName, 100)
                NotificationHelper.sendRestrictionNotification(
                    this,
                    packageName,
                    getAppLabel(packageName),
                    limitMinutes
                )
            }

            launchBlocker(packageName)
        } else {
            val percentage = ((usedSeconds.toDouble() / limit.toDouble()) * 100).toInt()
            if (percentage >= 80 && !restrictionManager.hasSentWarningToday(packageName, 80)) {
                restrictionManager.markWarningSentToday(packageName, 80)
                NotificationHelper.sendWarningNotification(
                    this,
                    packageName,
                    getAppLabel(packageName),
                    80,
                    usedMinutes,
                    limitMinutes
                )
            } else if (percentage >= 50 && !restrictionManager.hasSentWarningToday(packageName, 50)) {
                restrictionManager.markWarningSentToday(packageName, 50)
                NotificationHelper.sendWarningNotification(
                    this,
                    packageName,
                    getAppLabel(packageName),
                    50,
                    usedMinutes,
                    limitMinutes
                )
            }
        }
    }

    private fun launchBlocker(packageName: String) {
        val intent = Intent(this, RestrictionBlockerActivity::class.java).apply {
            putExtra("packageName", packageName)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP or
                    Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS
        }
        startActivity(intent)
    }

    private fun getAppLabel(packageName: String): String {
        return try {
            val pm = packageManager
            val info = pm.getApplicationInfo(packageName, 0)
            pm.getApplicationLabel(info).toString()
        } catch (_: Exception) {
            packageName
        }
    }

    override fun onInterrupt() {
        mainHandler.removeCallbacks(activeForegroundCheckRunnable)
        Log.i(TAG, "FocusAccessibilityService interrupted")
    }

    override fun onDestroy() {
        mainHandler.removeCallbacks(activeForegroundCheckRunnable)
        super.onDestroy()
    }
}

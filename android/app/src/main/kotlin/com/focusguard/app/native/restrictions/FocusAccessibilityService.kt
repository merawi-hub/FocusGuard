package com.focusguard.app.native.restrictions

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.util.Log
import android.view.accessibility.AccessibilityEvent

class FocusAccessibilityService : AccessibilityService() {

    companion object {
        private const val TAG = "FocusAccessibility"
    }

    private lateinit var restrictionManager: RestrictionManager

    override fun onCreate() {
        super.onCreate()
        restrictionManager = RestrictionManager.getInstance(this)
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

        // Check if package is restricted and not currently unlocked
        if (restrictionManager.isPackageRestricted(packageName)) {
            Log.w(TAG, "Restricted app launched: $packageName. Intercepting...")

            // Launch the blocker activity
            val intent = Intent(this, RestrictionBlockerActivity::class.java).apply {
                putExtra("packageName", packageName)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or
                        Intent.FLAG_ACTIVITY_CLEAR_TOP or
                        Intent.FLAG_ACTIVITY_SINGLE_TOP or
                        Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS
            }
            startActivity(intent)
        }
    }

    override fun onInterrupt() {
        Log.i(TAG, "FocusAccessibilityService interrupted")
    }
}


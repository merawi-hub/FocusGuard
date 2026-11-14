package com.focusguard.app.native.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.focusguard.app.native.notifications.NotificationHelper
import com.focusguard.app.native.restrictions.RestrictionManager

class EmergencyUnlockReceiver : BroadcastReceiver() {

    companion object {
        const val ACTION_EMERGENCY_UNLOCK_EXPIRED = "com.focusguard.app.ACTION_EMERGENCY_UNLOCK_EXPIRED"
        const val EXTRA_PACKAGE_NAME = "extra_package_name"
        private const val TAG = "EmergencyUnlockReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        val packageName = intent.getStringExtra(EXTRA_PACKAGE_NAME) ?: return
        Log.i(TAG, "Emergency unlock expired for package: $packageName")

        val restrictionManager = RestrictionManager.getInstance(context)
        restrictionManager.revokeEmergencyUnlock(packageName)

        // Get readable app label
        val appName = try {
            val pm = context.packageManager
            val info = pm.getApplicationInfo(packageName, 0)
            pm.getApplicationLabel(info).toString()
        } catch (_: Exception) {
            packageName
        }

        // Issue restriction restoration notification
        NotificationHelper.sendRestrictionNotification(
            context = context,
            packageName = packageName,
            appName = appName,
            limitMinutes = (restrictionManager.getPackageLimitSeconds(packageName) / 60).toInt()
        )
    }
}


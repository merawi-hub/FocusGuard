package com.focusguard.app.native.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.focusguard.app.native.restrictions.RestrictionManager
import com.focusguard.app.native.usage.WorkScheduler

class BootReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "BootReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action
        Log.i(TAG, "Received system broadcast action: $action")

        val restrictionManager = RestrictionManager.getInstance(context)

        // Verify and perform daily reset if date changed while powered off
        restrictionManager.checkAndPerformDailyResetIfNeeded()

        // Re-arm midnight reset alarm
        restrictionManager.scheduleNextMidnightResetAlarm()

        // Re-enqueue background WorkManager monitoring
        WorkScheduler.schedulePeriodicMonitoring(context)
    }
}


package com.focusguard.app.native.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.focusguard.app.native.restrictions.RestrictionManager

class DailyResetReceiver : BroadcastReceiver() {

    companion object {
        const val ACTION_DAILY_RESET = "com.focusguard.app.ACTION_DAILY_RESET"
        private const val TAG = "DailyResetReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        Log.i(TAG, "Daily reset alarm fired. Resetting all usage limits and restrictions.")
        val restrictionManager = RestrictionManager.getInstance(context)
        restrictionManager.performDailyReset()
    }
}


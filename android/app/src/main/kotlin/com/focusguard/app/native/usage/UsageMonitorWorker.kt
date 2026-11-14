package com.focusguard.app.native.usage

import android.content.Context
import android.util.Log
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.focusguard.app.native.notifications.NotificationHelper
import com.focusguard.app.native.permissions.PermissionHelper
import com.focusguard.app.native.restrictions.RestrictionManager

class UsageMonitorWorker(
    appContext: Context,
    params: WorkerParameters
) : CoroutineWorker(appContext, params) {

    companion object {
        const val WORK_NAME = "FocusGuardUsageMonitor"
        private const val TAG = "UsageMonitorWorker"
    }

    override suspend fun doWork(): Result {
        Log.i(TAG, "Executing background usage evaluation...")

        if (!PermissionHelper.hasUsageStatsPermission(applicationContext)) {
            Log.w(TAG, "UsageStats permission not granted. Skipping evaluation.")
            return Result.success()
        }

        val restrictionManager = RestrictionManager.getInstance(applicationContext)
        val usageTracker = UsageTracker(applicationContext)

        // Ensure daily reset is performed if crossing day boundary in background
        restrictionManager.checkAndPerformDailyResetIfNeeded()

        val monitoredPackages = restrictionManager.getMonitoredPackages()
        if (monitoredPackages.isEmpty()) {
            return Result.success()
        }

        val usageStats = usageTracker.getTodayUsageStats(monitoredPackages.toList())
        val usageMap = usageStats.associate {
            (it["packageName"] as String) to ((it["durationSeconds"] as? Number)?.toLong() ?: 0L)
        }

        val pm = applicationContext.packageManager

        for (pkg in monitoredPackages) {
            val limitSeconds = restrictionManager.getPackageLimitSeconds(pkg)
            if (limitSeconds <= 0) continue

            val usedSeconds = usageMap[pkg] ?: 0L
            val appLabel = try {
                val appInfo = pm.getApplicationInfo(pkg, 0)
                pm.getApplicationLabel(appInfo).toString()
            } catch (_: Exception) {
                pkg
            }

            val limitMinutes = (limitSeconds / 60).toInt()
            val usedMinutes = (usedSeconds / 60).toInt()

            if (usedSeconds >= limitSeconds) {
                // Enforce restriction
                restrictionManager.addRestrictedPackage(pkg, limitSeconds)

                if (!restrictionManager.hasSentWarningToday(pkg, 100)) {
                    restrictionManager.markWarningSentToday(pkg, 100)
                    NotificationHelper.sendRestrictionNotification(
                        applicationContext,
                        pkg,
                        appLabel,
                        limitMinutes
                    )
                }
            } else {
                val percentage = ((usedSeconds.toDouble() / limitSeconds.toDouble()) * 100).toInt()

                if (percentage >= 80 && !restrictionManager.hasSentWarningToday(pkg, 80)) {
                    restrictionManager.markWarningSentToday(pkg, 80)
                    NotificationHelper.sendWarningNotification(
                        applicationContext,
                        pkg,
                        appLabel,
                        80,
                        usedMinutes,
                        limitMinutes
                    )
                } else if (percentage >= 50 && !restrictionManager.hasSentWarningToday(pkg, 50)) {
                    restrictionManager.markWarningSentToday(pkg, 50)
                    NotificationHelper.sendWarningNotification(
                        applicationContext,
                        pkg,
                        appLabel,
                        50,
                        usedMinutes,
                        limitMinutes
                    )
                }
            }
        }

        return Result.success()
    }
}


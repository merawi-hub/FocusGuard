package com.focusguard.app.native.usage

import android.content.Context
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import java.util.concurrent.TimeUnit

object WorkScheduler {

    fun schedulePeriodicMonitoring(context: Context) {
        val workRequest = PeriodicWorkRequestBuilder<UsageMonitorWorker>(
            15, TimeUnit.MINUTES,
            5, TimeUnit.MINUTES // 5-minute flex interval
        ).build()

        WorkManager.getInstance(context).enqueueUniquePeriodicWork(
            UsageMonitorWorker.WORK_NAME,
            ExistingPeriodicWorkPolicy.KEEP,
            workRequest
        )
    }

    fun runImmediateCheck(context: Context) {
        val workRequest = OneTimeWorkRequestBuilder<UsageMonitorWorker>().build()
        WorkManager.getInstance(context).enqueue(workRequest)
    }
}


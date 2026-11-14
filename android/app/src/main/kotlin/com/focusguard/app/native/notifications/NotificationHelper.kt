package com.focusguard.app.native.notifications

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import com.focusguard.app.MainActivity

object NotificationHelper {

    private const val CHANNEL_WARNINGS_ID = "focusguard_warnings"
    private const val CHANNEL_WARNINGS_NAME = "Usage Warnings"
    private const val CHANNEL_RESTRICTIONS_ID = "focusguard_restrictions"
    private const val CHANNEL_RESTRICTIONS_NAME = "App Restrictions"

    fun createNotificationChannels(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

            val warningChannel = NotificationChannel(
                CHANNEL_WARNINGS_ID,
                CHANNEL_WARNINGS_NAME,
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Notifies when daily application usage approaches configured limits"
                enableVibration(true)
            }

            val restrictionChannel = NotificationChannel(
                CHANNEL_RESTRICTIONS_ID,
                CHANNEL_RESTRICTIONS_NAME,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifies when an application is restricted due to reaching its daily limit"
                enableVibration(true)
            }

            notificationManager.createNotificationChannel(warningChannel)
            notificationManager.createNotificationChannel(restrictionChannel)
        }
    }

    fun sendWarningNotification(
        context: Context,
        packageName: String,
        appName: String,
        percentage: Int,
        usedMinutes: Int,
        limitMinutes: Int
    ) {
        createNotificationChannels(context)
        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }

        val pendingIntent = PendingIntent.getActivity(
            context,
            packageName.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val title = "FocusGuard Warning: $appName ($percentage%)"
        val message = "$appName has reached $percentage% of its daily limit ($usedMinutes / $limitMinutes mins). Consider winding down."

        val notification = NotificationCompat.Builder(context, CHANNEL_WARNINGS_ID)
            .setSmallIcon(android.R.drawable.ic_dialog_alert)
            .setContentTitle(title)
            .setContentText(message)
            .setStyle(NotificationCompat.BigTextStyle().bigText(message))
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .build()

        notificationManager.notify(packageName.hashCode() + percentage, notification)
    }

    fun sendRestrictionNotification(
        context: Context,
        packageName: String,
        appName: String,
        limitMinutes: Int
    ) {
        createNotificationChannels(context)
        val notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }

        val pendingIntent = PendingIntent.getActivity(
            context,
            packageName.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val title = "Limit Reached: $appName is Restricted"
        val message = "$appName has reached its $limitMinutes min daily limit. It is now blocked until tomorrow or until you request an emergency unlock."

        val notification = NotificationCompat.Builder(context, CHANNEL_RESTRICTIONS_ID)
            .setSmallIcon(android.R.drawable.ic_lock_lock)
            .setContentTitle(title)
            .setContentText(message)
            .setStyle(NotificationCompat.BigTextStyle().bigText(message))
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .build()

        notificationManager.notify(packageName.hashCode() + 1000, notification)
    }
}


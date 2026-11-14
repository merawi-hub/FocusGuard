package com.focusguard.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.focusguard.app.native.permissions.PermissionHelper
import com.focusguard.app.native.usage.UsageTracker
import com.focusguard.app.native.usage.WorkScheduler
import com.focusguard.app.native.restrictions.RestrictionManager
import com.focusguard.app.native.notifications.NotificationHelper

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.focusguard.app/restrictions"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val restrictionManager = RestrictionManager.getInstance(this)
        val usageTracker = UsageTracker(this)

        NotificationHelper.createNotificationChannels(this)
        WorkScheduler.schedulePeriodicMonitoring(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermissions" -> {
                    try {
                        val status = PermissionHelper.getPermissionsStatus(this)
                        result.success(status)
                    } catch (e: Exception) {
                        result.error("PERMISSION_ERROR", e.message, null)
                    }
                }
                "requestUsagePermission" -> {
                    PermissionHelper.openUsageSettings(this)
                    result.success(true)
                }
                "requestOverlayPermission" -> {
                    PermissionHelper.openOverlaySettings(this)
                    result.success(true)
                }
                "requestAccessibilityPermission" -> {
                    PermissionHelper.openAccessibilitySettings(this)
                    result.success(true)
                }
                "requestNotificationPermission" -> {
                    PermissionHelper.openNotificationSettings(this)
                    result.success(true)
                }
                "getInstalledApps" -> {
                    Thread {
                        try {
                            val includeIcons = call.argument<Boolean>("includeIcons") ?: true
                            val apps = usageTracker.getInstalledApps(includeIcons)
                            runOnUiThread { result.success(apps) }
                        } catch (e: Exception) {
                            runOnUiThread { result.error("INSTALLED_APPS_ERROR", e.message, null) }
                        }
                    }.start()
                }
                "getTodayUsage" -> {
                    Thread {
                        try {
                            val packages = call.argument<List<String>>("packages")
                            val stats = usageTracker.getTodayUsageStats(packages)
                            runOnUiThread { result.success(stats) }
                        } catch (e: Exception) {
                            runOnUiThread { result.error("USAGE_STATS_ERROR", e.message, null) }
                        }
                    }.start()
                }
                "getUsageSessions" -> {
                    Thread {
                        try {
                            val startTime = call.argument<Long>("startTime") ?: (System.currentTimeMillis() - 86400000L)
                            val endTime = call.argument<Long>("endTime") ?: System.currentTimeMillis()
                            val packages = call.argument<List<String>>("packages")?.toSet()
                            val sessions = usageTracker.getUsageSessions(startTime, endTime, packages)
                            runOnUiThread { result.success(sessions) }
                        } catch (e: Exception) {
                            runOnUiThread { result.error("USAGE_SESSIONS_ERROR", e.message, null) }
                        }
                    }.start()
                }
                "setAppRestrictions" -> {
                    try {
                        val packages = call.argument<List<String>>("packages") ?: emptyList()
                        restrictionManager.setRestrictedPackages(packages)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("RESTRICTION_ERROR", e.message, null)
                    }
                }
                "setMonitoredPackages" -> {
                    try {
                        val packages = call.argument<List<String>>("packages") ?: emptyList()
                        val limits = call.argument<Map<String, Int>>("limits") ?: emptyMap()
                        restrictionManager.setMonitoredPackages(packages)
                        for ((pkg, limitSec) in limits) {
                            restrictionManager.setPackageLimitSeconds(pkg, limitSec.toLong())
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("MONITORED_PACKAGES_ERROR", e.message, null)
                    }
                }
                "schedulePeriodicMonitoring" -> {
                    try {
                        WorkScheduler.schedulePeriodicMonitoring(this)
                        WorkScheduler.runImmediateCheck(this)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("WORK_SCHEDULER_ERROR", e.message, null)
                    }
                }
                "addAppRestriction" -> {
                    try {
                        val packageName = call.argument<String>("packageName") ?: ""
                        val limitSeconds = call.argument<Int>("limitSeconds")?.toLong() ?: 0L
                        if (packageName.isNotEmpty()) {
                            restrictionManager.addRestrictedPackage(packageName, limitSeconds)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("RESTRICTION_ERROR", e.message, null)
                    }
                }
                "removeAppRestriction" -> {
                    try {
                        val packageName = call.argument<String>("packageName") ?: ""
                        if (packageName.isNotEmpty()) {
                            restrictionManager.removeRestrictedPackage(packageName)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("RESTRICTION_ERROR", e.message, null)
                    }
                }
                "getRestrictedPackages" -> {
                    try {
                        val restricted = restrictionManager.getRestrictedPackages().toList()
                        result.success(restricted)
                    } catch (e: Exception) {
                        result.error("RESTRICTION_ERROR", e.message, null)
                    }
                }
                "requestEmergencyUnlock" -> {
                    try {
                        val packageName = call.argument<String>("packageName") ?: ""
                        val durationMinutes = call.argument<Int>("durationMinutes") ?: 10
                        if (packageName.isNotEmpty()) {
                            val expiry = restrictionManager.grantEmergencyUnlock(packageName, durationMinutes)
                            result.success(mapOf("expiryMillis" to expiry, "unlocked" to true))
                        } else {
                            result.error("INVALID_PACKAGE", "Package name cannot be empty", null)
                        }
                    } catch (e: Exception) {
                        result.error("UNLOCK_ERROR", e.message, null)
                    }
                }
                "getEmergencyUnlockStatus" -> {
                    try {
                        val packageName = call.argument<String>("packageName") ?: ""
                        val isUnlocked = restrictionManager.isEmergencyUnlocked(packageName)
                        val remainingSeconds = restrictionManager.getRemainingUnlockSeconds(packageName)
                        result.success(mapOf(
                            "isUnlocked" to isUnlocked,
                            "remainingSeconds" to remainingSeconds
                        ))
                    } catch (e: Exception) {
                        result.error("UNLOCK_STATUS_ERROR", e.message, null)
                    }
                }
                "sendWarningNotification" -> {
                    try {
                        val packageName = call.argument<String>("packageName") ?: ""
                        val appName = call.argument<String>("appName") ?: ""
                        val percentage = call.argument<Int>("percentage") ?: 80
                        val usedMinutes = call.argument<Int>("usedMinutes") ?: 0
                        val limitMinutes = call.argument<Int>("limitMinutes") ?: 0
                        NotificationHelper.sendWarningNotification(
                            this, packageName, appName, percentage, usedMinutes, limitMinutes
                        )
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("NOTIFICATION_ERROR", e.message, null)
                    }
                }
                "sendRestrictionNotification" -> {
                    try {
                        val packageName = call.argument<String>("packageName") ?: ""
                        val appName = call.argument<String>("appName") ?: ""
                        val limitMinutes = call.argument<Int>("limitMinutes") ?: 0
                        NotificationHelper.sendRestrictionNotification(
                            this, packageName, appName, limitMinutes
                        )
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("NOTIFICATION_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}

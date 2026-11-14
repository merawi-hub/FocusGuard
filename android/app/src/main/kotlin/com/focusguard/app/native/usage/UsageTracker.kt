package com.focusguard.app.native.usage

import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Base64
import java.io.ByteArrayOutputStream
import java.util.Calendar

data class InstalledAppInfo(
    val packageName: String,
    val appName: String,
    val iconBase64: String? = null
)

data class AppUsageInfo(
    val packageName: String,
    val totalTimeInForegroundSeconds: Long,
    val lastTimeUsedMillis: Long
)

class UsageTracker(private val context: Context) {

    private val usageStatsManager =
        context.getSystemService(Context.USAGE_STATS_SERVICE) as? UsageStatsManager

    fun getInstalledApps(includeIcons: Boolean = true): List<Map<String, Any?>> {
        val pm = context.packageManager
        val intent = Intent(Intent.ACTION_MAIN, null).apply {
            addCategory(Intent.CATEGORY_LAUNCHER)
        }

        val resolveInfos = pm.queryIntentActivities(intent, 0)
        val seen = mutableSetOf<String>()
        val result = mutableListOf<Map<String, Any?>>()

        for (resolveInfo in resolveInfos) {
            val pkg = resolveInfo.activityInfo.packageName
            // Skip FocusGuard itself and duplicates
            if (pkg == context.packageName || seen.contains(pkg)) {
                continue
            }
            seen.add(pkg)

            val appName = resolveInfo.loadLabel(pm).toString()
            var iconString: String? = null

            if (includeIcons) {
                try {
                    val iconDrawable = resolveInfo.loadIcon(pm)
                    iconString = drawableToBase64(iconDrawable)
                } catch (e: Exception) {
                    // Fallback to null icon if decoding fails
                    iconString = null
                }
            }

            result.add(
                mapOf(
                    "packageName" to pkg,
                    "appName" to appName,
                    "iconBase64" to iconString
                )
            )
        }

        return result.sortedBy { (it["appName"] as? String)?.lowercase() ?: "" }
    }

    fun getTodayUsageStats(packageNames: List<String>? = null): List<Map<String, Any>> {
        if (usageStatsManager == null) return emptyList()

        val cal = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }
        val startTime = cal.timeInMillis
        val endTime = System.currentTimeMillis()

        val usageStats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            startTime,
            endTime
        )

        if (usageStats.isNullOrEmpty()) return emptyList()

        val packageFilter = packageNames?.toSet()
        val aggregatedUsage = mutableMapOf<String, Long>()
        val lastUsedMap = mutableMapOf<String, Long>()

        for (stat in usageStats) {
            val pkg = stat.packageName
            if (packageFilter != null && !packageFilter.contains(pkg)) {
                continue
            }
            val time = stat.totalTimeInForeground / 1000 // Convert to seconds
            aggregatedUsage[pkg] = (aggregatedUsage[pkg] ?: 0L) + time
            if (stat.lastTimeUsed > (lastUsedMap[pkg] ?: 0L)) {
                lastUsedMap[pkg] = stat.lastTimeUsed
            }
        }

        return aggregatedUsage.map { (pkg, duration) ->
            mapOf(
                "packageName" to pkg,
                "durationSeconds" to duration,
                "lastTimeUsed" to (lastUsedMap[pkg] ?: 0L)
            )
        }
    }

    private fun drawableToBase64(drawable: Drawable): String {
        val bitmap = if (drawable is BitmapDrawable && drawable.bitmap != null) {
            drawable.bitmap
        } else {
            val width = if (drawable.intrinsicWidth > 0) drawable.intrinsicWidth else 96
            val height = if (drawable.intrinsicHeight > 0) drawable.intrinsicHeight else 96
            val bmp = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            val canvas = Canvas(bmp)
            drawable.setBounds(0, 0, canvas.width, canvas.height)
            drawable.draw(canvas)
            bmp
        }

        // Scale down to icon size (e.g., 96x96) for performance and light IPC
        val scaled = Bitmap.createScaledBitmap(bitmap, 96, 96, true)
        val stream = ByteArrayOutputStream()
        scaled.compress(Bitmap.CompressFormat.PNG, 85, stream)
        val byteArray = stream.toByteArray()
        return Base64.encodeToString(byteArray, Base64.NO_WRAP)
    }
}


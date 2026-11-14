package com.focusguard.app.native.restrictions

import android.app.Activity
import android.app.AlertDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.view.Gravity
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.focusguard.app.MainActivity

class RestrictionBlockerActivity : Activity() {

    private lateinit var restrictionManager: RestrictionManager
    private var targetPackage: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        restrictionManager = RestrictionManager.getInstance(this)
        targetPackage = intent.getStringExtra("packageName")

        val appLabel = targetPackage?.let { pkg ->
            try {
                val pm = packageManager
                val appInfo = pm.getApplicationInfo(pkg, 0)
                pm.getApplicationLabel(appInfo).toString()
            } catch (e: Exception) {
                pkg
            }
        } ?: "Application"

        // Build premium Dark Navy UI programmatically
        val rootLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setBackgroundColor(Color.parseColor("#0B132B")) // Dark Navy
            setPadding(48, 64, 48, 64)
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT
            )
        }

        // Shield Icon or App Icon
        val iconView = ImageView(this).apply {
            targetPackage?.let { pkg ->
                try {
                    setImageDrawable(packageManager.getApplicationIcon(pkg))
                } catch (e: Exception) {
                    setImageResource(android.R.drawable.ic_lock_lock)
                }
            } ?: setImageResource(android.R.drawable.ic_lock_lock)
            layoutParams = LinearLayout.LayoutParams(160, 160).apply {
                bottomMargin = 32
            }
        }
        rootLayout.addView(iconView)

        // Title
        val titleView = TextView(this).apply {
            text = "FocusGuard Restriction Active"
            textSize = 22f
            setTypeface(null, Typeface.BOLD)
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                bottomMargin = 16
            }
        }
        rootLayout.addView(titleView)

        // Subtitle / App Name
        val subtitleView = TextView(this).apply {
            text = "$appLabel is currently locked"
            textSize = 17f
            setTextColor(Color.parseColor("#48CAE4")) // Cyan accent
            gravity = Gravity.CENTER
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                bottomMargin = 24
            }
        }
        rootLayout.addView(subtitleView)

        // Explanation text card
        val cardLayout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            val cardBg = GradientDrawable().apply {
                setColor(Color.parseColor("#1C2541")) // Deep Navy surface
                cornerRadius = 24f
            }
            background = cardBg
            setPadding(36, 36, 36, 36)
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                bottomMargin = 48
            }
        }

        val explanationText = TextView(this).apply {
            text = "You have reached your configured daily usage limit for this app. Take a deep breath and protect your attention."
            textSize = 14f
            setTextColor(Color.parseColor("#CBD5E1"))
            gravity = Gravity.CENTER
            setLineSpacing(0f, 1.25f)
        }
        cardLayout.addView(explanationText)
        rootLayout.addView(cardLayout)

        // Button: Return to Home
        val homeButton = Button(this).apply {
            text = "Back to Safety (Home)"
            setTextColor(Color.parseColor("#0B132B"))
            textSize = 15f
            setTypeface(null, Typeface.BOLD)
            val btnBg = GradientDrawable().apply {
                setColor(Color.parseColor("#48CAE4")) // Cyan Accent
                cornerRadius = 28f
            }
            background = btnBg
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                120
            ).apply {
                bottomMargin = 16
            }
            setOnClickListener {
                goToHomeScreen()
            }
        }
        rootLayout.addView(homeButton)

        // Button: Emergency Unlock
        val unlockButton = Button(this).apply {
            text = "Emergency Unlock (10 Min)"
            setTextColor(Color.WHITE)
            textSize = 14f
            val btnBg = GradientDrawable().apply {
                setColor(Color.parseColor("#3A506B"))
                cornerRadius = 28f
            }
            background = btnBg
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                110
            ).apply {
                bottomMargin = 16
            }
            setOnClickListener {
                showEmergencyUnlockConfirmation(appLabel)
            }
        }
        rootLayout.addView(unlockButton)

        // Button: Open FocusGuard Dashboard
        val dashboardButton = Button(this).apply {
            text = "Open FocusGuard"
            setTextColor(Color.parseColor("#94A3B8"))
            textSize = 13f
            setBackgroundColor(Color.TRANSPARENT)
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
            setOnClickListener {
                openFocusGuardDashboard()
            }
        }
        rootLayout.addView(dashboardButton)

        setContentView(rootLayout)
    }

    private fun goToHomeScreen() {
        val intent = Intent(Intent.ACTION_MAIN).apply {
            addCategory(Intent.CATEGORY_HOME)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        startActivity(intent)
        finish()
    }

    private fun openFocusGuardDashboard() {
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        }
        startActivity(intent)
        finish()
    }

    private fun showEmergencyUnlockConfirmation(appLabel: String) {
        AlertDialog.Builder(this)
            .setTitle("Confirm Emergency Unlock")
            .setMessage("You have reached your daily limit for $appLabel. Emergency unlock grants a temporary 10-minute window. Are you sure?")
            .setPositiveButton("Yes, Unlock (10m)") { _, _ ->
                targetPackage?.let { pkg ->
                    restrictionManager.grantEmergencyUnlock(pkg, 10)
                }
                finish()
            }
            .setNegativeButton("Cancel", null)
            .show()
    }

    override fun onBackPressed() {
        goToHomeScreen()
    }
}


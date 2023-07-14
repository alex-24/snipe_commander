package com.kcksbots.snipe_commander

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {

    /*private var forService: Intent? = null

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        this.flutterEngine?.let { GeneratedPluginRegistrant.registerWith(it) }

        this.forService = Intent(this@MainActivity, LiquidityWatcherService::class.java)

        MethodChannel(getFlutterView(), "com.retroportalstudio.messages")
                .setMethodCallHandler { methodCall, result ->
                    if (methodCall.method == "startService") {
                        startService()
                        result.success("Service Started")
                    }
                }
    }

    private fun startService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(forService)
        } else {
            startService(forService)
        }
    }*/
}

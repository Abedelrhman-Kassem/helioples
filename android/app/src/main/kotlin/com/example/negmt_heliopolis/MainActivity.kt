package com.example.negmt_heliopolis

import io.flutter.embedding.android.FlutterActivity

import android.view.WindowManager.LayoutParams

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
    }
}

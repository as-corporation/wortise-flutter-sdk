package com.wortise.ads.flutter

import io.flutter.plugin.platform.PlatformView

interface AdWithView {
    fun getPlatformView(adId: String): PlatformView?
}
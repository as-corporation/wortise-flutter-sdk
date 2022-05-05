import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ad_content_rating.dart';
import 'wortise_sdk.dart';

class AdSettings {
  static const CHANNEL_AD_SETTINGS = "${WortiseSdk.CHANNEL_MAIN}/adSettings";

  static const MethodChannel _channel =
      const MethodChannel(CHANNEL_AD_SETTINGS);

  static Future<String?> get assetKey async {
    return await _channel.invokeMethod('getAssetKey');
  }

  static Future<bool> get isChildDirected async {
    return await _channel.invokeMethod('isChildDirected');
  }

  static Future<AdContentRating?> get maxAdContentRating async {
    String? rating = await _channel.invokeMethod('getMaxAdContentRating');

    if (rating == null) {
      return null;
    }

    return AdContentRating.values.firstWhere((r) => describeEnum(r) == rating);
  }

  static Future<void> setChildDirected(bool enabled) async {
    Map<String, dynamic> values = {'enabled': enabled};

    await _channel.invokeMethod('setChildDirected', values);
  }

  static Future<void> setMaxAdContentRating(AdContentRating? rating) async {
    String? name = (rating != null) ? describeEnum(rating) : null;

    Map<String, dynamic> values = {'rating': name};

    await _channel.invokeMethod('setMaxAdContentRating', values);
  }
}

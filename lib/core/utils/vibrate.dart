import 'dart:io';

import 'package:flutter/services.dart';

void vibrate() {
  if (Platform.isAndroid) {
    HapticFeedback.vibrate();
  }
  else {
    HapticFeedback.mediumImpact();
  }
}
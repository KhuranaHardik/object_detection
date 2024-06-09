// Checking wheather value is null or empty.
import 'dart:developer';

import 'package:flutter/foundation.dart';

bool isNullOrEmpty(dynamic value) {
  if (value == null) {
    return true;
  } else {
    if (value is List || value is String) {
      return value.isEmpty;
    } else {
      return value == '';
    }
  }
}

// print debug
printDebug(Object object) {
  if (kDebugMode) {
    log(object.toString());
  }
}

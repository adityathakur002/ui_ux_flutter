import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';

void main(List<String> args) {
  runApp(
    const ProviderScope(child: App()),
  );
}

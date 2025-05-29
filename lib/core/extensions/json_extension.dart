import 'dart:convert';

import 'package:moviewave/core/utils/typedefs.dart';

extension JsonDecodeExtension on String {
  DataMap get toJson => jsonDecode(this);
}

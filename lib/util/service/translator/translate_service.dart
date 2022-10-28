import 'package:easy_localization/easy_localization.dart';

String translate(String? word) {
  if (word != null) {
    /// [translate] ga kelgan [word] bu key.
    /// [word.tr()] qilganda [startLocale] ga berilgan tilni
    /// Json filedan [word] keyga mos value ni qaytaradi
    return word.tr();
  } else {
    return "";
  }
}

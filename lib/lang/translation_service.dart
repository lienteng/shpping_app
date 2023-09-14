import 'package:get/get.dart';
import 'package:shopping_app99/lang/lo.dart';

import 'en.dart';

class TranslationService extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'lo_LO': loLO,
      };
}

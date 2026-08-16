import 'package:todo_app/common/constants/app_texts.dart';

class TodoValidator {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppTexts.titleError;
    }
    return null;
  }
}

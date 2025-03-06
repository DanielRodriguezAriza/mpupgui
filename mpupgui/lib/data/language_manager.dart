enum Language {
  english,
  spanish
}

class LanguageManager {
  static Language language = Language.english;
  static const Map<Language, Map<String, String>> locStrings = {
    Language.english : {
      "loc_language_name" : "English"
    },
    Language.spanish : {
      "loc_language_name" : "Español"
    }
  };

  static void setLanguage(Language language) {
    LanguageManager.language = language;
  }

  static String getString(String locString) {
    var ans = LanguageManager.locStrings[LanguageManager.language]?[locString];
    ans ??= "LOC_NOT_FOUND";
    return ans;
  }
}

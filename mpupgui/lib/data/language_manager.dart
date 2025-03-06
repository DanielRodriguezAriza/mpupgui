enum Language {
  english,
  spanish
}

class LanguageManager {
  static Language currentLanguage = Language.english;
  static const Map<Language, Map<String, String>> locStrings = {
    Language.english : {
      "loc_language_name" : "English"
    },
    Language.spanish : {
      "loc_language_name" : "Español"
    }
  };

  static void setLanguage(Language language) {
    currentLanguage = language;
  }

  static String getStringByLanguage(Language language, String locString) {
    var ans = LanguageManager.locStrings[language]?[locString];
    ans ??= "LOC_NOT_FOUND";
    return ans;
  }


  static String getString(String locString) {
    var ans = LanguageManager.locStrings[currentLanguage]?[locString];
    ans ??= "LOC_NOT_FOUND";
    return ans;
  }
}

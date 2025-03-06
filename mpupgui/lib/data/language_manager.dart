enum Language {
  english,
  spanish
}

class LanguageManager {
  static Language currentLanguage = Language.english;
  static const Map<Language, Map<String, String>> locStrings = {
    Language.english : {
      "loc_language_name" : "English",

      "loc_compile" : "Compile",
      "loc_decompile" : "Decompile",

      "loc_compiler" : "Compiler",
      "loc_decompiler" : "Decompiler",

      "loc_settings" : "Settings"
    },

    Language.spanish : {
      "loc_language_name" : "Español",

      "loc_compile" : "Compilar",
      "loc_decompile" : "Descompilar",

      "loc_compiler" : "Compilador",
      "loc_decompiler" : "Descompilador",

      "loc_settings" : "Opciones"
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
    return getStringByLanguage(currentLanguage, locString);
  }
}

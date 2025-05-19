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

      "loc_settings" : "Settings",

      "loc_theme_light" : "Light Theme",
      "loc_theme_dark" : "Dark Theme",

      "loc_input_file_path" : "Input File Path",
      "loc_console" : "Console",

      "loc_mod_manager" : "Mod Manager",
    },

    Language.spanish : {
      "loc_language_name" : "Español",

      "loc_compile" : "Compilar",
      "loc_decompile" : "Descompilar",

      "loc_compiler" : "Compilador",
      "loc_decompiler" : "Descompilador",

      "loc_settings" : "Opciones",

      "loc_theme_light" : "Tema Claro",
      "loc_theme_dark" : "Tema Oscuro",

      "loc_input_file_path" : "Ruta del Archivo de Entrada",
      "loc_console" : "Consola",

      "loc_mod_manager" : "Instalador de Mods",
    }
  };

  static void setLanguage(Language language) {
    currentLanguage = language;
  }

  static Language getLanguage() {
    return currentLanguage;
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

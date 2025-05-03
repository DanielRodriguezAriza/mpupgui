class ModManager {
  static String pathToInstalls = "./installs";
  static String pathToMods = "./mods";
  static String pathToProfiles = "./profiles";

  static void setPathToInstalls(String path) {
    pathToInstalls = path;
  }

  static void setPathToMods(String path) {
    pathToMods = path;
  }

  static void setPathToProfiles(String path) {
    pathToProfiles = path;
  }

  static String getPathToInstalls() {
    return pathToInstalls;
  }

  static String getPathToMods() {
    return pathToMods;
  }

  static String getPathToProfiles() {
    return pathToProfiles;
  }
}

// NOTE : This is the best we can do to prevent this class from being instantiated and making it static.
// abstract makes it so that we cannot have an explicit constructor unless we make an specific type that inherits from this one.
// final makes it so that the type cannot be inherited.
// With both keywords combined, we pretty much have a static class.
// Not the best design, probably should make these non static in the future and add some instances of handler / manager classes
// to some wrapper widget component so that we can make this into a dart lib or something, but for now this is ok since
// the only consumer of this dart code is this flutter app, so yeah.

class mpup_FileDataInput {

}

class mpup_FileDataOutput {

}

abstract final class MagickaPupManager {

  // MagickaPUP program related data
  static String currentMagickaPupPath = "";

  static void setMagickaPupPath(String path) {
    currentMagickaPupPath = path;
  }

  static String getMagickaPupPath() {
    return currentMagickaPupPath;
  }

  // File related stuff
  static List<mpup_FileDataInput> filesInputData = [];
  static List<mpup_FileDataOutput> filesOutputData = [];

  static void clearInputFiles() {
    filesInputData.clear();
  }

  static void clearOutputFiles() {
    filesOutputData.clear();
  }
}

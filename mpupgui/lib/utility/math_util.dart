// A list of utility functions for simple math operations.

int clampIntValue(int value, int min, int max) {
  value = value < min ? min : value;
  value = value > max ? max : value;
  return value;
}

int clampIntValueMin(int value, int min) {
  value = value < min ? min : value;
  return value;
}

int clampIntValueMax(int value, int max) {
  value = value > max ? max : value;
  return value;
}

double clampDoubleValue(double value, double min, double max) {
  value = value < min ? min : value;
  value = value > max ? max : value;
  return value;
}

double clampDoubleValueMin(double value, double min, double max) {
  value = value < min ? min : value;
  return value;
}

double clampDoubleValueMax(double value, double min, double max) {
  value = value > max ? max : value;
  return value;
}

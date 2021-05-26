extension NumExtension on num {
  bool isBetween (num first, num second) => 
    first <= this && this <= second;
}
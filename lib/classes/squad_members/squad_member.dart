class SquadMember {
  bool _isInfected = false;
  bool _isMutant = false;
  int _countDaysInfected = 0;

  bool get isInfected => _isInfected;

  int get countDaysInfected => _countDaysInfected;

  set countDaysInfected(int value) {
    _countDaysInfected = value;
  }

  bool get isMutant => _isMutant;

  set isMutant(bool value) {
    _isMutant = value;
  }

  set isInfected(bool value) {
    _isInfected = value;
  }
}

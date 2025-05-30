class Squad {
  static final Squad _instance = Squad._internal();

  factory Squad() {
    return _instance;
  }

  Squad._internal() {}
  int _captain = 1;
  int _squad = 3;
  int _antidotCount = 1;
  int _incfectedTeamMember = 0;

  int getSquadMemmbersCount() {
    return _squad;
  }

  void addAntidot() {
    _antidotCount += 1;
  }

  void setSquadMembers(int newValue) {
    if ((_squad - newValue) >= 0) {
      _squad -= newValue;
    }
  }

  set captain(int newValue) {
    if ((_captain - newValue) >= 0) {
      _captain = newValue;
    }
  }

  int getCaptein() {
    return _captain;
  }
}

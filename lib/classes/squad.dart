class Squad {
  static final Squad _instance = Squad._internal();

  factory Squad() {
    return _instance;
  }

  Squad._internal() {}
  int _captain = 1;
  int _squad = 3;
  int _antidotCount = 1;

  int get squadMembersCount => _squad;
  int get antidotCount => _antidotCount;
  int get capatin => _captain;

  set squadMembers(int newValue) {
    if ((_squad - newValue) >= 0) {
      _squad -= newValue;
    }
  }

  set captain(int newValue) {
    if ((_captain - newValue) >= 0) {
      _captain = newValue;
    }
  }

  void addAntidot() {
    _antidotCount += 1;
  }
}

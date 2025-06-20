import 'package:collection/collection.dart';
import 'package:phone_factory/classes/squad_members/squad_member.dart';

class Squad {
  int _captain = 1;
  static const int _initSquadMemberCount = 3;
  List<SquadMember> _squad = [];
  int _antidotCount = 1;
  List<SquadMember> get squad => _squad;

  set squad(List<SquadMember> value) {
    _squad = value;
  }

  Squad() {
    _fillSquad();
  }

  List<SquadMember> get squadMembersCount => _squad;
  int get antidotCount => _antidotCount;
  int get capatin => _captain;

  set captain(int newValue) {
    if ((_captain - newValue) >= 0) {
      _captain = newValue;
    }
  }

  void addAntidot() {
    _antidotCount += 1;
  }

  void _fillSquad() {
    for (var i = 0; i < _initSquadMemberCount; i++) {
      _squad.add(SquadMember());
    }
  }

  void wasInfected() {
    SquadMember? helsyMember = _squad.firstWhereOrNull((member) => member.isInfected == false);
    if (helsyMember == null) {
      print('Нема здоровых членів команди. Перевір Склад команди');
    } else {
      helsyMember.isInfected = true;
      print('Увага!!!Один із єкіпажу інфікований!!!');
    }
  }

  bool isMemberMutant() {
    for (SquadMember member in _squad) {
      if (member.isInfected) {
        if (member.countDaysInfected < 2) {
          member.countDaysInfected++;
        } else {
          _squad.remove(member);
          print('Увага!! Один з членів єкіпажу перетворився на мутанта!!!');
          return true;
        }
      }
    }
    return false;
  }

  int _infectedCount() {
    return _squad.where((member) => member.isInfected).length;
  }

  void showSquadCondition() {
    print('------------------Меню Команди----------------------');
    print(
      'Кількість членів єкіпажу: ${_squad.length}\n'
      'Кількість антидотів: $antidotCount\n'
      'Кількість інфікованих: ${_infectedCount()}',
    );
    print('----------------------------------------------------');
  }

  void useAntidot() {
    SquadMember? infectetdMember = _squad.firstWhereOrNull((member) => member.isInfected == true);
    if (infectetdMember != null) {
      if (_antidotCount > 0) {
        print('Ви викорастали антидот, кількість антидотів: $_antidotCount');
        infectetdMember.isInfected = false;
        print('Один із членів єкіпажу вилікувався');
        _antidotCount--;
      } else {
        print('У вас не вистачає антидотів');
      }
    } else {
      print('Екіпаж здоровий, антидот не потрібен');
    }
  }
}

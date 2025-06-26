import 'package:collection/collection.dart';
import 'package:phone_factory/classes/squad_members/squad_member.dart';

class Squad {
  List<SquadMember> members = [];
  static const int _initSquadMemberCount = 3;
  int _antidotCount = 1;
  int _captain = 1;
  Squad() {
    _fillSquad();
  }
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

  void infectMember() {
    SquadMember? helsyMember = members.firstWhereOrNull((member) => member.isInfected == false);
    if (helsyMember == null) {
      print('Нема здоровых членів команди. Перевір Склад команди');
    } else {
      helsyMember.isInfected = true;
      print('Увага!!!Один із єкіпажу інфікований!!!');
    }
  }

  void showCondition() {
    print('------------------Меню Команди----------------------');
    print(
      'Кількість членів єкіпажу: ${members.length}\n'
      'Кількість антидотів: $antidotCount\n'
      'Кількість інфікованих: ${_getInfectedMembersCount()}',
    );
    print('----------------------------------------------------');
  }

  void useAntidot() {
    SquadMember? infectetdMember = members.firstWhereOrNull((member) => member.isInfected == true);
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

  void _fillSquad() {
    for (var i = 0; i < _initSquadMemberCount; i++) {
      members.add(SquadMember());
    }
  }

  int _getInfectedMembersCount() {
    return members.where((member) => member.isInfected).length;
  }
}

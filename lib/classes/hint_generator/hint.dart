import 'package:phone_factory/classes/bay_item.dart';

class Hint {
  final int bayNumber;
  final BayItem bayItem;

  Hint({required this.bayNumber, required this.bayItem});

  @override
  String toString() => 'Відсік $bayNumber  ${_getBayItemString()}';

  String _getBayItemString() => switch (bayItem) {
    BayItem.infected => 'Інфікований',
    BayItem.hint => 'Є підказка',
    BayItem.antidote => 'Відсік з антидотом',
    BayItem.empty => 'Порожній Відсік',
    BayItem.goal => 'Евакуаційний відсік',
    BayItem.mutant => ' Відсік з мутантом',
  };
}

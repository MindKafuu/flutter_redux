import 'package:my_app2/redux/states/stat_counter.dart';

class CounterViewModel {
  CounterState state;
  Function() onIncreaseCounter;
  Function() onDecreaseCounter;
  Function() onResetCounter;

  CounterViewModel(
      {required this.state,
      required this.onIncreaseCounter,
      required this.onDecreaseCounter,
      required this.onResetCounter});
}

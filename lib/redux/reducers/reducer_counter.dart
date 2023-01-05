import 'package:redux/redux.dart';

import 'package:my_app2/redux/actions/action_counter.dart';
import 'package:my_app2/redux/states/stat_counter.dart';

final counterReducer = combineReducers<CounterState>([
  TypedReducer<CounterState, CounterActions>(setCounter),
  TypedReducer<CounterState, CounterActions>(resetCounter)
]);

CounterState setCounter(CounterState state, CounterActions action) {
  if (action == CounterActions.Increment) {
    state.counter++;
    print(state.counter);
    return state;
  } else if (action == CounterActions.Decrement) {
    state.counter--;
    print(state.counter);
    return state;
  }

  return state;
}

CounterState resetCounter(CounterState state, CounterActions action) {
  if (action == CounterActions.ResetCounter) {
    state.counter = 0;
    print(state.counter);
    return state;
  }

  return state;
}

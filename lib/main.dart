import 'package:flutter/material.dart';
import 'package:my_app2/redux/actions/action_counter.dart';
import 'package:my_app2/redux/middlewares/middleware_counter.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:my_app2/redux/states/stat_counter.dart';
import 'package:my_app2/redux/reducers/reducer_counter.dart';
import 'package:my_app2/redux/view_models/view_model_counter.dart';

void main() {
  Store<CounterState> store = Store<CounterState>(counterReducer,
      middleware: [CounterMiddleware()], initialState: CounterState(0));
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<CounterState> store;
  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Redux App',
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          home: MyHomePage(title: 'My Redux App'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  StoreConnector<CounterState, CounterViewModel>(
                      builder: (context, CounterViewModel model) {
                    return Text(
                      model.state.counter.toString(),
                      style: TextStyle(fontSize: 16),
                    );
                  }, converter: (store) {
                    return CounterViewModel(
                        state: store.state,
                        onIncreaseCounter: () =>
                            store.dispatch(CounterActions.Increment),
                        onDecreaseCounter: () =>
                            store.dispatch(CounterActions.Decrement),
                        onResetCounter: () =>
                            store.dispatch(CounterActions.ResetCounter));
                  })
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomRight, child: buildIncreaseButton()),
            Align(
                alignment: Alignment.bottomLeft, child: buildDecreaseButton()),
            Align(
                alignment: Alignment.bottomCenter, child: buildResetButton()),
          ],
        ));
  }
}

buildIncreaseButton() {
  return Container(
      padding: EdgeInsets.all(20),
      child: StoreConnector<CounterState, CounterViewModel>(
          converter: (store) {
            return CounterViewModel(
                state: store.state,
                onIncreaseCounter: () =>
                    store.dispatch(CounterActions.Increment),
                onDecreaseCounter: () => null,
                onResetCounter: () => null);
          },
          builder: (context, CounterViewModel model) => FloatingActionButton(
                onPressed: model.onIncreaseCounter,
                child: Icon(Icons.add),
              )));
}

buildDecreaseButton() {
  return Container(
    padding: EdgeInsets.all(20),
    child: StoreConnector<CounterState, CounterViewModel>(
      converter: (store) {
        return CounterViewModel(
            state: store.state,
            onIncreaseCounter: () => null,
            onDecreaseCounter: () => store.dispatch(CounterActions.Decrement),
            onResetCounter: () => null);
      },
      builder: (context, CounterViewModel model) => FloatingActionButton(
        onPressed: model.onDecreaseCounter,
        child: Icon(Icons.remove),
      ),
    ),
  );
}

buildResetButton() {
  return Container(
    padding: EdgeInsets.all(20),
    child: StoreConnector<CounterState, CounterViewModel>(
      converter: (store) {
        return CounterViewModel(
            state: store.state,
            onIncreaseCounter: () => null,
            onDecreaseCounter: () => null,
            onResetCounter: () => store.dispatch(CounterActions.ResetCounter));
      },
      builder: (context, CounterViewModel model) => FloatingActionButton(
        onPressed: model.onResetCounter,
        child: Icon(Icons.refresh),
      ),
    ),
  );
}

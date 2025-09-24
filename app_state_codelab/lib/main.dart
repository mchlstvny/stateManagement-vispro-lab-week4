import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyScopedApp());

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class MyScopedApp extends StatelessWidget {
  final CounterModel model = CounterModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(title: Text("Scoped Counter")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Counter: ${model.counter}"),
              ElevatedButton(
                onPressed: model.increment,
                child: Text("Increment"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SecondPage()),
                  );
                },
                child: Text("Go to Second Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Counter Value: ${model.counter}"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: model.increment,
                child: Text("Increment from Second Page"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Back to CounterPage"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

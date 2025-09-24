# Flutter State Management Codelab

This project discusses two types of state management in Flutter:  
1. **Ephemeral State (StatefulWidget + setState)**  
2. **App State (Scoped Model)**  

---

## What is State?
**State** is data that affects the appearance of the application.  
Example: counter numbers, user auth data, shopping cart contents.

---

## 1. Ephemeral State
### Concept
- *Ephemeral* = temporary, only lives in one widget.  
- Data is stored directly in `StatefulWidget`.  
- Suitable for **local** state, for example: counters, toggles, form fields.
### Code snippet
```dart
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter Value: $_counter'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```
The data is only used by one widget.<br>
Examples: simple form, local toggle button.

## 2. App State with Scoped Model
### Concept
- *Scope* = (lingkup in indonesian), so it means that data can be accessed by many widgets within that scope.
- State is stored in a separate Model.
- All widgets within ScopedModel can access data without prop-drilling
(prop-drilling: passing data through multiple widget levels unnecessarily just to get it to the widget that needs it.)<br>
Simple analogy so i can understand it easier:<br>
Prop-drilling is like giving a note to your friend in the back of the class by passing it through every student in between.
### Code snippet
```dart
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Counter Value: $_counter'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```
### Using in Widget
```dart
ScopedModelDescendant<CounterModel>(
  builder: (context, child, model) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Counter Value: ${model.counter}'),
      ElevatedButton(
        onPressed: model.increment,
        child: Text('Increment'),
      ),
    ],
  ),
)
```
Data is needed by many widgets.<br>
Examples: shopping cart, user authentication, application themes.

---

## Observation
At first, I couldn’t clearly see the difference between the examples, since one only showed increment while the other included both 
increment and decrement. To explore this further, I added a new widget (a second page). By doing this, the concept became clearer to me, that 
with ScopedModel, the state can be accessed globally across different widgets / pages, without needing to pass data manually.<br>

### Ephemeral State (Codelab)
- The counter value only applies within a single widget.

### Scoped Model (Codelab)
- The counter value can be accessed from anywhere within the scope, making it more flexible for larger applications.

### Personal Experiment (Adding Page 1 & Page 2)
When I tried adding navigation between pages:<br>
- Ephemeral State : The counter did not carry over to the second page because its state is local.
- Scoped Model : The counter is carried over to the second page, and can even be incremented directly from the second page,
- then its value is automatically updated on the first page as well.

---

## Conclusion
### Ephemeral State (StatefulWidget): <br>
- Best for small and simple cases.
-  The state lives only inside the widget itself, making it suitable for things like a simple counter or a single-page form.
-  If the data needs to be shared across multiple pages, it must be passed manually through constructors, which can make things complicated.

### Scoped Model (App State Management):
- Better for larger applications.
- The data is stored in a dedicated model that can be accessed or updated from anywhere in the scope.
- When the data changes, all widgets that depend on it automatically update. 
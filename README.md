# Remote Devtools for flutter_bloc

## Progress
Fork of https://github.com/andrea689/flutter_bloc_devtools, which doesn't support v8.0.0 of bloc.
This currently has rudimentary support for v8.0.0. It is a work in progress.

NOTE: In general, I don't recommend using this devtool unless you have a large amount of blocs and messages to deal with. For a small number of blocs, it is easier just to use [BlocObserver](https://bloclibrary.dev/#/coreconcepts?id=blocobserver) to log all bloc actions, which takes about 5-10 minutes to setup. See examples in the tutorials in https://bloclibrary.dev/

- [x] I got `flutter_bloc_devtools` to work with the example code. (see also the git branch "null_safety_migration")
- [ ] Doesn't deal well with enumerate types.
- [ ] Works with flutter_todos tutorial, v8.
- [ ] Write tests
- [ ] Update the package in pub.dev

Create an issue if you want to help.


## Original docs

Remote Devtools support for Blocs of [flutter_bloc](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc).

N.B. `Cubit` is *now* supported

![Devtools Demo](https://github.com/andrea689/flutter_bloc_devtools/raw/main/demo.gif)

## Installation

Add the library to pubspec.yaml:

```yaml
dependencies:
  flutter_bloc_devtools:
    git:
      url: https://github.com/chonghorizons/flutter_bloc_devtools.git
      ref: main
```

Note: The version on pub.dev doesn't work with null safety and v8 of bloc.

## BlocObserver configuration

Add `RemoteDevToolsObserver` to your `Bloc.observer`:

```dart
void main() async {
  BlocOverrides.runZoned(
        () async => runApp(const CounterApp()),
    blocObserver: RemoteDevToolsObserver('127.0.0.1:8000'),
  );
}
```

## Making your Events and States Mappable

Events and States ~~have to~~ may implement `Mappable`:

```dart
class CounterState extends Equatable implements Mappable {
  final int counter;

  const CounterState({
    this.counter,
  });

  @override
  List<Object> get props => [
        counter,
      ];

  @override
  Map<String, dynamic> toMap() => {
        'counter': counter,
      };
}
```

## Using remotedev

Use the Javascript [Remote Devtools](https://github.com/zalmoxisus/remotedev-server) package. Start the remotedev server on your machine

```bash
npm install -g remotedev-server
remotedev --port 8000
```

Run your application. It will connect to the remotedev server. You can now debug your flutter_bloc application by opening up `http://localhost:8000` in a web browser.

## Examples

- [Counter](example/counter)


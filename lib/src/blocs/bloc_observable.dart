import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_form1/main.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('$event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('$transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('$error');
  }
}





















// void main() {
//   Bloc.observer = SimpleBlocObserver();
//   runApp(const MyApp());
// }

// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onEvent(Bloc bloc, Object? event) {
//     super.onEvent(bloc, event);
//     debugPrint('$event');
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     debugPrint('$transition');
//   }
//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     super.onError(bloc, error, stackTrace);
//     debugPrint('$error');
//   }
// }














import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/srvices/auth/auth_services.dart';
import 'package:todo_app/srvices/auth/bloc/auth_bloc.dart';
import 'package:todo_app/srvices/auth/bloc/auth_events.dart';
import 'package:todo_app/srvices/auth/bloc/bloc_states.dart';
import 'login_view.dart';
import 'notesView/notes_view.dart';
import 'verify_email_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitilize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Bloc Provider"),
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           listener: (context, state) {
//             _controller.clear();
//           },
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalidNumber) ? state.invalidValue : " ";
//             return Column(
//               children: [
//                 Text("Current Value => ${state.val}"),
//                 Visibility(
//                   visible: state is CounterStateInvalidNumber,
//                   child: Text("Invalid Value: $invalidValue"),
//                 ),
//                 TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(hintText: 'Enter a numbre'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context.read<CounterBloc>().add(
//                               IncrementEvent(_controller.text),
//                             );
//                       },
//                       child: const Text("+"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         context.read<CounterBloc>().add(
//                               DecrementEvent(_controller.text),
//                             );
//                       },
//                       child: const Text("-"),
//                     )
//                   ],
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int val;

//   const CounterState(this.val);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int val) : super(val);
// }

// class CounterStateInvalidNumber extends CounterState {
//   final String invalidValue;
//   const CounterStateInvalidNumber({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;

//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String val) : super(val);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String val) : super(val);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncrementEvent>(
//       (event, emit) {
//         final integer = int.tryParse(event.value);
//         if (integer == null) {
//           emit(CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.val,
//           ));
//         } else {
//           emit(
//             CounterStateValid(state.val + integer),
//           );
//         }
//       },
//     );
//     on<DecrementEvent>(
//       (event, emit) {
//         final integer = int.tryParse(event.value);
//         if (integer == null) {
//           emit(CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.val,
//           ));
//         } else {
//           emit(
//             CounterStateValid(state.val - integer),
//           );
//         }
//       },
//     );
//   }
// }

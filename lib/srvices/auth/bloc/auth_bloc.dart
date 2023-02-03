import 'package:bloc/bloc.dart';
import 'package:todo_app/srvices/auth/auth_provider.dart';
import 'package:todo_app/srvices/auth/bloc/auth_events.dart';
import 'package:todo_app/srvices/auth/bloc/bloc_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    on<AuthEventInitilize>((event, emit) async {
      //initilize
      await provider.initilize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(null));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    //login
    on<AuthEventLogIn>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.login(
            email: email,
            password: password,
          );
          emit(AuthStateLoggedIn(user));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(e));
        }
      },
    );
    //log out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          emit(const AuthStateLoading());
          await provider.logOut();
          emit(const AuthStateLoggedOut(null));
        } on Exception catch (e) {
          emit(AuthStateLogOutFaliure(e));
        }
      },
    );
  }
}

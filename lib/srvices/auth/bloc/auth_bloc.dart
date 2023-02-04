import 'package:bloc/bloc.dart';
import 'package:todo_app/srvices/auth/auth_provider.dart';
import 'package:todo_app/srvices/auth/bloc/auth_events.dart';
import 'package:todo_app/srvices/auth/bloc/bloc_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitilized()) {
    on<AuthEventSentEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(
            email: email,
            password: password,
          );
          await provider.sendEmailVerification();
          emit(const AuthStateNeedVerification());
        } on Exception catch (e) {
          emit(
            AuthStateRegistering(e),
          );
        }
      },
    );
    on<AuthEventInitilize>((event, emit) async {
      //initilize
      await provider.initilize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    //login
    on<AuthEventLogIn>(
      (event, emit) async {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: true,
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.login(
            email: email,
            password: password,
          );
          if (!user.isEmailVerified) {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: false,
              ),
            );
            emit(const AuthStateNeedVerification());
          } else {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: false,
              ),
            );
            emit(AuthStateLoggedIn(user));
          }
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ));
        }
      },
    );
    //log out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
  }
}

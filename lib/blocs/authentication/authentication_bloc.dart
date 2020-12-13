import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbunge/models/http/_http.dart';
import 'package:mbunge/repository/share_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SharePreferenceRepo sharePreferenceRepo;
  AuthenticationBloc(this.sharePreferenceRepo) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedIn(event.user);
    } else if (event is LoggedOut) {
      sharePreferenceRepo.clearSharePreferences();
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield AuthenticationInitial();
    String token = await sharePreferenceRepo.getToken();

    print("#######: $token");
    if (token == null || token.isEmpty) {
      yield UnAuthenticated();
    } else {
      String userJson = await sharePreferenceRepo.getUsert();
      print(userJson);
      yield Authenticated(user: LoginUser());
    }
  }

  Stream<AuthenticationState> _mapLoggedIn(LoginUser user) async* {
    yield Authenticated(user: user);
  }
}

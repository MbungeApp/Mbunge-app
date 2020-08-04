abstract class UserInterface {
  userLogin();
  userRegistration();
  userVerification();
  userForgetPassword();
}

class UserRepository implements UserInterface {
  @override
  userForgetPassword() {
    // TODO: implement userForgetPassword
    throw UnimplementedError();
  }

  @override
  userLogin() {
    // TODO: implement userLogin
    throw UnimplementedError();
  }

  @override
  userRegistration() {
    // TODO: implement userRegistration
    throw UnimplementedError();
  }

  @override
  userVerification() {
    // TODO: implement userVerification
    throw UnimplementedError();
  }
}

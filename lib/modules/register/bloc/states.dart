import 'package:onboarding_screen/models/register_model.dart';

abstract class RegisterState {}

class RegisterIntializState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class VerifyEmailLoadingState extends RegisterState {}
class VerifyEmailSuccessState extends RegisterState {}
class VerifyEmailErrorState extends RegisterState {}

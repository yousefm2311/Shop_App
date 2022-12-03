import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/register_model.dart';
import 'package:onboarding_screen/modules/register/bloc/states.dart';
import 'package:onboarding_screen/shared/network/remote/dio.dart';

import '../../../shared/network/endpoint.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterIntializState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    Dio_Helper.postData(url: REGISTER, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}

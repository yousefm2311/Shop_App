import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/shared/states/states.dart';

class AppCubit extends Cubit<ShopStates>{
  AppCubit():super(AppInstailzation());

  static AppCubit get(context) => BlocProvider.of(context);


}
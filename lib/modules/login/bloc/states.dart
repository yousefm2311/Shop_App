// ignore_for_file: non_constant_identifier_names

import 'package:onboarding_screen/models/changepassword_model.dart';
import 'package:onboarding_screen/models/favorite_model.dart';
import 'package:onboarding_screen/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopAppintializationStates extends ShopLoginStates {}

class ShopPostSuccessStates extends ShopLoginStates {
  final Login_Model login_model;

  ShopPostSuccessStates(this.login_model);
}

class ShopPostLoadingStates extends ShopLoginStates {}

class ShopPostErrorStates extends ShopLoginStates {
  final String error;
  ShopPostErrorStates(this.error);
}

class ShopChangeBottomNaviStates extends ShopLoginStates {}

class ShopAppThemeStates extends ShopLoginStates {}

class ShopChangePasswordStates extends ShopLoginStates {}

class ShopPostFavoriteSuccessState extends ShopLoginStates {
  final FavoritePostModel favoritePostModel;

  ShopPostFavoriteSuccessState(this.favoritePostModel);
}

class ShopGetFavoriteSuccessState extends ShopLoginStates {}

class ShopGetLoadingFavoriteSuccessState extends ShopLoginStates {}

class ShopGetFavoriteErrorState extends ShopLoginStates {}

class ShopPostFavoriteErrorState extends ShopLoginStates {}

class ShopLoagingFavoriteSuccessState extends ShopLoginStates {}

class ShopGetDataHomeSuccessState extends ShopLoginStates {}

class ShopGetDataCategorySuccessState extends ShopLoginStates {}

class ShopGetDataCategoryErrorState extends ShopLoginStates {
  final String error;
  ShopGetDataCategoryErrorState(this.error);
}

class ShopGetDataHomeLoadingState extends ShopLoginStates {}

class ShopGetDataHomeErrorState extends ShopLoginStates {
  final String error;
  ShopGetDataHomeErrorState(this.error);
}

class ShopLoadingUserData extends ShopLoginStates {}

class ShopSuccessUserData extends ShopLoginStates {}

class ShopErrorUserData extends ShopLoginStates {}

class ShopChangeBottomSheetStates extends ShopLoginStates {}

class ShopUserUpdateLoadingState extends ShopLoginStates {}

class ShopUserUpdateSuccessState extends ShopLoginStates {}

class ShopUserUpdateErrorState extends ShopLoginStates {}

class ShopChangePasswordLoadingState extends ShopLoginStates {}

class ShopChangePasswordSuccessState extends ShopLoginStates {
  final ChangePasswordModel changePasswordModel;

  ShopChangePasswordSuccessState(this.changePasswordModel);
}

class ShopChangePasswordErrorState extends ShopLoginStates {}

class ShopSearchLoadingSate extends ShopLoginStates {}

class ShopSearchSuccessSate extends ShopLoginStates {}

class ShopSearchErrorSate extends ShopLoginStates {}


class ChangeCurrenIndexAdd extends ShopLoginStates {}
class ChangeCurrenIndexRemove extends ShopLoginStates {}

class ShopAddCartLoadingState extends ShopLoginStates {}
class ShopAddCartSuccessState extends ShopLoginStates {}
class ShopAddCartErrorState extends ShopLoginStates {}

class ShopGetDataLoadingCart extends ShopLoginStates {}
class ShopGetDataSuccessCart extends ShopLoginStates {}
class ShopGetDataErrorCart extends ShopLoginStates {}

class ChangeCartBoolState extends ShopLoginStates {}
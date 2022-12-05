// ignore_for_file: non_constant_identifier_names

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

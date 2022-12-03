import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/favorite_model.dart';
import 'package:onboarding_screen/modules/cart/cart.dart';
import 'package:onboarding_screen/modules/categories/category.dart';
import 'package:onboarding_screen/modules/favorite/favorite.dart';
import 'package:onboarding_screen/modules/settinges/setting.dart';
import 'package:onboarding_screen/layout/shopapp/shopapp.dart';
import 'package:onboarding_screen/models/category_model.dart';
import 'package:onboarding_screen/models/home_model.dart';
import 'package:onboarding_screen/models/login_model.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/shared/component/constants.dart';
import 'package:onboarding_screen/shared/network/endpoint.dart';
import 'package:onboarding_screen/shared/network/remote/dio.dart';

import '../../../models/favorite_data_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopAppintializationStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void darkTheme() {
    isDark = !isDark;
    emit(ShopAppThemeStates());
  }

  bool isPassword = true;
  void changePassword() {
    isPassword = !isPassword;
    emit(ShopChangePasswordStates());
  }

  int currentIndex = 0;
  void changeBottomNavi(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaviStates());
  }

  List<Widget> screens = const [
    ShopAppLayout(),
    Categories_Screen(),
    Favorite_Screen(),
    Settings_Screen(),
  ];

  Login_Model? login_model;
  void userLogin({required String email, required String password}) {
    emit(ShopPostLoadingStates());
    Dio_Helper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      login_model = Login_Model.fromJson(value.data);
      emit(ShopPostSuccessStates(login_model!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopPostErrorStates(error.toString()));
    });
  }

  Map<int, bool> favoriteMap = {};
  Home_Model? home_model;
  void homeData() {
    emit(ShopGetDataHomeLoadingState());
    Dio_Helper.getData(url: HOME, token: token).then((value) {
      home_model = Home_Model.fromJson(value.data);
      home_model!.data!.products.forEach((element) {
        favoriteMap.addAll({element.id!: element.in_favorites!});
      });
      print(favoriteMap);
      emit(ShopGetDataHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetDataHomeErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  void categoryData() {
    Dio_Helper.getData(url: CATEGORY, token: token).then((value) {
      categoryModel = CategoryModel.formJson(value.data);
      emit(ShopGetDataCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetDataCategoryErrorState(error.toString()));
    });
  }

  FavoritePostModel? favoritePostModel;
  void changeFavorite(int productId) {
    favoriteMap[productId] = !favoriteMap[productId]!;
    emit(ShopLoagingFavoriteSuccessState());
    Dio_Helper.postData(url: FAVORITES, token: token, data: {
      'product_id': productId,
    }).then((value) {
      favoritePostModel = FavoritePostModel.fromJson(value.data);
      print(value.data);
      if (!favoriteModel!.status!) {
        favoriteMap[productId] = !favoriteMap[productId]!;
      } else {
        favoriteData();
      }
      emit(ShopPostFavoriteSuccessState());
    }).catchError((error) {
      favoriteMap[productId] = !favoriteMap[productId]!;
      emit(ShopPostFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;
  void favoriteData() {
    emit(ShopGetLoadingFavoriteSuccessState());
    Dio_Helper.getData(url: FAVORITES, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopGetFavoriteSuccessState());
    }).catchError((error) {
      emit(ShopGetFavoriteErrorState());
    });
  }
}

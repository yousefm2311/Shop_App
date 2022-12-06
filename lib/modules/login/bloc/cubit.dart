// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/changepassword_model.dart';
import 'package:onboarding_screen/models/favorite_model.dart';
import 'package:onboarding_screen/models/search_model.dart';
import 'package:onboarding_screen/models/updateuser_model.dart';
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

  List<Widget> screens = [
    const ShopAppLayout(),
    const Categories_Screen(),
    const Favorite_Screen(),
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
      emit(ShopGetDataHomeSuccessState());
    }).catchError((error) {
      emit(ShopGetDataHomeErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  void categoryData() {
    Dio_Helper.getData(url: CATEGORY, token: token).then((value) {
      categoryModel = CategoryModel.formJson(value.data);
      emit(ShopGetDataCategorySuccessState());
    }).catchError((error) {
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
      if (!favoritePostModel!.status!) {
        favoriteMap[productId] = !favoriteMap[productId]!;
      } else {
        favoriteData();
      }
      emit(ShopPostFavoriteSuccessState(favoritePostModel!));
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

  Login_Model? userModel;
  void getDataUser() {
    emit(ShopLoadingUserData());
    Dio_Helper.getData(url: PROFILE, token: token).then(
      (value) {
        userModel = Login_Model.fromJson(value.data);
        emit(ShopSuccessUserData());
      },
    ).catchError((error) {
      emit(ShopErrorUserData());
    });
  }

  bool isBottom = false;
  void changeBottom(bool isclick) {
    isBottom = isclick;
    emit(ShopChangeBottomSheetStates());
  }

  UpdateUserModel? updateUserModel;
  void updateUser({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUserUpdateLoadingState());
    Dio_Helper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      updateUserModel = UpdateUserModel.fromJson(value.data);
      getDataUser();
      emit(ShopUserUpdateSuccessState());
    }).catchError((error) {
      emit(ShopUserUpdateErrorState());
    });
  }



  ChangePasswordModel? changePasswordModel;
  void changePasswordData(
      {required String oldPassword, required String newPassword}) {
    emit(ShopChangePasswordLoadingState());
    Dio_Helper.postData(url: CHAMGEPASSWORD, token: token, data: {
      'current_password': oldPassword,
      'new_password': newPassword
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);
      emit(ShopChangePasswordSuccessState(changePasswordModel!));
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError(() {
      emit(ShopChangePasswordErrorState());
    });
  }

  SearchModel? searchModel;
  void searchData({required String text}) {
    emit(ShopSearchLoadingSate());
    Dio_Helper.postData(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessSate());
    }).catchError((error) {
      emit(ShopSearchErrorSate());
    });
  }
}

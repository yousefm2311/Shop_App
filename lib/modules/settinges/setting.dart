// ignore_for_file: camel_case_types, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/login.dart';
import 'package:onboarding_screen/shared/component/component.dart';
import 'package:onboarding_screen/shared/network/local/cache_helper.dart';

import '../login/bloc/states.dart';

class Settings_Screen extends StatelessWidget {
  Settings_Screen({super.key});
  var bottomSheet = GlobalKey<ScaffoldState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
      ShopLoginCubit cubit = ShopLoginCubit.get(context);
      nameController.text = cubit.userModel!.data!.name!;
      emailController.text = cubit.userModel!.data!.email!;
      phoneController.text = cubit.userModel!.data!.phone!;
      return Scaffold(
        key: bottomSheet,
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FadeInUp(
          delay: const Duration(milliseconds: 250),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black.withOpacity(0.1),
                  child: Image(
                    image: cubit.userModel!.data!.image!.isEmpty
                        ? NetworkImage('${cubit.userModel!.data!.image}')
                        : const NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "${cubit.userModel!.data!.name}",
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${cubit.userModel!.data!.email}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                buildContainer('Edit Profile', icon: Icons.edit, ontab: () {
                  if (cubit.isBottom) {
                    Navigator.pop(context);
                  } else {
                    bottomSheet.currentState!
                        .showBottomSheet(
                          (context) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (state is ShopUserUpdateSuccessState)
                                  const LinearProgressIndicator(),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  text: "Name",
                                  controller: nameController,
                                  context: context,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  text: "Email",
                                  controller: emailController,
                                  context: context,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  text: "Phone",
                                  controller: phoneController,
                                  context: context,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                buildButton("Save", color: Colors.blue,
                                    onpressed: () {
                                  cubit.updateUser(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                  Navigator.pop(context);
                                })
                              ],
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottom(false);
                    });
                    cubit.changeBottom(true);
                  }
                }),
                const SizedBox(
                  height: 20.0,
                ),
                buildContainer('Change Password',
                    icon: Icons.lock_reset_rounded, ontab: () {
                  showDialog(
                      context: (context),
                      builder: (context) {
                        return Form(
                          key: formKey,
                          child: AlertDialog(
                            title: const Text("Change Password",
                                style: TextStyle(fontSize: 12)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Old Password is Empty";
                                    }
                                    return null;
                                  },
                                  text: 'Old Password',
                                  controller: oldpasswordController,
                                  context: context,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "New Password Required";
                                    }
                                    return null;
                                  },
                                  text: 'New Password',
                                  controller: newPasswordController,
                                  context: context,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultFormField(
                                  validator: (value) {
                                    if (value != newPasswordController.text) {
                                      return "Confirm password different from new password";
                                    }
                                    return null;
                                  },
                                  text: 'Confirm Password',
                                  controller: confirmPasswordController,
                                  context: context,
                                ),
                              ],
                            ),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: ConditionalBuilder(
                                    condition: state
                                        is! ShopChangePasswordLoadingState,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.deepOrange),
                                        alignment: Alignment.center,
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.changePasswordData(
                                                  oldPassword:
                                                      oldpasswordController
                                                          .text,
                                                  newPassword:
                                                      confirmPasswordController
                                                          .text);
                                              oldpasswordController.text = '';
                                              newPasswordController.text = '';
                                              confirmPasswordController.text =
                                                  '';
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text(
                                            "Change Password",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator())),
                              ),
                              const SizedBox(
                                height: 20.0,
                              )
                            ],
                          ),
                        );
                      });
                }),
                const SizedBox(
                  height: 20.0,
                ),
                buildContainer(
                  'Languages',
                  icon: Icons.language,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                buildContainer(
                  'Mode ',
                  icon: Icons.dark_mode_rounded,
                ),
                const Spacer(),
                buildButton("Logout", color: Colors.red, onpressed: () {
                  Cache_Helper.removeToken(key: 'token').then((value) {
                    if (value) {
                      defaultNavigator(context, Login_Screen());
                    }
                  });
                }),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is ShopChangePasswordSuccessState) {
        if (state.changePasswordModel.status!) {
          defaultToast(
              text: state.changePasswordModel.message!,
              color: ToastColor.SUCCESS);
        } else {
          defaultToast(
              text: state.changePasswordModel.message!,
              color: ToastColor.WANING);
        }
      }
    });
  }

  Widget buildContainer(String text, {IconData? icon, VoidCallback? ontab}) =>
      InkWell(
        onTap: ontab,
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
                Icon(icon)
              ],
            ),
          ),
        ),
      );

  Widget buildButton(String text, {Color? color, void Function()? onpressed}) =>
      Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12.0)),
        child: MaterialButton(
          onPressed: onpressed,
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        ),
      );
}

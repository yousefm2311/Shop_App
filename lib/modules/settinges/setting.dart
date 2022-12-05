// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/shared/component/component.dart';

import '../login/bloc/states.dart';

class Settings_Screen extends StatelessWidget {
  Settings_Screen({super.key});
  var bottomSheet = GlobalKey<ScaffoldState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
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
            body: Padding(
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
                  buildContainer(
                    'Change Password',
                    icon: Icons.lock_reset_rounded,
                  ),
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
                  buildButton("Logout", color: Colors.red),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
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

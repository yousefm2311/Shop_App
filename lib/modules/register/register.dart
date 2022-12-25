// ignore_for_file: camel_case_types, must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/home/home.dart';
import 'package:onboarding_screen/modules/login/login.dart';
import 'package:onboarding_screen/modules/register/bloc/cubit.dart';
import 'package:onboarding_screen/modules/register/bloc/states.dart';
import 'package:onboarding_screen/shared/component/component.dart';
import 'package:onboarding_screen/shared/network/local/cache_helper.dart';

import '../../shared/component/constants.dart';

class Register_Screen extends StatelessWidget {
  Register_Screen({super.key});

  var emailRegister = TextEditingController();
  var passwordRegister = TextEditingController();
  var phoneRegister = TextEditingController();
  var nameRegister = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        builder: ((context, state) {
      RegisterCubit cubit = RegisterCubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: FadeInDownBig(
          delay: const Duration(milliseconds: 200),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Image(
                      height: 250,
                      width: 250,
                      image: AssetImage('assets/images/8.png'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name isEmpty';
                        }
                        return null;
                      },
                      text: 'name',
                      controller: nameRegister,
                      context: context,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      text: 'Phone',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone isEmpty';
                        }
                        return null;
                      },
                      controller: phoneRegister,
                      context: context,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      text: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email isEmpty';
                        }
                        return null;
                      },
                      controller: emailRegister,
                      context: context,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      text: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password isEmpty';
                        }
                        return null;
                      },
                      controller: passwordRegister,
                      context: context,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: nameRegister.text,
                                    phone: phoneRegister.text,
                                    email: emailRegister.text,
                                    password: passwordRegister.text);
                              }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        );
                      },
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        ElevatedButton(
                            onPressed: () {
                              defaultNavigatorPush(context, Login_Screen());
                            },
                            child: const Text('Login'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }), listener: (context, state) {
      if (state is RegisterSuccessState) {
        if (state.registerModel.status!) {
          Cache_Helper.saveData(
                  key: 'token', value: state.registerModel.data!.token)
              .then((value) {
            token = state.registerModel.data!.token;
            defaultToast(
                text: state.registerModel.message!, color: ToastColor.SUCCESS);
            defaultNavigatorPush(context, Home_Screen());
          });
        } else {
          defaultToast(
              text: state.registerModel.message!, color: ToastColor.ERROR);
        }
      }
    });
  }
}

// ignore_for_file: camel_case_types, must_be_immutable, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/home/home.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/modules/register/register.dart';
import 'package:onboarding_screen/shared/component/constants.dart';
import 'package:onboarding_screen/shared/network/local/cache_helper.dart';
import '../../shared/component/component.dart';

class Login_Screen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      builder: (context, state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.light_mode),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage(
                            'assets/images/6.png',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Welcome Back,',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Login to continue',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      context: context,
                      controller: emailController,
                      suffix: Icons.email,
                      text: 'Email',
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    defaultFormField(
                      context: context,
                      suffixButton: () {
                        cubit.changePassword();
                      },
                      isPassword: cubit.isPassword,
                      controller: passwordController,
                      suffix: cubit.isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      text: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Forget Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopPostLoadingStates,
                      builder: (BuildContext context) => Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: MaterialButton(
                          textColor: Colors.white,
                          minWidth: 400,
                          height: 50,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      fallback: (BuildContext context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont\'t have an account?',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            defaultNavigatorPush(context, Register_Screen());
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ShopPostSuccessStates) {
          if (state.login_model.status!) {
            Cache_Helper.saveData(
                    key: 'token', value: state.login_model.data!.token)
                .then((value) {
                  token = state.login_model.data!.token;
              defaultNavigator(context, const Home_Screen());
            });
            defaultToast(
                text: state.login_model.message!, color: ToastColor.SUCCESS);
          } else {
            defaultToast(
                text: state.login_model.message!, color: ToastColor.ERROR);
          }
        }
      },
    );
  }
}

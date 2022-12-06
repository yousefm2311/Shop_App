// ignore_for_file: camel_case_types, unnecessary_brace_in_string_interps, unused_local_variable, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/shared/style/colors.dart';

class Description_Screen extends StatelessWidget {
  const Description_Screen({
    super.key,
    this.name,
    this.price,
    this.description,
    this.in_favorite,
    this.productId,
    this.image,
  });
  final name;
  final price;
  final description;
  final in_favorite;
  final productId;
  final image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: cubit.favoriteMap[productId]!
                        ? defaultColor
                        : Colors.grey.shade300,
                    child: IconButton(
                      color: cubit.favoriteMap[productId]!
                          ? Colors.white
                          : defaultColor,
                      onPressed: () {
                        cubit.changeFavorite(productId);
                      },
                      icon: cubit.favoriteMap[productId]!
                          ? const Icon(Icons.favorite)
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    ),
                  ),
                ),
              ],
              title: const Text(
                "Details Product",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: buildProduct(),
          );
        },
        listener: (context, state) {});
  }

  Widget buildProduct() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    14.0,
                  ),
                ),
                child: Image(
                  image: NetworkImage(
                    '${image}',
                  ),
                ),
              ),
              Text(
                "${name}",
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
                maxLines: 2,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(3)),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Save 20%',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Information',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                '${description}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      );
}

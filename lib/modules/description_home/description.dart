// ignore_for_file: camel_case_types, unnecessary_brace_in_string_interps, unused_local_variable, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/shared/style/colors.dart';

class Description_Screen extends StatelessWidget {
  Description_Screen({
    super.key,
    this.name,
    this.price,
    this.description,
    this.in_favorite,
    this.productId,
    this.image,
    this.oldPrice,
    this.discount,
    this.result,
    this.in_cart,
  });
  final name;
  final price;
  final description;
  final in_favorite;
  final productId;
  final image;
  final oldPrice;
  final discount;
  final result;
  final in_cart;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          // cubit.in_cart = in_cart;
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
            body: buildProduct(context),
            bottomSheet: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade400.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${price} EGP',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: in_cart == true
                        ? MaterialButton(
                            onPressed: () {
                              cubit.postCart(productId: productId);
                              cubit.changeCartBool();
                            },
                            child: const Text(
                              'Remove',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : MaterialButton(
                            onPressed: () {
                              cubit.postCart(productId: productId);
                              cubit.changeCartBool();
                            },
                            child: const Text(
                              'Add To Cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget buildProduct(context) => Padding(
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
                  child: Image.network('${image}')),
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
              discount != 0
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Save ${result.round().abs()}\%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text(
                    'Information',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  // if (ShopLoginCubit.get(context).currentIndexCart == 0)
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: ShopLoginCubit.get(context).currentIndexCart != 1
                        ? () {
                            ShopLoginCubit.get(context)
                                .changeCurrentIndexRemove(price);
                          }
                        : null,
                    icon: const Icon(Icons.remove_circle),
                  ),
                  Text('${ShopLoginCubit.get(context).currentIndexCart}'),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ShopLoginCubit.get(context).changeCurrentIndexAdd(price);
                    },
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
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
              const SizedBox(
                height: 100.0,
              ),
            ],
          ),
        ),
      );
}

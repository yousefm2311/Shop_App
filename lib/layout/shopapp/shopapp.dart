import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/category_model.dart';
import 'package:onboarding_screen/models/home_model.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/shared/style/colors.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      builder: ((context, state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            builder: (context) => productBuilder(
                cubit.home_model!, cubit.categoryModel!, context),
            condition: cubit.home_model != null && cubit.categoryModel != null,
            fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      }),
      listener: ((context, state) {}),
    );
  }

  Widget productBuilder(
          Home_Model model, CategoryModel cateorymodel, context) =>
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${e.image}',
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: const Duration(seconds: 3),
                  scrollDirection: Axis.horizontal),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            buildCategories(cateorymodel.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 5.0,
                            ),
                        itemCount: cateorymodel.data!.data.length),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Product",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.4,
                children: List.generate(
                  model.data!.products.length,
                  ((index) => buildGridView(
                        model.data!.products[index],
                        context,
                      )),
                ),
              ),
            )
          ],
        ),
      );
  Widget buildGridView(ProductData model, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: 150,
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    width: double.infinity,
                    height: 160,
                    image: NetworkImage('${model.image}'),
                  ),
                  if (model.discount != 0)
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        color: Colors.red.withOpacity(.8),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Text(
                    '${model.price} EG',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.old_price}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor:
                        ShopLoginCubit.get(context).favoriteMap[model.id]!
                            ? defaultColor
                            : Colors.grey,
                    radius: 16.0,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ShopLoginCubit.get(context).changeFavorite(model.id!);
                      },
                      icon: const Icon(
                        Icons.favorite_border_sharp,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildCategories(CategoryDataList categoryDataList) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            height: 100,
            width: 100,
            image: NetworkImage('${categoryDataList.image}'),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: 100,
            child: Text('${categoryDataList.name}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ],
      );
}

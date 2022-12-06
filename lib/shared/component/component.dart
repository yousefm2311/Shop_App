// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void defaultNavigator(context, Widget) => Navigator.pushAndRemoveUntil(
    (context),
    MaterialPageRoute(builder: (context) => Widget),
    (Route<dynamic> route) => false);
void defaultNavigatorPush(context, Widget) => Navigator.push(
      (context),
      MaterialPageRoute(
        builder: ((context) => Widget),
      ),
    );

Widget defaultFormField({
  required String text,
  TextInputType? type,
  IconData? perfix,
  required TextEditingController controller,
  IconData? suffix,
  VoidCallback? suffixButton,
  bool isPassword = false,
  String? Function(String?)? validator,
  VoidCallback? ontap,
  String? Function(String?)? onchange,
  required BuildContext context,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: TextFormField(
        onFieldSubmitted: onchange,
        validator: validator,
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        onTap: ontap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          labelText: text,
          hintText: text,
          // prefixIconColor: Theme.of(context).iconTheme.color,
          suffixIconColor: Theme.of(context).iconTheme.color,
          labelStyle: Theme.of(context).textTheme.subtitle1,
          hintStyle: Theme.of(context).textTheme.subtitle1,
          floatingLabelStyle: Theme.of(context).textTheme.subtitle1,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          // prefixIcon: Icon(perfix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixButton,
                  icon: Icon(suffix),
                )
              : null,
        ),
      ),
    );

Future<bool?> defaultToast({
  required String text,
  required ToastColor color,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(color),
        textColor: Colors.white,
        fontSize: 14.0);

// ignore: constant_identifier_names
enum ToastColor { SUCCESS, ERROR, WANING }

Color chooseColor(ToastColor state) {
  Color color;
  switch (state) {
    case ToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastColor.ERROR:
      color = Colors.redAccent;
      break;
    case ToastColor.WANING:
      color = Colors.red;
      break;
  }
  return color;
}

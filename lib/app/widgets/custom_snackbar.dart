import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void showCustomSnackBar(BuildContext context, String? message,
    {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        message ?? "",
        style: const TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      backgroundColor:  Colors.black,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    ),
  );
}


// void showCustomSnackBar(String? message, {bool isError = true} ) {
//   Fluttertoast.showToast(
//     msg: message ?? "",
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.white.withOpacity(0.60),
//     // backgroundColor: isError ? Colors.red : Colors.green,
//     textColor: Colors.black,
//     fontSize: 16.0,
//     timeInSecForIosWeb: 3,
//   );
// }
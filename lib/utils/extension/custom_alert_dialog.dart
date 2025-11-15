import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String? title;
  final String? message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function? onPostivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title != null ? title! : ""),
      content: Text(message != null ? message! : ""),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        Visibility(
          visible: negativeBtnText != null ? true : false,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.transparent,
              ),
              // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //     RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       // side: BorderSide(color: Colors.red)
              //     ))
            ),
            child: Text(
              negativeBtnText != null ? negativeBtnText! : "",
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (onNegativePressed != null) {
                onNegativePressed!();
              }
            },
          ),
        ),
        Visibility(
          visible: positiveBtnText != null ? true : false,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.transparent,
              ),
              // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //     RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       // side: BorderSide(color: Colors.red)
              //     ))
            ),
            child: Text(
              positiveBtnText != null ? positiveBtnText! : "",
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              if (onPostivePressed != null) {
                onPostivePressed!();
              }
            },
          ),
        )
      ],
    );
  }
}

// CustomAlertDialogloader(
//     {String? title,
//     String? message,
//     bool disable = true,
//     String? negativeBtnText,
//     String? positiveBtnText,
//     Function? onPostivePressed,
//     Function? onNegativePressed}) {
//   var dialog = CustomAlertDialog(
//       title: title,
//       message: message,
//       onPostivePressed: onPostivePressed,
//       positiveBtnText: positiveBtnText,
//       onNegativePressed: onNegativePressed,
//       negativeBtnText: negativeBtnText);
//   Get.dialog(CustomAlertDialog(
//       title: title,
//       message: message,
//       onPostivePressed: onPostivePressed,
//       positiveBtnText: positiveBtnText,
//       onNegativePressed: onNegativePressed,
//       negativeBtnText: negativeBtnText ?? ""));
//   // showDialog(
//   //     context: context!,
//   //     barrierDismissible: disable,
//   //     builder: (BuildContext context) => dialog);
// }

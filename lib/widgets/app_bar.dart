// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:new_game/theme/app_colors.dart';
// import 'package:new_game/widgets/custom_text.dart';


// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Color backgroundColor;
//   final Color? circleColor;
//   final Color? textColor;
//   final Color? iconColor;
//   final List<Widget>? actions;
//   final FontWeight? fontWeight;
//   final Function()? onTap;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.fontWeight,
//     this.onTap,
//     this.textColor,
//     this.iconColor,
//     this.circleColor,
//     this.backgroundColor = whiteColor,
//     this.actions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: backgroundColor,
//       scrolledUnderElevation: 0,
//       title: CustomText(
//         text: title,
//         fontSize: 16.sp,
//         textColor: textColor ?? blackColor,
//         fontFamily: 'Poppins',
//         fontWeight: fontWeight ?? FontWeight.w500,
//       ),
//       leading: Transform.scale(
//         scale: 0.6,
//         child: InkWell(
//           onTap: onTap ??
//               () {
//                 Get.back();
//               },
//           child: CircleAvatar(
//             radius: 5.r,
//             backgroundColor: circleColor ?? whiteColor,
//             child: Icon(
//               Icons.chevron_left,
//               color: iconColor ?? blackColor,
//               size: 40.sp,
//             ),
//           ),
//         ),
//       ),
//       actions: actions,
//       centerTitle: true,
//       elevation: 0,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

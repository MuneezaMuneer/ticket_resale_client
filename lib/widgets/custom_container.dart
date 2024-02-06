// import 'package:flutter/material.dart';
// import 'package:svg_flutter/svg.dart';
// import 'package:ticket_resale/constants/app_images.dart';
// import 'package:ticket_resale/widgets/custom_gradient.dart';
// import 'package:ticket_resale/widgets/custom_text.dart';

// class CustomContainer extends StatelessWidget {
//   final double? height;
//   final double? width;
//   final bool isRounded;
//   final String? text;
//   final double? size;
//   final FontWeight? weight;
//   final bool isSocial;
//   final String? socialText;
//   final String? imagePath;
//   final Color? color;
//   const CustomContainer(
//       {super.key,
//       this.height,
//       this.width,
//       this.isRounded = true,
//       this.text,
//       this.size,
//       this.color,
//       this.weight,
//       this.isSocial = false,
//       this.socialText,
//       this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//           gradient: customGradient,
//           borderRadius: isRounded
//               ? BorderRadius.circular(45)
//               : const BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10))),
//       child: isSocial
//           ? Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 55),
//                   child: SvgPicture.asset(AppSvgs.paypalIcon),
//                 ),
//                 CustomText(
//                   title: '$socialText',
//                   color: color,
//                   size: size,
//                   weight: weight,
//                 ),
//               ],
//             )
//           : Center(
//               child: CustomText(
//                 title: '$text',
//                 color: color,
//                 size: size,
//                 weight: weight,
//               ),
//             ),
//     );
//   }
// }

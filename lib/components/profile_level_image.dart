import 'package:flutter/cupertino.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';

class ProfileLevelImage extends StatelessWidget {
  final Future<Map<String, dynamic>?> profileLevelsFuture;

  const ProfileLevelImage({
    required this.profileLevelsFuture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: profileLevelsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CupertinoActivityIndicator();
        } else if (snapshot.hasData) {
          Map<String, dynamic>? profileLevels = snapshot.data;
          if (profileLevels != null) {
            bool isEmailVerified = profileLevels['isEmailVerified'] ?? false;
            bool isInstaVerified = profileLevels['isInstaVerified'] ?? false;
            bool isPaypalVerified = profileLevels['isPaypalVerified'] ?? false;
            bool isPhoneNoVerified =
                profileLevels['isPhoneNoVerified'] ?? false;
            int numberOfTransactions =
                profileLevels['number_of_transactions'] ?? 0;
            bool isSuperVerified = profileLevels['isSuperVerified'] ?? false;

            if (isEmailVerified &&
                isInstaVerified &&
                isPaypalVerified &&
                isPhoneNoVerified &&
                numberOfTransactions >= 5 &&
                isSuperVerified) {
              return SvgPicture.asset(AppSvgs.levelSix);
            } else if (isEmailVerified &&
                isInstaVerified &&
                isPaypalVerified &&
                isPhoneNoVerified &&
                numberOfTransactions >= 5) {
              return SvgPicture.asset(AppSvgs.levelFive);
            } else if (isEmailVerified &&
                isInstaVerified &&
                isPaypalVerified &&
                isPhoneNoVerified) {
              return SvgPicture.asset(AppSvgs.levelFour);
            } else if (isEmailVerified && isInstaVerified && isPaypalVerified) {
              return SvgPicture.asset(AppSvgs.levelThree);
            } else if (isEmailVerified && isInstaVerified) {
              return SvgPicture.asset(AppSvgs.levelTwo);
            } else if (isEmailVerified) {
              return SvgPicture.asset(AppSvgs.levelOne);
            }
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}

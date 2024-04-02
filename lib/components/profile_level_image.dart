import 'package:flutter/cupertino.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/models.dart';

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
          int? profileLevelsLength;
          if (profileLevels != null) {
            UserModelClient user =
                UserModelClient(profileLevels: profileLevels);
            profileLevelsLength =
                user.getProfileLevelsLength(user.profileLevels);
            switch (profileLevelsLength) {
              case 1:
                return SvgPicture.asset(AppSvgs.levelOne);
              case 2:
                return SvgPicture.asset(AppSvgs.levelTwo);
              case 3:
                return SvgPicture.asset(AppSvgs.levelThree);
              case 4:
                return SvgPicture.asset(AppSvgs.levelFour);
              case 5:
                return SvgPicture.asset(AppSvgs.levelFive);
              case 6:
                return SvgPicture.asset(AppSvgs.levelSix);
              default:
                return SizedBox.shrink();
            }
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}

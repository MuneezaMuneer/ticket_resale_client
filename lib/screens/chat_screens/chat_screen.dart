import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/firestore_services_client.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarClient(
        title: 'Chat System',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: StreamBuilder(
          stream: FireStoreServicesClient.getUsersConnections(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return const Center(
                child: Text('No Active User'),
              );
            } else {
              final currentUserId = snapshot.data as List<String>;

              return ListView.builder(
                itemCount: currentUserId.length,
                itemBuilder: (context, index) {
                  final String firstUserId =
                      currentUserId.isNotEmpty ? currentUserId[index] : '';
                  return StreamBuilder(
                    stream: FireStoreServicesClient.fetchUserData(
                        userId: firstUserId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userData = snapshot.data;
                        return GestureDetector(
                          onTap: () {
                            String hashKey =
                                FireStoreServicesClient.getMessagesHashCodeID(
                                    userIDReceiver: firstUserId);
                            Navigator.of(context).pushNamed(
                              AppRoutes.chatDetailScreen,
                              arguments: {
                                'receiverId': firstUserId,
                                'hashKey': hashKey,
                                'isOpened': false,
                              },
                            );
                          },
                          child: ListTile(
                            leading: SizedBox(
                                child: userData!.photoUrl != 'null' &&
                                        userData.photoUrl != null &&
                                        userData.photoUrl!.isNotEmpty
                                    ? CustomDisplayStoryImage(
                                        imageUrl: '${userData.photoUrl}',
                                        height: 43,
                                        width: 43,
                                      )
                                    : const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            AppImages.profileImage))),
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: CustomText(
                                    title: userData.displayName,
                                    size: AppFontSize.regular,
                                    weight: FontWeight.w600,
                                    color: AppColors.jetBlack,
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  flex: 2,
                                  child: CustomText(
                                    title: AppUtils.convertDateTimeToMMMMDY(
                                        dateTime: DateTime.now()),
                                    size: AppFontSize.xsmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Text('');
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

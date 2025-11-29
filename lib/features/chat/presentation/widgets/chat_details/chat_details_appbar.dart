import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_details_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/pages/chat_details_page.dart';

class ChatDetailsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatDetailsAppbar({super.key, required this.arg});

  final ChatDetailsArg arg;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.brandColor),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: () {
          // TODO: Navigate to contact info page
        },
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black54,
              backgroundImage: arg.avatarUrl.isNotEmpty
                  ? NetworkImage(arg.avatarUrl)
                  : null,
              child: arg.avatarUrl.isEmpty
                  ? Text(
                      arg.contactName.isNotEmpty
                          ? arg.contactName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(arg.contactName, overflow: TextOverflow.ellipsis),
                  BlocBuilder<ChatDetailsCubit, ChatDetailsState>(
                    builder: (BuildContext context, ChatDetailsState state) {
                      if (state is ChatDetailsLoaded) {
                        return Text(
                          state.isOnline
                              ? 'online'
                              : state.lastSeen ?? 'offline',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(AppAssets.videocam),
          onPressed: () {
            // TODO: Implement video call
          },
        ),
        IconButton(
          icon: SvgPicture.asset(AppAssets.call),
          onPressed: () {
            // TODO: Implement voice call
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (BuildContext context, ChatState state) {
        final bool isEditMode = state is ChatLoaded && state.isEditMode;
        return AppBar(
          elevation: 0,
          leading: TextButton(
            onPressed: () {
              context.read<ChatCubit>().toggleEditMode();
            },
            child: Text(
              isEditMode ? 'Done' : 'Edit',
              style: TextStyle(
                color: AppColors.brandColor,
                fontSize: !isEditMode ? 14.sp : 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          title: const Text(
            'Chats',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            if (!isEditMode)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: SvgPicture.asset(AppAssets.editIcon),
                  onPressed: () {
                    // Navigate to new chat or compose
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

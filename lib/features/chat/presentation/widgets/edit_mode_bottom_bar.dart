import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_cubit.dart';

class EditModeBottomBar extends StatelessWidget {
  const EditModeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (BuildContext context, ChatState state) {
        if (state is! ChatLoaded || !state.isEditMode) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildActionButton(
                context: context,
                label: 'Archive',
                onTap: () {
                  context.read<ChatCubit>().archiveSelectedChats();
                },
              ),
              _buildActionButton(
                context: context,
                label: 'Read All',
                onTap: () {
                  context.read<ChatCubit>().markAllAsRead();
                },
              ),
              _buildActionButton(
                context: context,
                label: 'Delete',
                onTap: () {
                  context.read<ChatCubit>().deleteSelectedChats();
                },
                isDelete: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    bool isDelete = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: AppStyles.editModeBottomTextStyle.copyWith(
          color: isDelete ? AppColors.error : Colors.black,
        ),
      ),
    );
  }
}

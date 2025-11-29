import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';

class MessageInputBar extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInputBar({super.key, required this.onSendMessage});

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  final TextEditingController _textController = TextEditingController();
  bool _hasText = false;

  void _handleSendMessage() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _textController.clear();
      setState(() {
        _hasText = false;
      });
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                _buildAttachmentOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: const Color(0xFFFF3B30),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement camera functionality
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.photo_library,
                  label: 'Photo & Video Library',
                  color: const Color(0xFF5856D6),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement photo library functionality
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.insert_drive_file,
                  label: 'Document',
                  color: const Color(0xFF007AFF),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement document picker functionality
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.location_on,
                  label: 'Location',
                  color: const Color(0xFF34C759),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement location sharing functionality
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.person,
                  label: 'Contact',
                  color: const Color(0xFFFF9500),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement contact sharing functionality
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFF6F6F6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Attachment button
              IconButton(
                icon: SvgPicture.asset(AppAssets.add),
                onPressed: _showAttachmentOptions,
                padding: const EdgeInsets.all(8),
              ),
              // Text field
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    maxHeight: 120,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: BoxBorder.all(color: AppColors.grey2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                            hintText: 'Message',
                            hintStyle: TextStyle(
                              color: AppColors.grey3,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          onChanged: (String text) {
                            setState(() {
                              _hasText = text.trim().isNotEmpty;
                            });
                          },
                          onSubmitted: (_) => _handleSendMessage(),
                        ),
                      ),
                      // Camera button (shown when no text)
                      if (!_hasText)
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: AppColors.grey3,
                          ),
                          onPressed: () {
                            // TODO: Implement camera functionality
                          },
                          padding: const EdgeInsets.all(8),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Send or Voice button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _hasText ? AppColors.primary : AppColors.grey,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: _hasText
                      ? const Icon(Icons.send, color: Colors.white, size: 20)
                      : SvgPicture.asset(AppAssets.mic),
                  onPressed: _hasText
                      ? _handleSendMessage
                      : () {
                          // TODO: Implement voice recording
                        },
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

extension ModalBottomSheet on BuildContext {
  void bottomSheet(BuildContext context, Widget body) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      //  useSafeArea: true,
      // isScrollControlled: true,
      sheetAnimationStyle: const AnimationStyle(
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 300),
      ),
      elevation: 10,
      builder: (BuildContext context) {
        return body;
      },
    );
  }
}

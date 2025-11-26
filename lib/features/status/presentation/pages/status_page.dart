import 'package:flutter/material.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_app_bar.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_container.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_empty.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0XFFEFEFF4),
      appBar: StatusAppBar(),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[StatusContainer(), StatusEmpty()]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomEmptyPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  const CustomEmptyPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30,),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              icon,
              const SizedBox(height: 30),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

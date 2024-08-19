import 'package:flutter/material.dart';

import 'package:rokyapp/app_router.dart';
import 'package:rokyapp/presentation/screens/characters.dart';

void main() {
  runApp(RokcyApp(
    appRouter: AppRouter(),
  ));
}

class RokcyApp extends StatelessWidget {
  const RokcyApp({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

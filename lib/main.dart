import 'package:flutter/material.dart';
import 'router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ///const MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}



// @RoutePage()
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   // ...
// }

// @RoutePage()
// class DetailPage extends StatelessWidget {
//   const DetailPage({super.key});
//   // ...
// }
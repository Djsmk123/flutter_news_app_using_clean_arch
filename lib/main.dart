import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presenter/bloc/news_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presenter/pages/news_page.dart';
import 'injection_container.dart' as di;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => di.sl<NewsBloc>()),
    ], child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: NewsPage(),));
  }
}




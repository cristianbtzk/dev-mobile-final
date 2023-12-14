import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping_app/bloc/addToCartBloc/addToCartBloc.dart';
import 'package:shopping_app/cart.dart';
import 'package:shopping_app/categories.dart';
import 'package:shopping_app/home.dart';
import 'package:shopping_app/products.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping app',
        initialRoute: '/',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          /* useMaterial3: true, */
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        /* themeMode: themeProvider.getTheme, */
        routes: {
          '/': (context) => const Home(),
          '/cart': (context) => const Cart(),
          '/categories': (context) => const Categories(),
          '/orders': (context) => const Categories(),
          '/products': (context) => const Products(),
        },
      ),
    );
  }
}

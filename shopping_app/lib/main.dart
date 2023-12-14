import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/bloc/addToCartBloc/addToCartBloc.dart';
import 'package:shopping_app/cart.dart';
import 'package:shopping_app/categories.dart';
import 'package:shopping_app/home.dart';
import 'package:shopping_app/orders.dart';
import 'package:shopping_app/products.dart';
import 'package:shopping_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.remove();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) =>
          ThemeProvider(isDarkMode: prefs.getBool('isDarkTheme') ?? false),
      child: const MyApp(),
    ),
  );
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
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
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
          themeMode: themeProvider.getTheme,
          /* themeMode: themeProvider.getTheme, */
          routes: {
            '/': (context) => const Home(),
            '/cart': (context) => const Cart(),
            '/categories': (context) => const Categories(),
            '/orders': (context) => const Orders(),
            '/products': (context) => const Products(),
          },
        );
      }),
    );
  }
}

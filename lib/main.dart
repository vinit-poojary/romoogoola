import 'package:romoogoola/home.dart';
import 'package:romoogoola/splash.dart';
import 'package:flutter/material.dart';
import './login.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';
import 'package:romoogoola/common/common.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.dark,
        data: (brightness) => new ThemeData(
              primarySwatch: primaryBlack,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Romoogoola',
            theme: theme,
            home: ScreensController(),
          );
        });
  }
}

class ScreensController extends StatefulWidget {
  @override
  _ScreensController createState() => new _ScreensController();
}

class _ScreensController extends State<ScreensController> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return HomeScreen();
            default:
              return LoginPage();
          }
        },
      ),
    );
  }
}

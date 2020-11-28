import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/RegisterSuccessPage.dart';
import 'MyHomePage.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(
  EasyLocalization(
      supportedLocales: [Locale('en'), Locale('zh')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: MyApp()
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'ChildCare Centre',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/home': (context) => MyHomePage(title: tr("home_page")),
      '/login': (context) => LoginPage(),
      '/registerSuccess': (context) => RegisterSuccessPage(),
      },
    );
  }
}


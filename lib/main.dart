import 'package:copick_sensor_manage/pages/device_scan/device_scan_page.dart';
import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/providers/permission_provider.dart';
import 'package:copick_sensor_manage/routes/routes/route_generator.dart';
import 'package:copick_sensor_manage/routes/routes/routes.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/wifi_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BluetoothControlProvider()),
        ChangeNotifierProvider(create: (_) => PermissionProvider()),
        ChangeNotifierProvider(create: (_) => WifiProvider()),
      ],
      child: EasyLocalization(
        path: 'assets/language',
        supportedLocales: [
          Locale('ko', 'KR'),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: "CO:PICK 센서 관리",
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: KColors.backgroundGrey,
        primaryColor: KColors.lightPrimary,
        fontFamily: 'NotoSansKR',
        iconTheme: const IconThemeData(color: KColors.black),
        appBarTheme: const AppBarTheme(
          backgroundColor: KColors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: kAppbarTitle,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: KColors.black,
          ),
        ),
        textTheme: TextTheme(),
        cardTheme: CardTheme(
          color: KColors.white,
          elevation: 4,
          margin: const EdgeInsets.fromLTRB(NORMALGAP, 0, NORMALGAP, NORMALGAP),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SMALLGAP),
          ),
        ),
      ),
    );
  }
}

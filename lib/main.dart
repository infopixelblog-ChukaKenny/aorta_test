import 'package:aorta/core/di/init_injections.dart';
import 'package:aorta/core/theme/colors/aorta_colors.dart';
import 'package:aorta/core/theme/inherited/aorta_inherited_widget.dart';
import 'package:aorta/core/theme/materialtheme/materialtheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';
import 'core/navigation/auto_router/app_router.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 974),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MaterialApp.router(
            key: const GlobalObjectKey("main"),
            onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            supportedLocales: const [Locale('en', 'US'), Locale('el')],
            theme: aortaThemeLight,
            darkTheme: aortaThemeDark,
            themeMode: ThemeMode.system,
            routerConfig: _appRouter.config(),
            builder: (context, child) {
              final brightness = Theme.of(context).brightness;

              final customColors = (brightness == Brightness.dark)
                  ? const DarkAortaColors()
                  : const LightAortaColors();

              return UpgradeAlert(
                shouldPopScope: () => true,
                child: AortaTheme(
                  colors: customColors,
                  child:
                      child!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

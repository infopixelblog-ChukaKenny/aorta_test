import 'package:aorta/core/di/bloc/bloc_injections.dart';
import 'package:aorta/core/theme/colors/aorta_colors.dart';
import 'package:aorta/core/theme/inherited/aorta_inherited_widget.dart';
import 'package:aorta/core/theme/materialtheme/materialtheme.dart';
import 'package:aorta/features/transfer/presentation/bloc/send_money_bloc.dart';
import 'package:aorta/features/transfer/presentation/pages/transfer_page.dart';
import 'package:aorta/l10n/app_localizations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinput/pinput.dart';

class MockSendMoneyBloc extends MockBloc<SendMoneyEvent, SendMoneyState>
    implements SendMoneyBloc {}

class FakeSendMoneyEvent extends Fake implements SendMoneyEvent {}

class FakeSendMoneyState extends Fake implements SendMoneyState {}

void main() {
  late MockSendMoneyBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeSendMoneyEvent());
    registerFallbackValue(FakeSendMoneyState());
  });

  setUp(() {
    bloc = MockSendMoneyBloc();
    GetIt.instance.reset();
    sl.registerSingleton<SendMoneyBloc>(bloc);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget pumpApp(Widget child, {SendMoneyBloc? bloc}) {
    return ScreenUtilInit(
      designSize: const Size(412, 974),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', 'US'), Locale('el')],
          theme: aortaThemeLight,
          darkTheme: aortaThemeDark,
          home: Builder(
            builder: (context) {
              // ✅ Inject custom Aorta colors like app does
              final brightness = Theme.of(context).brightness;
              final colors = brightness == Brightness.dark
                  ? const DarkAortaColors()
                  : const LightAortaColors();

              return AortaTheme(
                colors: colors,
                child: BlocProvider.value(
                  value: bloc ?? sl<SendMoneyBloc>(),
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Base wrapper used in every test
  Widget wrapWithMaterial(Widget child) {
    return pumpApp(child, bloc: bloc);
  }

  /// -------------------------------------------------------------------------
  /// TESTS
  /// -------------------------------------------------------------------------

  testWidgets('renders initial UI correctly', (tester) async {
    when(() => bloc.state).thenReturn(
      const SendMoneyState(
        availableBalance: 285856.20,
        senderAccount: '234-7011-8406-21',
      ),
    );

    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));

    expect(find.text('Transfer Request'), findsOneWidget);
    expect(find.text('Available Balance'), findsOneWidget);
    expect(find.text('€285856.20'), findsOneWidget);
    expect(find.text('Sender\'s Account No.'), findsOneWidget);
  });

  testWidgets('typing recipient dispatches SendMoneyUpdateRecipient', (
    tester,
  ) async {
    whenListen(
      bloc,
      Stream.value(const SendMoneyState()),
      initialState: const SendMoneyState(),
    );

    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));

    final recipientField = find.byType(TextFormField).at(1);

    await tester.enterText(recipientField, '08012345678');
    await tester.pump();

    verify(() => bloc.add(SendMoneyUpdateRecipient('08012345678'))).called(1);
  });

  testWidgets('send button shows snackbar when recipient is empty', (
    tester,
  ) async {
    when(() => bloc.state).thenReturn(
      const SendMoneyState(availableBalance: 1000, amountString: '€10.00'),
    );

    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));
    await tester.ensureVisible(
      find.byKey(const Key('Send')),
    );
    await tester .tap(find.byKey( Key("Send")));
    await tester.pump();

    expect(find.text('Please enter recipient'), findsOneWidget);
  });

  testWidgets('valid input opens PIN modal', (tester) async {
    when(() => bloc.state).thenReturn(
      const SendMoneyState(
        recipient: '08012345678',
        availableBalance: 1000,
        amountString: '€10.00',
      ),
    );
    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));
    final amountField = find.byKey( Key("Amount"));
    await tester.enterText(amountField, '10');
    await tester.pump();
    await tester.ensureVisible(
      find.byKey(const Key('Send')),
    );
    await tester.tap(find.byKey( Key("Send")));
    await tester.pumpAndSettle();

    expect(find.text('Enter PIN'), findsOneWidget);
  });

  testWidgets('entering PIN submits SendMoneyPinSubmitted', (tester) async {
    when(() => bloc.state).thenReturn(
      const SendMoneyState(
        recipient: '08012345678',
        availableBalance: 1000,
        amountString: '€10.00',
      ),
    );

    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));
    final amountField = find.byKey( Key("Amount"));
    await tester.enterText(amountField, '10');
    await tester.pump();
    // Open PIN modal
    await tester.ensureVisible(
      find.byKey(const Key('Send')),
    );
    await tester.tap(find.byKey( Key("Send")));
    await tester.pumpAndSettle();

    // Enter PIN
    await tester.enterText(find.byType(Pinput), '1234');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    verify(() => bloc.add(SendMoneyPinSubmitted(pin: '1234'))).called(1);
  });

  testWidgets('tapping QR icon starts QR scan', (tester) async {
    when(() => bloc.state).thenReturn(const SendMoneyState());

    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));

    await tester.tap(find.byIcon(Icons.qr_code_scanner));
    await tester.pump();

    verify(() => bloc.add(SendMoneyStartScanQrCode())).called(1);
  });

  testWidgets('QR overlay is shown when scanningQRCode is true', (
    tester,
  ) async {
    when(
      () => bloc.state,
    ).thenReturn(const SendMoneyState(scanningQRCode: true));

    await tester.pumpWidget(wrapWithMaterial(SendMoneyPage(bloc: bloc)));

    expect(find.text('Point camera at payer QR code'), findsOneWidget);
  });


}

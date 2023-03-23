import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:recharge_p_o_c/app_state.dart';
import 'package:recharge_p_o_c/main.dart' as app;

void main() {
  group("E2E Testing for HDFC Recharge POC", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Recharge POC Login screen Testing", (widgetTester) async {
      // Setup the finder and assian the value
      widgetTester.printToConsole("Flutter Integration testing started");
      app.main();
      print('starting integration testing....');
      try {
        await binding.convertFlutterSurfaceToImage();
        final Finder customeridCtrlVal = find.byKey(Key('custidCtrlKey'));

        final Finder customerPswdVal = find.byKey(Key('pswdCtrlKey'));

        final Finder submitButton = find.byKey(Key('submitBtnKey'));

        // await widgetTester.pumpWidget(LoginPageWidget());
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(customeridCtrlVal);
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(customeridCtrlVal, '123456');
        widgetTester.printToConsole("Entered custid");

        // await widgetTester.pumpAndSettle(Duration(seconds: 2));

        await widgetTester.tap(customerPswdVal);
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(customerPswdVal, '123456');
        widgetTester.printToConsole("Entered cust password");

        // await widgetTester.pumpAndSettle(Duration(seconds: 1));
        // -------------------------- take screenshot 1 -------------------

        // await widgetTester.pumpAndSettle();
        await binding.takeScreenshot('screenshot1');

// ----------------------------- take screenshot 1 -------------------
        await widgetTester.tap(submitButton);
        await widgetTester.pumpAndSettle();

        widgetTester.printToConsole("Tapped on submit button");
        // print("login submit button tapped");

        await widgetTester.pumpAndSettle();

        expect(find.text('Welcome to the Dashboard'), findsOneWidget);

        widgetTester.printToConsole(
            "expectation success then navigate to Dashboard Screen");

        await widgetTester.pumpAndSettle();

        final Finder fastagBtn = find.byKey(Key('fastagkey'));

        // -------------------------- take screenshot 2 -------------------
        // await widgetTester.pumpAndSettle(Duration(seconds: 2));

        // await widgetTester.pumpAndSettle();
        await binding.takeScreenshot('screenshot2');
// ----------------------------- take screenshot 2 -------------------
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(fastagBtn);
        await widgetTester.pumpAndSettle();
        expect(find.text('Select To Recharge'), findsOneWidget);
        // await widgetTester.pumpAndSettle(Duration(seconds: 1));

        //Select Recharge Options vehicle or wallet recharge
        final Finder selectWalletRecharge =
            find.byKey(Key('walletrechargekey'));
        // final Finder selectVehicleRecharge =
        //     find.byKey(Key('vehiclerechargekey'));

        //Go with wallet recharge
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(selectWalletRecharge);
        await widgetTester.pumpAndSettle();

        final Finder selecteWalletDropdown = find.text('Select Wallet ID');

        await widgetTester.tap(selecteWalletDropdown);
        await widgetTester.pumpAndSettle();

        final Finder finderWalletItem = find
            .byWidgetPredicate(
                (widget) => widget is Text && widget.data == "17874512789456")
            .first;
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(finderWalletItem);
        // await widgetTester.pump();

        final Finder amtCtrl = find.byType(TextFormField).last;
        await widgetTester.pumpAndSettle();
        await widgetTester.enterText(amtCtrl, "1520");

        final Finder selecAccDropdown = find.text('Select Your Account');
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(selecAccDropdown);
        // await widgetTester.pump();

        final Finder accItem = find.text('10000123500001').first;
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(accItem);
        await widgetTester.pumpAndSettle();

        final Finder submitBtn = find.text('Submit');

        await widgetTester.tap(submitBtn);

        // -------------------------- take screenshot 3 -------------------

        // await widgetTester.pumpAndSettle();
        await binding.takeScreenshot('screenshot3');
        await widgetTester.pumpAndSettle();
        expect(find.text('Review'), findsOneWidget);

// ----------------------------- take screenshot 3 -------------------

        await widgetTester.pumpAndSettle();

        final Finder reviewConfirmBtn = find.text('Confirm & Pay');
        await widgetTester.tap(reviewConfirmBtn);

        // -------------------------- take screenshot 4 -------------------
        // await Future.delayed(Duration(seconds: 2));

        await widgetTester.pump();
        await binding.takeScreenshot('screenshot4');
// ----------------------------- take screenshot 4 -------------------

        final Finder otpTextEditingCtrl = find.byKey(Key('otpCtrlKey'));

        await widgetTester.pump();
        String storedOTP = FFAppState().authOtp;
        await widgetTester.pump();
        await widgetTester.enterText(otpTextEditingCtrl, "$storedOTP");
        await widgetTester.pump();

        // -------------------------- take screenshot 5 -------------------

        // await Future.delayed(Duration(seconds: 1));
        final Finder confirmAndPayBtn = find.byKey(ValueKey('authotpBTNKey'));

        // await widgetTester.pumpAndSettle();
        await binding.takeScreenshot('screenshot5');
        await widgetTester.tap(confirmAndPayBtn);

// ----------------------------- take screenshot 5 -------------------

        // -------------------------- take screenshot 6 -------------------

        // await widgetTester.pumpAndSettle();
        await binding.takeScreenshot('screenshot6');
// ----------------------------- take screenshot 6 -------------------
        await widgetTester.pumpAndSettle();
        expect(find.text('Payment Confirmed!'), findsOneWidget);

        // await widgetTester.pumpAndSettle();

        final confettiWidget = find
            .byKey(ValueKey('ConfettiOverlayKey'))
            .evaluate()
            .first
            .widget as ConfettiWidget;

        // Wait for the confetti animation to complete
        // await widgetTester.pumpAndSettle(const Duration(seconds: 1));

        // Dispose of the controller
        confettiWidget.confettiController.dispose();
        final otpWidget =
            otpTextEditingCtrl.evaluate().first.widget as PinCodeTextField;

        // Dispose of the controller
        otpWidget.controller!.dispose();
      } catch (e) {
        print('Rehaman Shaik Test Error On Integration TEST : $e');
      }

      // await widgetTester.pumpAndSettle();
      // Recharge POC DashBoard Test cases:
    });
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:homeapp/CustomControls/CustomTextField.dart';
import 'package:homeapp/Repositories/MockAuthRepository.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';

import 'package:homeapp/main.dart';

void main() {
  testWidgets('Login smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();
    await GlobalConfiguration().loadFromAsset("configuration");
    MockAuthRepository mockRepo = MockAuthRepository();
    TextEditingController unamecontroller;
    await tester.pumpWidget(BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(mockRepo)..add(AuthenticationStarted());
        },
        child: MyApp(mockRepo)));

    CustomLoginTextField loginfield = CustomLoginTextField(
      true,
      placeholder: 'Username',
      isPasswordField: false,
      controller: unamecontroller,
      width: 270,
    );
    await tester.enterText(find.byType(CustomLoginTextField).at(0), 'Uname');
    expect(find.text('Uname'), findsOneWidget);
    await tester.enterText(
        find.byType(CustomLoginTextField).at(1), 'Password12');
    expect(find.text('Password12'), findsOneWidget);

    await tester.press(find.byType(MaterialButton).first);
    //await Future.delayed(Duration(seconds: 2))
    //.then((value) => expect(find.text('HomePage'), findsOneWidget));
    //expect(find.text('HomePage'), findsOneWidget);
    // Verify that our counter starts at 0.
    //expect(find.text('0'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();

    // Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    //expect(find.text('1'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:ca6/res/styles.dart';
import 'package:ca6/utils/authentication.dart';
import 'package:ca6/widgets/google_sign_in_button.dart';
import 'package:ca6/res/text_content.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteCreamOri,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 30.0,
            top: 105.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(30),
                    width: 300,
                    decoration: ShapeDecoration(color: CustomColors
                        .blackGrey, shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(21))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.cover,))
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'MyWell',
                        style: CustomStyle.mainTitle,
                        ),
                        const SizedBox(height: 10,),
                        Text(welcomeContent,
                          style: CustomStyle.appDescription,
                          textAlign: TextAlign.justify,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const GoogleSignInButton();
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
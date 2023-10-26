import 'package:flutter/material.dart';
import 'package:ca6/res/styles.dart';
import 'package:ca6/utils/authentication.dart';
import 'package:ca6/widgets/google_sign_in_button.dart';
import 'package:ca6/res/text_content.dart';

class SignInScreen extends StatefulWidget {
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
            bottom: 50.0,
            top: 105.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
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
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.cover,))
                      ),
                      SizedBox(height: 10),
                      Text(
                        'MyWell',
                        style: CustomStyle.mainTitle,
                        ),
                        SizedBox(height: 10,),
                        Text(welcomeContent,
                          style: CustomStyle.appDescription,
                          textAlign: TextAlign.justify,
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
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
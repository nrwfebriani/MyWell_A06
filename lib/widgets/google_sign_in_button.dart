import 'package:ca6/res/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ca6/screens/dashboard_screen.dart';
import 'package:ca6/utils/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : SizedBox(
        width: 200, // Set the desired width
        height: 40,  // Set the desired height
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          onPressed: () async {
            setState(() {
              _isSigningIn = true;
            });
            User? user =
            await Authentication.signInWithGoogle(context: context);

            setState(() {
              _isSigningIn = false;
            });

            if (user != null)
            {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(
                    user: user,
                ),)
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage("assets/google_logo.png"),
                  height: 18.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Sign in with Google',
                    style: CustomStyle.btnSignInGoogle
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

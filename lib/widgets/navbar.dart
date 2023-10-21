import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ca6/res/styles.dart';
import 'package:ca6/screens/dashboard_screen.dart';
import 'package:ca6/screens/sign_in_screen.dart';
import 'package:ca6/screens/detail_screen.dart';
import 'package:ca6/utils/authentication.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late User _user;
  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.whiteCreamOri,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(_user.displayName!, style: CustomStyle.userName,),
              accountEmail: Text('(${_user.email!})', style: CustomStyle.userEmail,),
          currentAccountPicture: CircleAvatar(
            child: _user.photoURL != null
                ? ClipOval(
              child: Material(
                color: CustomColors.firebaseGrey.withOpacity(0.3),
                child: Image.network(
                  _user.photoURL!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
                : ClipOval(
              child: Material(
                color: CustomColors.firebaseGrey.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: CustomColors.firebaseGrey,
                  ),
                ),
              ),
            ),),
            decoration: BoxDecoration(
              color: CustomColors.colorAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: CustomColors.colorAccent,),
            title: Text('Beranda', style: CustomStyle.navbarMenu,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(user: _user)),);
    }),
          ListTile(
              leading: Icon(Icons.water_drop, color: CustomColors.colorAccent,),
              title: Text('Informasi detail', style: CustomStyle.navbarMenu,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => DetailScreen(user: _user)),);
              }),
          ListTile(
              leading: Icon(Icons.logout, color: CustomColors
                  .colorAccent,),
              title: Text('Keluar', style: CustomStyle.navbarMenu,),
              onTap: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await Authentication.signOut(context: context);
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => SignInScreen()));
              }),
        ],
      ),
    );
  }
}

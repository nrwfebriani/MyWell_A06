import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ca6/widgets/navbar.dart';
import 'package:ca6/widgets/circle_progress.dart';
import 'package:ca6/res/styles.dart';
import 'package:ca6/screens/detail_screen.dart';
import 'package:ca6/widgets/app_bar_title.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  late User _user;
  late AnimationController controller;
  late Animation<double> volAnimation;
  final auth = FirebaseAuth.instance;
  String volume = '0';
  double volume2 = 0.0;
  String tds = '0';
  double tds2 = 0.0;
  String tss = '0';
  double tss2 = 0.0;
  String ph = '0';
  double ph2 = 0.0;
  String status = '--';
  bool flag = false;
  double phMax = 8.5;
  double phMin = 6.5;
  double tdsMax = 500;
  double tssMax = 5;

  @override
  void initState() {
    _user = widget._user;

    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    _DashboardInit(volume2);

    super.initState();
  }

  _DashboardInit(double vol) {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000)); //5s
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.whiteCreamOri,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.colorAccent,
          title: const AppBarTitle(pageTitle: "Beranda"),
        ),
        drawer: Navbar(user: _user),
        body: FutureBuilder(
            future: _fApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error fetching data.");
              } else if (snapshot.hasData) {
                return content();
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  Widget content() {
    String uid = _user.uid;
    DatabaseReference dataRef =
        FirebaseDatabase.instance.ref().child('UsersData/$uid');

    dataRef.child("readings/vol").onValue.listen((event) {
      setState(() {
        volume = event.snapshot.value.toString();
        volume2 = double.parse(volume);
      });
    });

    dataRef.child("readings/tds").onValue.listen((event) {
      setState(() {
        tds = event.snapshot.value.toString();
        tds2 = double.parse(tds);
      });
    });

    dataRef.child("readings/tss").onValue.listen((event) {
      setState(() {
        tss = event.snapshot.value.toString();
        tss2 = double.parse(tss);
      });
    });

    dataRef.child("readings/ph").onValue.listen((event) {
      setState(() {
        ph = event.snapshot.value.toString();
        ph2 = double.parse(ph);
      });
    });

    if (tds2 > tdsMax || tss2 > tssMax || ph2 > phMax || ph2 < phMin) {
      status = 'Air tidak layak minum';
      flag = false;
    } else {
      status = 'Air layak minum';
      flag = true;
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 200.0,
          top: 50.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Row(),
            Expanded(
              child: Container(
                width: 400,
                decoration: ShapeDecoration(
                  color: CustomColors.blackGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Volume air", style: CustomStyle.pageTitle),
                        const SizedBox(height: 50.0),
                        CustomPaint(
                          foregroundPainter: CircleProgress(volume2, true),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('$volume2',
                                      style: CustomStyle.circleProgressTitle),
                                  Text('Liter',
                                      style: CustomStyle.circleProgressDetail),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            (flag == false)
                ? Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.colorAccent2,
                            padding: const EdgeInsets.all(20),
                            elevation: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(user: _user)),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: CustomColors.whiteCreamOri,
                        ),
                        label: Text(status, style: CustomStyle.btnPrimary)),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.colorAccent,
                            padding: const EdgeInsets.all(20),
                            elevation: 40),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(user: _user)),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: CustomColors.whiteCreamOri,
                        ),
                        label: Text(status, style: CustomStyle.btnPrimary)),
                  )
          ],
        ),
      ),
    );
  }
}

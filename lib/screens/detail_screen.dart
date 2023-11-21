import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ca6/widgets/app_bar_title.dart';
import 'package:ca6/widgets/navbar.dart';
import 'package:ca6/route/hero_dialog_route.dart';
import 'package:ca6/res/styles.dart';
import 'package:ca6/res/text_content.dart';

const String _heroPopUpTDS = 'TDS-pop-up-hero';
const String _heroPopUpTSS = 'TSS-pop-up-hero';
const String _heroPopUppH = 'pH-pop-up-hero';
String volume = '0';
double volume2 = 0.0;
String tds = '0';
double tds2 = 0.0;
String tss = '0';
double tss2 = 0.0;
String ph = '0';
double ph2 = 0.0;
String status = '--';
bool flag = true;
double phMax = 8.5;
double phMin = 6.5;
double tdsMax = 500;
double tssMax = 5;

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  late User _user;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.whiteCreamOri,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.colorAccent,
          title: const AppBarTitle(pageTitle: "Informasi detail"),
        ),
        drawer: Navbar(user: _user),
        body: FutureBuilder(
            future: _fApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error fetching data.");
              } else if (snapshot.hasData) {
                return contents();
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  Widget contents() {
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
      child: Stack(
        children: [
          Positioned(
            left: 16,
            right: 16,
            top: 30,
            child: Column(
              children: [
                (flag == false)
                    ? Column(
                        children: [
                          Text(
                            "Status air",
                            style: CustomStyle.statusTitle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                              height: 90,
                              width: 350,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21)),
                                  color: CustomColors.blackGrey,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 16, 16, 16),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(status,
                                              style: CustomStyle.statusFalse),
                                        ]),
                                  ))),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            "Status air",
                            style: CustomStyle.statusTitle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                              height: 90,
                              width: 350,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(21)),
                                  color: CustomColors.colorAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25, 16, 16, 16),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(status,
                                              style: CustomStyle.statusTrue),
                                        ]),
                                  ))),
                        ],
                      ),
                const SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(HeroDialogRoute(builder: (context) {
                            return const TDSPopUpCard();
                          }));
                        },
                        child: Hero(
                          tag: _heroPopUpTDS,
                          child: Column(children: [
                            Column(
                              children: [
                                (tds2 > tdsMax) //False
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: CustomColors.colorAccent2,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Total Dissolved Solids",
                                                    style: CustomStyle
                                                        .cardTitleFalse),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5)),
                                                Text(tds,
                                                    style: CustomStyle
                                                        .cardContentFalse),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        //True
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: CustomColors.whiteCream,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Total Dissolved Solids",
                                                    style: CustomStyle
                                                        .cardTitleTrue),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5)),
                                                Text(tds,
                                                    style: CustomStyle
                                                        .cardContentTrue),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          ]),
                        )),
                    const SizedBox(height: 20),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(HeroDialogRoute(builder: (context) {
                            return const TSSPopUpCard();
                          }));
                        },
                        child: Hero(
                          tag: _heroPopUpTSS,
                          child: Column(children: [
                            Column(
                              children: [
                                (tss2 > tssMax) //False
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: CustomColors.colorAccent2,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Total Suspended Solids",
                                                    style: CustomStyle
                                                        .cardTitleFalse),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5)),
                                                Text(tss,
                                                    style: CustomStyle
                                                        .cardContentFalse),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        //True
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: CustomColors.whiteCream,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Total Suspended Solids",
                                                    style: CustomStyle
                                                        .cardTitleTrue),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5)),
                                                Text(tss,
                                                    style: CustomStyle
                                                        .cardContentTrue),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            )
                          ]),
                        )),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return const PHPopUpCard();
                        }));
                      },
                      child: Hero(
                        tag: _heroPopUppH,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                (ph2 < phMin || ph2 > phMax) //False
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: CustomColors.colorAccent2,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("pH",
                                                    style: CustomStyle
                                                        .cardTitleFalse),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5)),
                                                Text(ph,
                                                    style: CustomStyle
                                                        .cardContentFalse),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        //True
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: CustomColors.whiteCream,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("pH",
                                                    style: CustomStyle
                                                        .cardTitleTrue),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 10, 5)),
                                                Text(ph,
                                                    style: CustomStyle
                                                        .cardContentTrue),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TDSPopUpCard extends StatelessWidget {
  const TDSPopUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        child: Hero(
          tag: _heroPopUpTDS,
          child: Material(
            color: CustomColors.whiteCreamOri,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TDS",
                              style: CustomStyle.popUpTitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              tds,
                              style: CustomStyle.popUpValue,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "(Total Dissolved Solids)",
                              style: CustomStyle.popUpSubtitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "mg/l",
                              style: CustomStyle.popUpValueUnit,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Text(
                      tdsContent,
                      style: CustomStyle.popUpContent,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30.0),
                    const Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sumber: ",
                          style: CustomStyle.resTitle,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Text(
                      resWHO,
                      style: CustomStyle.res,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TSSPopUpCard extends StatelessWidget {
  const TSSPopUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        child: Hero(
          tag: _heroPopUpTSS,
          child: Material(
            color: CustomColors.whiteCreamOri,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TSS",
                              style: CustomStyle.popUpTitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              tss,
                              style: CustomStyle.popUpValue,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "(Total Suspended Solids)",
                              style: CustomStyle.popUpSubtitle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "NTU",
                              style: CustomStyle.popUpValueUnit,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Text(tssContent,
                        style: CustomStyle.popUpContent,
                        textAlign: TextAlign.justify),
                    const SizedBox(height: 30.0),
                    const Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sumber: ",
                          style: CustomStyle.resTitle,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Text(
                      resTSS1,
                      style: CustomStyle.res,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PHPopUpCard extends StatelessWidget {
  const PHPopUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        child: Hero(
          tag: _heroPopUppH,
          child: Material(
            color: CustomColors.whiteCreamOri,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "pH",
                          style: CustomStyle.popUpTitle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          ph,
                          style: CustomStyle.popUpValue,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    const Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Text(phContent,
                        style: CustomStyle.popUpContent,
                        textAlign: TextAlign.justify),
                    const SizedBox(height: 30.0),
                    const Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sumber: ",
                          style: CustomStyle.resTitle,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Text(
                      respH1,
                      style: CustomStyle.res,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

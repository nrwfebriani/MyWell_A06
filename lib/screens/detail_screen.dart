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
bool flag = false;
double phMax = 8;
double phMin = 6;
double tdsMax = 1000;
double tssMax = 6;

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
          title: AppBarTitle(pageTitle: "Informasi detail"),
        ),
        drawer: Navbar(user: _user),
        body: FutureBuilder(
            future: _fApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error fetching data.");
              } else if (snapshot.hasData) {
                return contents();
              } else {
                return CircularProgressIndicator();
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
            top: 50,
            child: Column(
              children: [
                (flag == false)
                    ? SizedBox(
                        height: 180,
                        width: 350,
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius:
                            BorderRadius.circular(21)),
                            color: CustomColors.blackGrey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 16,
                                  16, 16),
                              child: Column(
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Status air:", style: CustomStyle
                                            .statusFalseTitle, textAlign:
                                        TextAlign
                                            .left,),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 30),
                                        Text(status,
                                          style: CustomStyle.statusFalse),
                                      ],
                                    )]),
                            )))
                    : SizedBox(
                        height: 180,
                        width: 350,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius:
                          BorderRadius.circular(21)),
                            color: CustomColors.colorAccent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 16,
                                  16, 16),
                              child: Column(
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Status air:", style: CustomStyle
                                            .statusTrueTitle, textAlign:
                                        TextAlign
                                            .left,),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 30,),
                                        Text(status,
                                          style: CustomStyle.statusTrue),
                                      ],
                                    )]),
                            ))),
                SizedBox(height: 50),
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
                                        shape: RoundedRectangleBorder(borderRadius:
                                        BorderRadius.circular(6)),
                                        color: CustomColors.colorAccent2,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("TDS",
                                                    style:
                                                        CustomStyle
                                                            .cardTitleFalse),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB
                                                          (10, 5, 10, 5)),
                                                Text(tds,
                                                    style: CustomStyle
                                                        .cardContentFalse),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card( //True
                                        shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(6)),
                                        color: CustomColors.whiteCream,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("TDS",
                                                    style:
                                                        CustomStyle
                                                            .cardTitleTrue),
                                                Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB
                                                      (10, 5, 10, 5)),
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
                    SizedBox(height: 20),
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
                                        shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(6)),
                                        color: CustomColors.colorAccent2,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("TSS",
                                                    style:
                                                        CustomStyle
                                                            .cardTitleFalse),
                                                Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB
                                                      (10, 5, 10, 5)),
                                                Text(tss,
                                                    style: CustomStyle
                                                        .cardContentFalse),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card( //True
                                        shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(6)),
                                        color: CustomColors.whiteCream,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("TSS",
                                                    style:
                                                        CustomStyle
                                                            .cardTitleTrue),
                                                Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB
                                                      (10, 5, 10, 5)),
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
                    SizedBox(height: 20),
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
                                        shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(6)),
                                        color: CustomColors.colorAccent2,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("pH",
                                                    style:
                                                        CustomStyle
                                                            .cardTitleFalse),
                                                Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB
                                                      (10, 5, 10, 5)),
                                                Text(ph,
                                                    style: CustomStyle
                                                        .cardContentFalse),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card( //True
                                        shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(6)),
                                        color: CustomColors.whiteCream,
                                        elevation: 10,
                                        child: SizedBox(
                                          height: 100,
                                          width: 350,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("pH",
                                                    style:
                                                        CustomStyle
                                                            .cardTitleTrue),
                                                Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB
                                                      (10, 5, 10, 5)),
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
                SizedBox(height: 80),

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
        padding: const EdgeInsets.all(20.0),
        child: Hero(
          tag: _heroPopUpTDS,
          child: Material(
            color: CustomColors.whiteCreamOri,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Text("(Total Dissolved Solids)",
                        style: CustomStyle.popUpSubtitle),
                    Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Text(
                      tds_Content,
                      style: CustomStyle.popUpContent,
                      textAlign: TextAlign.justify,
                    ),
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
        padding: const EdgeInsets.all(20.0),
        child: Hero(
          tag: _heroPopUpTSS,
          child: Material(
            color: CustomColors.whiteCreamOri,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Text("(Total Suspended Solids)",
                        style: CustomStyle.popUpSubtitle),
                    Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Text(
                      tss_Content,
                      style: CustomStyle.popUpContent,
                        textAlign: TextAlign.justify
                    ),
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
        padding: const EdgeInsets.all(20.0),
        child: Hero(
          tag: _heroPopUppH,
          child: Material(
            color: CustomColors.whiteCreamOri,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    Divider(
                      color: CustomColors.blackGrey,
                      thickness: 0.2,
                    ),
                    Text(
                      ph_Content,
                      style: CustomStyle.popUpContent,
                        textAlign: TextAlign.justify
                    ),
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

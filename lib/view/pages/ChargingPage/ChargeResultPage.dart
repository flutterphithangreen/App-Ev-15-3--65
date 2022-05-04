import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChargeResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 4;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 2.5),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                  size: 36,
                )),
          )
          // MenuButton(
          //   alignment: Alignment.topLeft,
          //   menuClick: () => Get.back(),
          // )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 7),
          child: Image.asset(
            "images/logo-p.png",
            width: 100,
            //height: 50,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GetX<GMapController>(
              init: Get.find<GMapController>(),
              initState: (_) {},
              builder: (ctrl) {
                if (ctrl.chargeStatus == null ||
                    ctrl.charger == null ||
                    ctrl.chargerLoc == null ||
                    ctrl.transaction == null) {
                  //Future.microtask(() => Get.toNamed("/"));
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Get.toNamed("/"));
                  return SizedBox.shrink();
                }
                return Stack(
                  children: [
                    // MenuButton(),
                    // SizedBox(
                    //   height: _sectionHeight / 2,
                    // ),
                    Container(
                      padding: EdgeInsets.only(top: kToolbarHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: kToolbarHeight,
                          // ),

                          // Center(
                          //   child:Text("Charging Information",
                          //       style: TextStyle(
                          //         color: _theme.lightColor,
                          //         fontWeight: FontWeight.w800,
                          //         fontSize: _sectionHeight / 12,
                          //       )),
                          // ),
                          Image.asset('images/Charging.png',fit: BoxFit.cover),
                          // SizedBox(
                          //   height: _sectionHeight / 6,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: 10, left: _paddingLR, right: _paddingLR),
                          //   child: Text(
                          //     ctrl.charger.chargerName,
                          //     style: TextStyle(
                          //       color: _theme.primaryColor,
                          //       fontWeight: FontWeight.normal,
                          //       fontSize: _sectionHeight / 12,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          ChargInfoSection(),
                          SizedBox(
                            height: _sectionHeight / 10,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(_paddingLR),
                              child: SizedBox(
                                width: double.infinity,
                                height: _sectionHeight / 8,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: _theme.primaryColor,
                                      textStyle: TextStyle(
                                        color: _theme.primaryColor,
                                      ),
                                    ),
                                      //  children.add(Padding(
                                      //   padding: const EdgeInsets.only(top: 200.0),
                                      //   child: PaymentButton(
                                      //     text: "Confirm",
                                      //     onTap: () {
                                      //       print('actualratedisplay');

                                      //       Get.find<GMapController>().selectPayActual();
                                      //     },
                                      //   ),
                                      // ));
                                      child: Text(
                                      "Done",
                                      style: TextStyle(
                                          color: _theme.lightColor,
                                          fontSize: _sectionHeight / 20),
                                    ),
                                    onPressed: () {
                                      ctrl.finshTransactionProcess();
                                    }),
                                    
                                    
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        color: _theme.lightColor,
      ),
    );
  }
}

class ChargInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 4;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    var dtFormat = DateFormat("d MMM y HH:mm");
    TextStyle txtBold = TextStyle(
      fontWeight: FontWeight.w900,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 10,
    );
    TextStyle txtNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 12,
    );

    return GetX<GMapController>(
        init: Get.find<GMapController>(),
        initState: (_) {},
        builder: (ctrl) {
          if (ctrl.transaction == null || ctrl.transaction.status == null) {
            return SizedBox.shrink();
          } else
            return Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  //top: 10, left: _paddingLR, right: _paddingLR
                  left: 10.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Charging Information",
                          style: TextStyle(
                            color: _theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: _sectionHeight / 12,
                          )),
                    ),
                    Row(
                      children: [
                        Text("Start:",
                        style: TextStyle(
                          color: _theme.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: _sectionHeight / 12,
                          )
                        ),
                        Text(
                            " ${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.startAt))}",
                            style: TextStyle(
                              color: _theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                        
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "EV Charger: ",
                          style: TextStyle(
                              fontSize: _sectionHeight/12,
                              color: _theme.primaryColor,
                              fontFamily: 'AvenirNext',
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          ctrl.charger.chargerName,
                          style: TextStyle(
                              fontSize: 16,
                              color: _theme.primaryColor,
                              fontFamily: 'AvenirNext',
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("Stop:",
                        style: TextStyle(
                            color: _theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: _sectionHeight / 12,
                          ),),
                        Text(
                            " ${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.stopAt))}",
                            style: TextStyle(
                              color: _theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                            ),
                      ],
                    ),

                    Row(
                      children: [
                        Text("Total Time:",
                        style: TextStyle(
                            color: _theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: _sectionHeight / 12,
                          ),),
                        Text(" ${ctrl.transaction.totalChargeTimeDisplay}",
                        style: TextStyle(
                              color: _theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Total Volume:",
                        style: TextStyle(
                            color: _theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: _sectionHeight / 12,
                          ),),
                        Text(" ${ctrl.transaction.totalChargeKW} kW",
                        style: TextStyle(
                              color: _theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Total Cost:",
                        style: TextStyle(
                            color: _theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: _sectionHeight / 12,
                          ),),
                        Text(" ${ctrl.transaction.totalCostDisplay} THB",
                        style: TextStyle(
                              color: _theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                      ],
                    ),
                    // TextLabel(
                    //   text: Text(
                    //     "Start:",
                    //     style: txtBold,
                    //   ),
                    //   label: Text(
                    //     "${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.startAt))}",
                    //     style: txtNormal,
                    //   ),
                    //   position: TextLabelDisplayFormat.TEXTLEFT,
                    // ),
                    // SizedBox(
                    //   height: _sectionHeight / 15,
                    // ),
                    // TextLabel(
                    //   text: Text(
                    //     "Stop:",
                    //     style: txtBold,
                    //   ),
                    //   label: Text(
                    //     "   ${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.stopAt))}",
                    //     style: txtNormal,
                    //   ),
                    //   position: TextLabelDisplayFormat.TEXTLEFT,
                    // ),
                    // SizedBox(
                    //   height: _sectionHeight / 15,
                    // ),
                    // TextLabel(
                    //   text: Text(
                    //     "Total Time:",
                    //     style: txtBold,
                    //   ),
                    //   label: Text(
                    //     "   ${ctrl.transaction.totalChargeTimeDisplay}",
                    //     style: txtNormal,
                    //   ),
                    //   position: TextLabelDisplayFormat.TEXTLEFT,
                    // ),
                    // SizedBox(
                    //   height: _sectionHeight / 15,
                    // ),
                    // TextLabel(
                    //   text: Text(
                    //     "Total Volume:",
                    //     style: txtBold,
                    //   ),
                    //   label: Text(
                    //     "   ${ctrl.transaction.totalChargeKW} kW",
                    //     style: txtNormal,
                    //   ),
                    //   position: TextLabelDisplayFormat.TEXTLEFT,
                    // ),
                    // SizedBox(
                    //   height: _sectionHeight / 15,
                    // ),
                    // TextLabel(
                    //   text: Text(
                    //     "Total Cost:",
                    //     style: txtBold,
                    //   ),
                    //   label: Text(
                    //     "   ${ctrl.transaction.totalCostDisplay} THB",
                    //     style: txtNormal,
                    //   ),
                    //   position: TextLabelDisplayFormat.TEXTLEFT,
                    // ),
                  ],
                ),
              ),
            );
        });
  }
}

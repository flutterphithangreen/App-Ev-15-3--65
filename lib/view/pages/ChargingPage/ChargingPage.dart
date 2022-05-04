import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ChargingPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 2;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    return Scaffold(
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
                print("ctrl trans=> ${ctrl.transaction} =>");
                if (ctrl.transaction != null)
                  print("ctrl trans=> ${ctrl.transaction.status} =>");
                if (ctrl.transaction == null ||
                    ctrl.transaction.status == "INIT") {
                  return Material(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(top: _screenHeight / 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Prepare charging transaction...",
                                style: _theme.chargingPageTextBold,
                              ),
                              SizedBox(height: _sectionHeight / 4),
                              CircularProgressIndicator(
                                color: _theme.lightColor,
                              ),
                            ],
                          )),
                    ),
                    color: _theme.secondaryColor,
                  );
                }
                if (ctrl.transaction.status == "FAILED") {
                  return Stack(
                    children: [
                      //MenuButton(),
                      SizedBox(
                        height: _sectionHeight / 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: _paddingLR),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ChargingStatusSection(),
                            SizedBox(
                              height: _sectionHeight / 10,
                            ),
                            FailedChargingInfoSection(),
                            SizedBox(
                              height: _sectionHeight / 3,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: _sectionHeight / 5,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: _theme.primaryColor,
                                      textStyle: TextStyle(
                                        color: _theme.secondaryColor,
                                      ),
                                    ),
                                    child: Text(
                                      "Stop Charging",
                                      style: TextStyle(
                                          color: _theme.lightColor,
                                          fontSize: _sectionHeight / 12),
                                    ),
                                    onPressed:
                                        (ctrl.chargeStatus != "Stopping" &&
                                                ctrl.chargeStatus !=
                                                    "Please Un-plug" &&
                                                ctrl.chargeStatus !=
                                                    "Waiting for report")
                                            ? () {
                                                ctrl.stopCharger();
                                              }
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                if (ctrl.transaction.status == "FINISH") {
                  ctrl.finishCharge();
                  return SizedBox.shrink();
                } else {
                  print(
                      "ChargingPage=> ctrl.transaction.status=> ${ctrl.transaction.status}");
                  if (ctrl.transaction.status == "CHARGING") {
                    ctrl.startTimer();
                  }
                  return Stack(children: [
                    //MenuButton(),
                    // EzCloseButton(
                    //   closeAction: CloseButtonAction.backToMain,
                    // ),
                    SizedBox(
                      height: _sectionHeight / 4,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: _paddingLR),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ChargingStatusSection(),
                          SizedBox(
                            height: _sectionHeight / 8,
                          ),
                          ActualChargingInfoSection(),
                          SizedBox(
                            height: _sectionHeight / 3,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: _sectionHeight / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    textStyle: TextStyle(
                                      color: _theme.secondaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "Stop Charging",
                                    style: TextStyle(
                                        color: k2rrorColor,
                                        fontSize: _sectionHeight / 12, fontWeight: FontWeight.w700),
                                  ),
                                  onPressed: (ctrl.chargeStatus != "Stopping" &&
                                          ctrl.chargeStatus !=
                                              "Please Un-plug" &&
                                          ctrl.chargeStatus !=
                                              "Waiting for report")
                                      ? () {
                                          ctrl.stopCharger();
                                        }
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: _sectionHeight / 4,)
                        ],
                      ),
                    )
                  ]);
                }
              },
            ),
          ),
          color: k2rrorColor,
        ),
      ),
    );
  }
}

class ChargingStatusSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 2;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (ctrl) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: kToolbarHeight * 2,
              ),
              (ctrl.chargeStatus == "Charging")
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Your car is ",
                        style: TextStyle(
                          color: _theme.lightColor,
                          fontWeight: FontWeight.normal,
                          fontSize: _sectionHeight / 12,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(ctrl.chargeStatus,
                      style: TextStyle(
                        color: ctrl.chargeStatus == "FAILED"
                            ? Color(0xffeb4715)
                            : _theme.lightColor,
                        fontWeight: FontWeight.w800,
                        fontSize: _sectionHeight / 7,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Icon(
              //   ctrl.chargeStatus == "FAILED"
              //       ? Icons.error_outline
              //       : Icons.ev_station_rounded, //_theme.icons['CAR_CHARGING'],
              //   color: ctrl.chargeStatus == "FAILED"
              //       ? Color(0xffeb4715)
              //       : Colors.white70, //_theme.lightColor,
              //   size: _sectionHeight / 1.5,
              // ),
              Center(
                child: Lottie.network(ctrl.chargeStatus == "FAILED"
                ? "https://assets4.lottiefiles.com/private_files/lf30_glnkkfua.json"//"images/error.gif"
                :"https://assets7.lottiefiles.com/packages/lf20_qjf5niez.json"//"images/Pls-Plug.png",
                , height:   _sectionHeight / 1.55, fit: BoxFit.cover
                // color: ctrl.chargeStatus == "FAILED"
                //       ? Color(0xffeb4715):"", //_theme.lightColor,
                //  height: _sectionHeight / 1.5,)
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ActualChargingInfoSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 2;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;
    var dtFormat = DateFormat("d MMM y HH:mm");
    TextStyle txtBold = TextStyle(
      fontWeight: FontWeight.w900,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 12,
    );
    TextStyle txtNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 14,
    );

    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (ctrl) {
        return Padding(
          padding:
              EdgeInsets.only(top: 10, left: _paddingLR, right: _paddingLR),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: Text(
                  "Start:",
                  style: txtBold,
                ),
                label: Text(
                  (ctrl.transaction == null || ctrl.transaction.startAt == null)
                      ? ""
                      : "   ${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.startAt))}",
                  style: txtNormal,
                ),
                position: TextLabelDisplayFormat.TEXTLEFT,
              ),
              SizedBox(
                height: _sectionHeight / 15,
              ),
              TextLabel(
                text: Text(
                  "Charging Time:",
                  style: txtBold,
                ),
                //label: Text("   00:00 h", style: txtNormal,),
                label: Text(
                  ctrl.chargingTimeDisplay,
                  style: txtNormal,
                ),
                position: TextLabelDisplayFormat.TEXTLEFT,
              ),
              SizedBox(
                height: _sectionHeight / 15,
              ),
              TextLabel(
                text: Text(
                  "Charging Plug:",
                  style: txtBold,
                ),
                label: Text(
                  "   ${Get.find<GMapController>().connector.connectorType}",
                  style: txtNormal,
                ),
                position: TextLabelDisplayFormat.TEXTLEFT,
              )
            ],
          ),
        );
      },
    );
  }
}

class FailedChargingInfoSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 2;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;
    var dtFormat = DateFormat("d MMM y HH:mm");
    TextStyle txtBold = TextStyle(
      fontWeight: FontWeight.w900,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 12,
    );
    TextStyle txtBoldUnderline = TextStyle(
      fontWeight: FontWeight.w400,
      color: _theme.darkColor,
      fontSize: _sectionHeight / 12,
      //fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    );

    TextStyle txtNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 14,
    );

    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (ctrl) {
        return ctrl.chargeStatus == "FAILED"
            ? Padding(
                padding: EdgeInsets.only(
                    top: 10, left: _paddingLR, right: _paddingLR),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLabel(
                      text: Text(
                        "Somthing went wrong.",
                        style: txtBold,
                      ),
                      label: Text(
                        "",
                        style: txtNormal,
                      ),
                      position: TextLabelDisplayFormat.TEXTBELOW,
                    ),
                    SizedBox(
                      height: _sectionHeight / 15,
                    ),
                    TextButton(
                        onPressed: () {
                          ctrl.restartCharging();
                        },
                        child: Text(
                          "Click to Retry",
                          style: txtBoldUnderline,
                        )),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}

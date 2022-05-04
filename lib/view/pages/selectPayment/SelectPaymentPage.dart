import 'dart:ffi';
import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(left: 12.0,top: 7,bottom: 7),
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
            child: Stack(children: [
              //MenuButton(),
              EzCloseButton(
                onTap: () {
                  Get.find<GMapController>().unloadAllSelection();
                  //print("custom ontap");
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/Discover.png',
                    width: double.infinity,
                  ),
                  // SizedBox(
                  //   height: kToolbarHeight * 2,
                  // ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SelectPaymentChargerInfo(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: PaymentPagePaymentList(),
                  ),
                  
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: PaymentButton(
                  //     text: "Confirm",
                  //     onTap: () {
                  //       print('actualratedisplay');

                  //       Get.find<GMapController>().selectPayActual();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ]),
          ),
          color: _theme.lightColor,
        ),
      ),
    );
  }
}

class SelectPaymentChargerInfo extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {
    Charger _charger = Get.find<GMapController>().charger;
    Connector _connector = Get.find<GMapController>().connector;

    return _charger != null
        ? Container(
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
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "EV Charger: ",
                        style: TextStyle(
                            fontSize: 16,
                            color: _theme.primaryColor,
                            fontFamily: 'AvenirNext',
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${_charger.chargerName}",
                        style: TextStyle(
                            fontSize: 16,
                            color: _theme.primaryColor,
                            fontFamily: 'AvenirNext',
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Connector: ",
                        style: TextStyle(
                            fontSize: 16,
                            color: _theme.primaryColor,
                            fontFamily: 'AvenirNext',
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${_connector.connectorName}",
                        style: TextStyle(
                            fontSize: 16,
                            color: _theme.primaryColor,
                            fontFamily: 'AvenirNext',
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Charging Service Power: ",
                        style: TextStyle(
                            fontSize: 16,
                            color: _theme.primaryColor,
                            fontFamily: 'AvenirNext',
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${_connector.maxSpeedCharge} kW",
                        style: TextStyle(
                            fontSize: 16,
                            color: _theme.primaryColor,
                            fontFamily: 'AvenirNext',
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     RichText(
                  //         text: TextSpan(
                  //       style: TextStyle(
                  //         fontSize: 16, //_theme.fontSizeBody1,
                  //         color: _theme.primaryColor,
                  //       ),
                  //       children: <TextSpan>[
                  //         new TextSpan(
                  //             text: "EV Charger: ${_charger.chargerName}\n",
                  //             style: TextStyle(
                  //                 fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'AvenirNext')),

                  //         new TextSpan(
                  //             text: "Connector: ${_connector.connectorName}\n"),
                  //         //new TextSpan(text: "Charging Power: ${_connector.connectorType}\n"),
                  //         new TextSpan(
                  //             text:
                  //                 "Charging Service Power: ${_connector.maxSpeedCharge} kW"),
                  //       ],
                  //     )),
                  //     // Icon(
                  //     //   _theme.icons[_connector.connectorType],
                  //     //   size: 70,
                  //     //   color: _theme.secondaryColor,
                  //     // ),
                  //   ],
                  // )
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

class PaymentPagePaymentList extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  Charger _charger = Get.find<GMapController>().charger;
  Connector _connector = Get.find<GMapController>().connector;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(
      Container(
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
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 15.0,
            bottom: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Charging Service Fee",
                style: TextStyle(
                    fontSize: 16,
                    color: _theme.primaryColor,
                    fontFamily: 'AvenirNext',
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "${_connector.chargePrice[0].actualRateDisplay}",
                style: TextStyle(
                    fontSize: 16,
                    color: _theme.primaryColor,
                    fontFamily: 'AvenirNext',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );

    children.add(
      SizedBox(
        height: 10,
      ),
    );
    if (_connector == null) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }
    //text: _connector.chargePrice[0].actualRateDisplay, โชว์เรทราคา
    children.add(Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: PaymentButton(
        text: "Confirm",
        onTap: () {
          print('actualratedisplay');

          Get.find<GMapController>().selectPayActual();
        },
      ),
    ));

    // children.add(Text(
    //   "ชาร์จแบบเหมาจ่ายรายชัว่โมง",
    //   style: _theme.boxSecondaryTextBold,
    // ));
    // for (var trl in _connector.chargePrice[0].timeUsage.timeRateList) {
    //   children.add(SizedBox(
    //     height: 10,
    //   ));
    //   children.add(
    //       PaymentButton(
    //         text: "${trl.priceDisplay}" ,
    //         onTap : (){
    //           Get.find<GMapController>().toConfirmPayment(trl);
    //         },
    //       )
    //   );
    // }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  CustomTheme _theme = CustomTheme.instance;

  PaymentButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    //never set container color to enable inkwell
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        //color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: double.infinity,
            height: 40,
            color: _theme.primaryColor,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12, //_theme.fontSizeHeader1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: onTap,
          splashColor: _theme.secondaryColor,
        ),
        color: _theme.greyColor,
      ),
    );
  }
}

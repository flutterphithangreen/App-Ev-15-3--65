import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChargerLocationInfo extends StatelessWidget {
  double _screenHeight;
  double _screenWidth;

  double _sectionHeight;

  double _boxTop;

  double _boxWidth;
  double _mainBoxHeight;

  int _spaceW;

  double _paddingLR;

  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {
        _theme = CustomTheme.instance;
      },
      builder: (ctrl) {
        _spaceW = 50;
        _paddingLR = _spaceW / 2;
        _screenHeight = ctrl.screenH;
        _screenHeight -= _paddingLR;

        _screenWidth = ctrl.screenW;
        _boxWidth = _screenWidth - _spaceW;
        _boxTop = (_screenHeight - _paddingLR) / 3;
        _mainBoxHeight = _boxTop * 2; // 2 of 3 of screen
        _sectionHeight = _mainBoxHeight / 3;
        

        if (ctrl.isLocationSelect) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: _boxTop, left: _paddingLR, bottom: _paddingLR),
              width: _boxWidth,
              decoration: _theme.boxDecoration,
              child: Stack(children: [
                Column(
                  children: [
                    // Container(child: GestureDetector(
                    //   child: Icon(
                    //     _theme.icons["DOWN_ARROW"],
                    //     color: _theme.primaryColor,
                    //     size: 30,
                    //   ),
                    //   onTap: () {
                    //     ctrl.unloadSelectLocation();
                    //   }),),
                    ImageSection(_sectionHeight*0.8, _screenWidth),
                    LocationInfo(_sectionHeight*1.2),
                    ChargerListsSection(_sectionHeight),
                    ChargerInfo(_sectionHeight),
                    //_buildChargerLists(context),
                    //_buildChargerInfo(context),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                      child: Icon(
                        Icons.horizontal_rule_rounded,
                        color: Colors.grey[800],
                        size: 24,
                      ),
                      onTap: () {
                        ctrl.unloadSelectLocation();
                      }),
                ),
              ]),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class ImageSection extends StatelessWidget {
  final double sectionHeight;
  final double screenWidth;

  ImageSection(this.sectionHeight, this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (ctrl) {
        if (ctrl.charger != null) {
          return SizedBox.shrink();
        } else {
          var image1 = Image.asset(
            "images/imagenetwork1.png",
            fit: BoxFit.cover,
          );

          if (ctrl.chargerLoc.locationImage != null &&
              ctrl.chargerLoc.locationImage.length > 0) {
            image1 = Image.asset(
              "images/imagenetwork1.png",
              fit: BoxFit.cover,
            );
            // Image.network(
            //   ctrl.chargerLoc.locationImage[0],
            //   fit: BoxFit.cover,
            // );
          } //รูปใน firebase
          return Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            height: sectionHeight,
            width: ctrl.screenW,
            decoration: CustomTheme.instance.boxBorderBottomOnly,
            child: image1,
          );
        }
      },
    );
  }
}

class LocationInfo extends StatelessWidget {
  double _sectionHeight;
  CustomTheme _theme = CustomTheme.instance;

  LocationInfo(
    double sectionHeight,
  ) {
    _sectionHeight = sectionHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (ctrl) {
        if (ctrl.chargerLoc != null && ctrl.isLocationSelect) {
          return Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            height: _sectionHeight,
            width: ctrl.screenW,
            decoration: _theme.boxBorderBottomOnly,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(ctrl.chargerLoc.locationName,
                        style: TextStyle(
                            color: k2rrorColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)
                        //_theme.boxPrimaryTextBold,
                        ),
                    SizedBox(height: 2),
                    Text(
                      ctrl.chargerLoc.locationAddress,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      //style: _theme.boxPrimaryText,
                    ),
                    SizedBox(height: 5),
                    TextLabel(
                      label: Text(
                        "Open :",
                        style:  TextStyle(
                          color: k2rrorColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      text: Text(
                        ctrl.chargerLoc.openPeriodDisplay,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0

                          //fontWeight: FontWeight.normal
                        ),
                        //style: _theme.boxPrimaryText,
                      ),
                    ),
                    SizedBox(height: 2.5),
                    TextLabel(
                      label: Text(
                        "Type :",
                        style: _theme.boxPrimaryTextBold,
                      ),
                      text: Text(
                        ctrl.chargerLoc.locationTypeDisplay,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        //style: _theme.boxPrimaryText,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // IconButton(
                            //   icon: Icon(Icons.add_location_alt,
                            //       color: _theme.secondaryColor),
                            //   iconSize: 30,
                            //   onPressed: () {
                            //     ctrl.openMap(ctrl.chargerLoc.geoPoint.latitude,
                            //         ctrl.chargerLoc.geoPoint.longitude);
                            //   },
                            // ),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(color: Colors.blue
                                ),
                                backgroundColor: k2rrorColor,//Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                //side: new  BorderSide(color: Color(0xFF2A8068)),
                              ),
                              onPressed: () => {
                                ctrl.openMap(ctrl.chargerLoc.geoPoint.latitude,
                                    ctrl.chargerLoc.geoPoint.longitude)
                              },
                              icon: Icon(
                                Icons.directions,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: Text(
                                'Dierction  ',
                                style: TextStyle(
                                  fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            (ctrl.chargerLoc.contactPhone != null &&
                                    ctrl.chargerLoc.contactPhone.length > 0)
                                ? TextButton.icon(
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(color: k2rrorColor//Colors.blue
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      side: new BorderSide(color: k2rrorColor//Colors.blue
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.call,
                                      color: k2rrorColor,//Colors.blue,
                                       size: 18,
                                    ),
                                    label: Text(
                                      'Call',
                                      style: TextStyle(
                                        fontSize: 10,
                                          color: k2rrorColor,//Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      if (ctrl.chargerLoc.contactPhone !=
                                              null &&
                                          ctrl.chargerLoc.contactPhone.length ==
                                              1) {
                                        ctrl.makeACall(
                                            ctrl.chargerLoc.contactPhone.first);
                                      } else if (ctrl.chargerLoc.contactPhone !=
                                              null &&
                                          ctrl.chargerLoc.contactPhone.length >
                                              1) {
                                        List<Widget> children = List.generate(
                                          ctrl.chargerLoc.contactPhone.length,
                                          (index) => TextButton(
                                            style: TextButton.styleFrom(
                                              //padding: const EdgeInsets.all(16.0),
                                              primary: _theme.primaryColor,
                                              //textStyle: const TextStyle(fontSize: 20),
                                              textStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              backgroundColor: (index % 2) == 0
                                                  ? _theme.greyColor
                                                  : _theme.lightColor,
                                            ),
                                            onPressed: () {
                                              var phone = ctrl.chargerLoc
                                                  .contactPhone[index];
                                              ctrl.makeACall(phone);
                                            },
                                            child: Text(ctrl.chargerLoc
                                                .contactPhone[index]),
                                          ),
                                        );

                                        Get.defaultDialog(
                                          title: "Please select contact no.",
                                          radius: 5.0,
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: children,
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(width: 10,),
                        (Get.find<AuthController>().chargerUser != null)
                            ? TextButton.icon(
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(color: Colors.blue),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  side: new BorderSide(color: k2rrorColor//Colors.blue
                                  ),
                                ),
                                icon: Icon(
                                  //  Icons.star_border_outlined,
                                  Get.find<AuthController>()
                                          .chargerUser
                                          .isFav(ctrl.chargerLoc.id)
                                      ? Icons.bookmark_outlined
                                      : Icons.bookmark_outline_rounded,
                                  color: k2rrorColor,//Colors.blue,
                                  size: 18,
                                ),
                                label: Text('Save', style: TextStyle(
                                  fontSize: 10,
                                  color: k2rrorColor,//Colors.blue,
                                 fontWeight: FontWeight.bold),),
                                onPressed: () {
                                  // ctrl.openMap(ctrl.chargerLoc.geoPoint.latitude, ctrl.chargerLoc.geoPoint.longitude);
                                  ctrl.handleFav(ctrl.chargerLoc);
                                },
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class ChargerListsSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  double _sectionHeight;

  ChargerListsSection(sectionHeight) {
    _sectionHeight = sectionHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      //initState: (_) {},
      builder: (ctrl) {
        print("ChargerListSection=>ctrl.charger= ${ctrl.charger}");
        if (ctrl.charger != null) {
          print("ChargerListSection=>ctrl.charger= ${ctrl.charger}");
          return SizedBox.shrink();
        }

        List<Widget> children = [];
        children.add(
          Column(
            children: [
              // SizedBox(
              //   height: 5,
              // ),
              Container(
                width: double.infinity,
                color: k2rrorColor,
                child: Center(
                  child: Text(
                    "Chargers",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    //style: _theme.boxPrimaryTextBold,
                  ),
                ),
              // ),
              // SizedBox(
              //   height: 5,
              ),
            ],
          ),
        );
        var rowGap = 10;
        var rowHeight = (_sectionHeight / 2.7) - rowGap;
        var idx = 0;
        if (ctrl.chargerLoc != null && ctrl.chargerLoc.chargers != null) {
          for (var charger in ctrl.chargerLoc.chargers) {
            children.add(ChargerMiniInfo(
              charger,
              (idx % 2 == 1) ? _theme.lightColor : _theme.greyColor,
              rowHeight,
            ));
            idx++;
          }
        }

        return Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          height: _sectionHeight,
          width: ctrl.screenW,
          //decoration: _theme.boxBorderBottomOnly,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChargerMiniInfo extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  Color color;
  double rowHeight;
  Charger charger;
  GMapController ctrl = Get.find<GMapController>();

  ChargerMiniInfo(this.charger, this.color, this.rowHeight);

  @override
  Widget build(BuildContext context) {
    List<Widget> connectors_ = [];
    for (var cnn in charger.connectors) {
      connectors_.add(
        Container(
          //color: Colors.indigoAccent,
          child: Icon(
            _theme.icons["cnn.connectorType"], //เปลี่ยน Icon
            color: cnn.status == "AVAILABLE"
                ? _theme.secondaryColor
                : _theme.darkColor,
            size: rowHeight * 0.65,
          ),
        ),
      );
      connectors_.add(SizedBox(
        width: 15,
      ));
    }
    connectors_.add(
      Icon(
        _theme.icons['RIGHT_ARROW'],
        color: _theme.secondaryColor,
        size: rowHeight * 0.65,
      ),
    );

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                charger.chargerName,
                style: _theme.boxSecondaryTextBold,
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: connectors_,
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          onTap: () {
            // _showChargerDetail(charger_);
            ctrl.charger = charger;
          },
          splashColor: _theme.secondaryColor,
        ),
      ),
      color: color,
      height: rowHeight,
    );
  }
}

class ChargerInfo extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  final double _sectionHeight;

  ChargerInfo(this._sectionHeight);

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (gMapController) {
        print(
            "ChargerInfo=> gMapController.charger = ${gMapController.charger}");
        if (gMapController.chargerLoc == null ||
            gMapController.charger == null) {
          return SizedBox.shrink();
        }

        List<Widget> children = [];
        children.add(
          InkWell(
            child: Container(
              //color: Colors.orange,
              child: Icon(
                Icons.menu_outlined,
                color: Colors.black,
              ),
            ),
            //Text(
            //   "< back",
            //   style: _theme.boxPrimaryTextBold,
            // ),
            onTap: () {
              gMapController.charger = null;
            },
          ),
        );

        children.add(
          Center(
            child: Text(
              gMapController.chargerLoc.locationName,
              style: _theme.boxPrimaryTextBold,
            ),
          ),
        );

        children.add(
          SizedBox(height: 10),
        );

        for (var cnn in gMapController.charger.connectors) {
          Color color;
          if (cnn.status == "AVAILABLE") {
            color = _theme.secondaryColor;
          } else if (cnn.status == "RESERVED") {
            color = _theme.warningColor;
          } else {
            color = _theme.greyColor;
          }
          var cnn_block = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              //Icon(_theme.icons['cnn.connectorType'], size: 50, color: color),// เปลี่ยน Icon
              RichText(
                  text: TextSpan(
                style: TextStyle(
                  fontSize: _theme.fontSizeBody1,
                  color: color,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: cnn.connectorName,
                      style: TextStyle(
                          fontSize: _theme.fontSizeHeader1,
                          fontWeight: FontWeight.bold)),
                  new TextSpan(
                      text:
                          "   ${cnn.status.substring(0, 1)}${cnn.status.substring(0).toLowerCase()}",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  new TextSpan(
                      text:
                          "\n${cnn.chargePrice[0].timeRateDisplay}\n ${cnn.chargePrice[0].actualRateDisplay}"),
                ],
              )),
              //Icon(_theme.icons[''], size: 50, color: color),// เปลี่ยน Icon
              SizedBox(
                width: 20,
              ),
            ],
          );

          children.add(Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10, top: 15),
            child: Material(
              child: InkWell(
                child: cnn_block,
                onTap: cnn.status == "AVAILABLE"
                    ? () {
                        // _selConnector = cnn;
                        // _startChargePage();
                        print("select ${cnn.connectorName}");
                        //go to select payment page
                        gMapController.toSelectPayment(cnn);
                      }
                    : () {
                        print("select ${cnn.connectorName}");
                        //Get.to(page)
                      },
                splashColor: color,
              ),
              color: _theme.lightColor,
            ),
          ));

          children.add(SizedBox(height: 10));
        }

        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(0),
          height: _sectionHeight + _sectionHeight,
          width: gMapController.screenW,
          //decoration: _theme.boxBorderBottomOnly,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:ez_mobile/view/components/EncryptUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ScanButton extends StatelessWidget {

  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      initState: (_) {},
      builder: (ctrl) {
        if (ctrl.isLocationSelect){
          var spaceW = 50;
          var paddingLR = spaceW / 2;
          var screenHeight = ctrl.screenH;
          screenHeight -= paddingLR;
          var boxTop = (screenHeight - paddingLR) / 3;

          boxTop -= (spaceW + paddingLR);
          return Container(
            margin: EdgeInsets.only(top: boxTop),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                //width: double.infinity,
                child: ElevatedButton(
                  style: _theme.scanButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Spacer(),
                        Icon(Icons.crop_free_outlined),
                        SizedBox(width: 5),
                        Text(
                          "Scan",
                          style: TextStyle(color: _theme.lightColor,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      //Spacer()
                      ],
                    ),
                  ),
                  onPressed: () async {
                    // final chargerInfo = "GREY_008";
                    if (Get
                        .find<AuthController>()
                        .chargerUser != null && Get
                        .find<AuthController>()
                        .chargerUser
                        .userID != null
                        && Get
                            .find<AuthController>()
                            .chargerUser != "") {
                      Get.toNamed("/scan-qr");
                      // final retVal = await FirebaseService.instance
                      //     .isChargerExist2(chargerInfo);
                      // print("retVal-> ${retVal["exists"]}");
                      // if (retVal["exists"] == true) {
                      //   //print(Get.find<GMapController>());
                      //   print("scanpage=>before cancel subscription sts1");
                      //   print("scanpage=>after cancel subscription sts1");
                      //   print("scanpage=>before call prepareCharger");
                      //   await Get.find<GMapController>().prepareCharger(
                      //       retVal["locationID"], chargerInfo, "1");
                        //controller.resumeCamera();
                      } else {
                        Get.toNamed("/login");
                      }
                    }
                  ),
              ),
            ),
          );

        }else {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                //width: double.infinity,
                child: ElevatedButton(
                  style: _theme.scanButtonStyle,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.crop_free_outlined),
                        SizedBox(width: 5),
                        Text(
                          "Scan",
                          style: TextStyle(color: _theme.lightColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    print(" Get.find<AuthController>().chargerUser ${Get.find<AuthController>().chargerUser}");
                    if ( Get.find<AuthController>().chargerUser != null && Get.find<AuthController>().chargerUser.userID != null
                    && Get.find<AuthController>().chargerUser != "") 
                    {
                      Get.toNamed("/scan-qr");
                    }else{
                      Get.toNamed("/login");
                    }
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
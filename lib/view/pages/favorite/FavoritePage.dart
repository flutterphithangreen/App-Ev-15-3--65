import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
//import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print("enter fav");
    CustomTheme _theme = CustomTheme.instance;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(children: [
              //MenuButton(),
              // EzCloseButton(
              //   onTap: (){
              //     Get.find<GMapController>().unloadAllSelection();
              //     Get.back();
              //     //print("custom ontap");
              //   },
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 20,
                  //   //height: kToolbarHeight*2,
                  // ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FavLists(),
                  ),
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

class FavLists extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    var favs = Get.find<AuthController>().chargerUser.favs;
    List<Widget> infos = [];
    infos.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text("Favorite Charger", 
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: _theme.primaryColor), )),
        )
    );

    for (var key in favs.keys){
      infos.add(FavInfo(key));
    }

    if (infos.length ==1){
      infos.add(
        Text("No Data", style:  _theme.boxSecondaryTextBold, )
      );
    }

    return Column(
      children: infos,
    );
  }
}

class FavInfo extends StatelessWidget{
  String chargerLoc;
  FavInfo(this.chargerLoc);

  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    return InkWell(
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              Icon(Icons.star,color: k1rrorColor,),
              SizedBox(width: 8,),
              Text(chargerLoc, style: TextStyle(fontSize: 16, color: k2rrorColor, fontWeight: FontWeight.w600 ) ,),
            ],
          ),
        ),
        elevation: 10,


      ),
      onTap: (){
        Get.find<GMapController>().toSelectLocation(chargerLoc);
      },
    );
  }

}
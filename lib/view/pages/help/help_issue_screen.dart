import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';

class HelpIssueScreen extends StatefulWidget {
  const HelpIssueScreen({Key key}) : super(key: key);

  @override
  _HelpIssueScreenState createState() => _HelpIssueScreenState();
}

class _HelpIssueScreenState extends State<HelpIssueScreen> {
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
          padding: const EdgeInsets.only(left: 12.0, top: 5, bottom: 5),
          child: Image.asset(
            "images/logo-p.png",
            width: 100,
            //height: 50,
          ),
        ),
        title: Text(
          "Issue with a recent charger",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Material(
          child: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
          child: Column(
            children: [
              Text(
                "Coming Soon",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: Lottie.network(
                    "https://assets4.lottiefiles.com/packages/lf20_ypntxt2o.json"),
              )
            ],
          ),
        ),
      )),
    );
  }
}

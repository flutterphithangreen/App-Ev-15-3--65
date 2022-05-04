import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/pages/ChargingPage/ChargingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      builder: (ctrl) {
        final url =
            "https://ezev.app/2c2p-payment?amt=${ctrl.transaction.totalCostDisplay}&ref1=${ctrl.transaction.transID}";
        print("ctrl.transaction=${ctrl.transaction}");
        if (ctrl.transaction == null ||
            ctrl.transaction.payeeRef == null ||
            ctrl.transaction.payeeRef == "") {
          print("PaytmentPage=> Get In");
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text('Plux Payment'),
            ),
            body: Material(
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          );
        } else {
          print("PaymentPage=> Paid Complete");
          Future.microtask(() => ctrl.finishChargeNew());
          //WidgetsBinding.instance.addPostFrameCallback((_) => Get.toNamed("/charging-page"));
          return SizedBox.shrink();
        }
      },
    );
  }
}

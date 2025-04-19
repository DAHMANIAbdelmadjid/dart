import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TelegramAndWhatsapp extends StatelessWidget {
  const TelegramAndWhatsapp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.telegram,
                color: Colors.blue,
                size: AppSize.s100,
              )),
          Text(
            "Telegram",
            style: TextStyle(
                fontSize: FontSize.s50,
                fontWeight: FontWeightManger.bold,
                color: Colors.blue),
          ),
          Text(
            "OR",
            style: TextStyle(
                fontSize: FontSize.s50,
                fontWeight: FontWeightManger.bold,
                color: Colors.grey),
          ),
          IconButton(
              onPressed: () => {
                    launchUrl(Uri.parse(
                        "https://www.youtube.com/watch?v=qYxRYB1oszw&ab_channel=FlutterExplained"))
                  },
              icon:
                  Icon(Icons.wechat, color: Colors.green, size: AppSize.s100)),
          Text(
            "Whatsapp",
            style: TextStyle(
                fontSize: FontSize.s50,
                fontWeight: FontWeightManger.bold,
                color: Colors.green),
          ),
        ],
      ),
    )));
  }
}

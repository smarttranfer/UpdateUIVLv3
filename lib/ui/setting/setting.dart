import 'dart:ui';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/theme/Color_app.dart';

class SettingsPage extends StatelessWidget {
  void removedata() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("password");
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor: App_Color.Background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: App_Color.Background,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.language_outlined,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.red,
                    ),
                    title: 'Đổi Ngôn Ngữ',
                    subtitle: "Dổi ngôn ngữ.",
                  ),
                ],
              ),
              SettingsGroup(

                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.monetization_on_outlined,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.red,
                    ),
                    title: 'Đổi Đơn Vị Tiền Tệ',
                    subtitle: "Đơn vị tiền tệ sẽ được đổi sang loại khác.",
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.red,
                    ),
                    title: 'Thông Tin Phần Mềm',
                    subtitle: "Các chi tiết về thông tin app và nhà vận hành.",
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                items: [
                  SettingsItem(
                    icons: Icons.logout,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.red,
                    ),
                    onTap: () {

                      showCupertinoDialog(
                          context: context,
                          builder: (context) => Theme(
                                data: ThemeData.dark(),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                  child: CupertinoAlertDialog(
                                      title: Text("Infomation"),
                                      content: Text(
                                          "Do you want close app ?"),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: App_Color.green),
                                            ),
                                            onPressed: () {
                                              removedata();
                                              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

                                            }),

                                        CupertinoDialogAction(
                                            child: Text("Close",
                                              style: TextStyle(color: App_Color.green),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context))
                                      ]),
                                ),
                              ));


                    },
                    title: "Đăng suất",
                    subtitle: "Thoát app",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

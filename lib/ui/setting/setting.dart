import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vldebitor/constants/constant_app.dart';
import 'package:vldebitor/theme/Color_app.dart';

class SettingsPage extends StatelessWidget {

  void removedata() async{
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
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // User card
              BigUserCard(
                cardColor: App_Color.background_textfield,
                userName: constant.user,
                userProfilePic: AssetImage("assets/ic_app/ic_avata.jpg"),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Dark mode',
                    subtitle: "Automatic",
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'About',
                    subtitle: "Learn more about Vihu",
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
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
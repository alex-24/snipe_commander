

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import 'theme.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:snipe_commander/view_controller/pages/contact/contact_page.dart';

//ARTICLES LIST-----------------------------------------------------------------

enum MainMenuDestinationItem{
  HomePage,
  WalletConfigurationPage,
  DefaultPreferencesPage,
}

extension SideDrawerMenuExtension on MainMenuDestinationItem {

  String get label {
    switch (this){
      case MainMenuDestinationItem.HomePage:
        return "Home";

      case MainMenuDestinationItem.WalletConfigurationPage:
        return "Wallet Config";

      case MainMenuDestinationItem.DefaultPreferencesPage:
        return "Default Preferences";

      default:
        throw("unsupported item ${this}");
    }
  }

  IconData get icon {
    switch (this){
      case MainMenuDestinationItem.HomePage:
        return Icons.home;

      case MainMenuDestinationItem.WalletConfigurationPage:
        return Icons.account_balance_wallet;

      case MainMenuDestinationItem.DefaultPreferencesPage:
        return Icons.settings_applications;

      default:
        throw("unsupported item ${this}");
    }
  }

  void onSelect(BuildContext context, AppThemeProvider appThemeProvider, Function onPageChange) {
    switch (this){
      case MainMenuDestinationItem.HomePage:
      case MainMenuDestinationItem.WalletConfigurationPage:
      case MainMenuDestinationItem.DefaultPreferencesPage:
        Navigator.of(context).pop();
        Function.apply(onPageChange, [this]);
        break;
      default:
        throw("unsupported item ${this}");
    }
  }
}

class SideDrawerMenu extends StatelessWidget{

  final MainMenuDestinationItem selectedItem;
  final List<MainMenuDestinationItem> disabledItems;
  final AppThemeProvider appThemeProvider;
  final Function onPageChange;

  SideDrawerMenu({
    required this.selectedItem,
    required this.disabledItems,
    required this.appThemeProvider,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = this
        .appThemeProvider
        .currentTheme
        .drawerTextColor;
    Color textColorContrast = this
        .appThemeProvider
        .currentTheme
        .regularTextColor;
    Color iconColor = this
        .appThemeProvider
        .currentTheme
        .drawerIconColor;

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(.2), width: .5),)
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          intensity: 1.0,
          depth: 2.0,
          boxShape: NeumorphicBoxShape.rect(),
        ),
        child: Drawer(
          elevation: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            color: this
                .appThemeProvider
                .currentTheme
                .neumorphicBackgroundColor,
            child: Column(
              children: <Widget>[
                Neumorphic(
                  style: NeumorphicStyle(
                    intensity: 1.0,
                    depth: 1.0,
                    boxShape: NeumorphicBoxShape.rect(),
                    color: this
                        .appThemeProvider
                        .currentTheme
                        .backgroundColor,
                  ),
                  child: DrawerHeader(
                    margin: EdgeInsets.zero,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.0,
                              left: 8.0,
                            ),
                            child: Text(
                              "SNIPE COMMANDER",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: textColor),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 10.0,
                              height: 10.0,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      //color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      for (MainMenuDestinationItem item in MainMenuDestinationItem.values)
                        if (!this.disabledItems.contains(item))
                          Container(
                            //color: (item != excludedItem)? null : this.timelyThemeProvider.currentTheme.invert.neumorphicBackgroundColor.withOpacity(.1),
                            color: (item != selectedItem)? null : Colors.blueAccent.withOpacity(.2),
                            child: ListTile(
                              leading: Icon(item.icon, color: (item != selectedItem)? textColor : textColorContrast,),
                              title: Text(item.label, style: TextStyle(
                                color: (item != selectedItem)? textColor : textColorContrast,
                                fontWeight: (item != selectedItem)? null : FontWeight.bold,
                              ),),
                              onTap: () {
                                item.onSelect(context, appThemeProvider, this.onPageChange);
                              },
                            ),
                          ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Theme", style: TextStyle(fontWeight: FontWeight.bold, color: textColor),),
                      ),
                      ListTile(
                        leading: Container(
                          width: 24.0,
                          height: 24.0,
                          child: Center(
                            child: Transform(
                              transform: Matrix4.rotationY(pi),
                              alignment: Alignment.center,
                              child: Icon(Icons.brightness_2, color: iconColor,),
                            ),
                          ),
                        ),
                        title: Row(
                          children: <Widget>[
                            Expanded(child: Text("Dark Mode", style: TextStyle(color: textColor),)),
                            Switch(
                              value: Provider.of<AppThemeProvider>(context).currentTheme == AppTheme.Dark,
                              onChanged: (value) {
                                this.appThemeProvider.setTheme(this.appThemeProvider.currentTheme.invert);
                              },
                            )
                          ],
                        ),
                        onTap: () {

                        },
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Offers", style: TextStyle(fontWeight: FontWeight.bold, color: textColor),),
                      ),
                      ListTile(
                        leading: Icon(Icons.monetization_on, color: iconColor,),
                        title: Text("Premium", style: TextStyle(color: textColor,),),
                        onTap: () {

                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.videocam, color: iconColor,),
                        title: Text("Snooze ads (12h)", style: TextStyle(color: textColor,),),
                        onTap: () {

                        },
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Contact", style: TextStyle(fontWeight: FontWeight.bold, color: textColor,),),
                      ),
                      ListTile(
                        leading: Icon(Icons.alternate_email, color: iconColor,),
                        title: Text("Send us an email", style: TextStyle(color: textColor,),),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return ContactPage(
                                appThemeProvider: appThemeProvider,
                              );
                            }),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.error_outline, color: iconColor,),
                        title: Text("Tell us about a problem", style: TextStyle(color: textColor),),
                        onTap: () {
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

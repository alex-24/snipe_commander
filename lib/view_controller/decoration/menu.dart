

import 'dart:math';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
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
                          BetterFeedback.of(context).show();
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


class TimelyAppbar extends StatelessWidget {
  final Function onActionButtonPressed;
  final IconData actionButtonIconData;
  final ShowCaseElement actionButtonShowCaseElement;
  final List<Widget> appbarContent;
  final AppThemeProvider appThemeProvider;
  final bool isRootPage;
  final Color? homeButtonColor;
  final Color? homeButtonIconColor;
  final double homeButtonDepth;
  final Color? backgroundColor;

  const TimelyAppbar({
    Key? key,
    required this.onActionButtonPressed,
    required this.actionButtonIconData,
    required this.actionButtonShowCaseElement,
    required this.appbarContent,
    required this.appThemeProvider,
    this.isRootPage = true,
    this.homeButtonColor,
    this.homeButtonIconColor,
    this.homeButtonDepth = 0.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 1,
          boxShape: NeumorphicBoxShape.rect(),
          intensity: 1.0,
          shadowLightColor: Colors.transparent,
          shadowLightColorEmboss: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: this.backgroundColor ?? Provider.of<AppThemeProvider>(context).currentTheme.backgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 75,
                  child: Showcase(
                    key: (!this.isRootPage)? GlobalKey() : ShowCaseUtils().getGlobalKey(
                        ShowCaseElement.HOME_OPTIONS_MENU),
                    title: ShowCaseElement
                        .HOME_OPTIONS_MENU.title,
                    description: ShowCaseElement
                        .HOME_OPTIONS_MENU.subtitle,
                    showArrow: true,
                    contentPadding: EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (context) {
                        return Material(
                          color: Colors.transparent,
                          child: IntrinsicHeight(
                            child: Neumorphic(
                              margin: EdgeInsets.only(top: 14.0, bottom: 14.0, left: (this.homeButtonColor == null) ? 0 :  8.0, right: (this.homeButtonColor == null) ? 0 :  8.0,),
                              style: NeumorphicStyle(
                                depth: this.homeButtonDepth,
                                color: this.homeButtonColor ?? Colors.transparent,
                                oppositeShadowLightSource: this.homeButtonDepth < 0,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    //showMagazineQuickAccessDialog(context);
                                    if (this.isRootPage) {
                                      Scaffold.of(context).openDrawer();
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  splashColor: Colors.grey[800],
                                  enableFeedback: true,
                                  icon: Icon(
                                    (this.isRootPage)? Icons.menu : Icons.arrow_back,
                                    color: (this.homeButtonColor != null)
                                        ? this.homeButtonIconColor ?? ColorUtils.blackOrWhiteForBackground(this.homeButtonColor!)
                                        : this
                                        .appThemeProvider
                                        .currentTheme
                                        .regularTextColor,
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
              Text("SNIPE COMMANDER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),)
            ],
          ),
        ),
      ),
    );
  }
}

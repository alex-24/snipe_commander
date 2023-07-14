
import "package:flutter/material.dart";
import "package:flutter_neumorphic/flutter_neumorphic.dart";

import "package:contactus/contactus.dart";
import 'package:provider/provider.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import '../../decoration/showcase.dart';
import '../../decoration/theme.dart';
import 'package:snipe_commander/view_controller/decoration/menu.dart';

class ContactPage extends StatefulWidget {
  final AppThemeProvider appThemeProvider;

  ContactPage({
    Key? key,
    required this.appThemeProvider,
  }) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          TimelyAppbar(
            appThemeProvider: this.widget.appThemeProvider,
            onActionButtonPressed: (){
            },
            actionButtonIconData: Icons.search,
            actionButtonShowCaseElement: ShowCaseElement.HOME_QUICKSTART_LAUNCHER_BUTTON,
            appbarContent: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 16.0, left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Contact us",
                        style: TextStyle(
                            color: (Provider.of<AppThemeProvider>(
                                context)
                                .currentTheme as AppTheme)
                                .regularTextColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Pick any of the following",
                        style: TextStyle(
                          color: this
                              .widget
                              .appThemeProvider
                              .currentTheme
                              .regularTextColor,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ContactUs(
            //cardColor: this.widget.timelyThemeProvider.currentTheme.neumorphicBackgroundColor,
            //textColor: this.widget.timelyThemeProvider.currentTheme.regularTextColor,
            companyColor: this.widget.appThemeProvider.currentTheme.regularTextColor,
            taglineColor: this.widget.appThemeProvider.currentTheme.regularTextColor,
            logo: AssetImage("assets/timely_logo_gradient.png"),
            companyName: "SNIPE COMMANDER",
            tagLine: "PancakeSwap Version",
            website: "https://snipecommander.crypto",
            websiteText: "https://snipecommander.crypto",
            phoneNumber: "+33 (0)6 58 23 76 55",
            phoneNumberText: "+33 (0)6 58 23 76 55",
            email: "contact@snipecommander.com",
            emailText: "contact@snipecommander.com",
            //linkedinURL: "https://www.linkedin.com/in/alexis-cassion/",
          ),
        ],
    );
  }
}
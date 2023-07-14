import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:snipe_commander/data/database/database.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:snipe_commander/view_controller/pages/home/liquidity_list.dart';
import 'package:snipe_commander/view_controller/pages/home/snipe_form.dart';
import '../../decoration/theme.dart';
import 'package:snipe_commander/view_controller/decoration/menu.dart';

class HomePage extends StatefulWidget {
  final AppThemeProvider appThemeProvider;

  HomePage({
    Key? key,
    required this.appThemeProvider,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSnipeFormVisible = false;
  dynamic snipeFormData;
  Token? tokenToBuy;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          //if (!this.isSnipeFormVisible)
            TimelyAppbar(
              onActionButtonPressed: () {},
              actionButtonIconData: Icons.ac_unit,
              actionButtonShowCaseElement:
                  ShowCaseElement.ADD_ARTICLE_CONFIRMATION_BUTTON,
              appbarContent: [],
              appThemeProvider: this.widget.appThemeProvider,
            ),
          //if (!this.isSnipeFormVisible)
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 1,
                        boxShape: NeumorphicBoxShape.rect(),
                        intensity: 1.0,
                        shadowLightColor: Colors.transparent,
                        shadowLightColorEmboss: Colors.transparent,
                        color: this
                            .widget
                            .appThemeProvider
                            .currentTheme
                            .backgroundColor,
                      ),
                      child: TabBar(
                          indicatorColor: this
                              .widget
                              .appThemeProvider
                              .currentTheme
                              .regularTextColor,
                          labelColor: this
                              .widget
                              .appThemeProvider
                              .currentTheme
                              .regularTextColor,
                          tabs: [
                            Tab(
                              //icon: Icon(Icons.flash_auto),
                              text: "SNIPES",
                            ),
                            Tab(
                              //icon: Icon(Icons.pool),
                              text: "LIQUIDITY",
                            ),
                            Tab(
                              icon: Icon(Icons.history),
                              //text: "HISTORY",
                            ),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Text("SNIPE LIST"),
                        LiquidityList(
                          onLiquidityClick:
                              (Liquidity liquidity, Token tokenToBuy) {
                            toggleSnipeFormVisibility(liquidity, tokenToBuy);
                          },
                        ),
                        Text("SNIPE HISTORY LIST"),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: (!this.isSnipeFormVisible) ? 0 : 1,
              child: AnimatedContainer(
                color: this
                    .widget
                    .appThemeProvider
                    .currentTheme
                    .backgroundColor,
                height: (!this.isSnipeFormVisible)
                    ? 0.0
                    : MediaQuery.of(context).size.height,
                duration: Duration(
                  milliseconds: 300,
                ),
                child: (!this.isSnipeFormVisible)
                    ? Container()
                    : Container(
                  padding: EdgeInsets.only(top: 8.0),
                      child: Neumorphic(
                          style: NeumorphicStyle(
                            depth: 1,
                            boxShape: NeumorphicBoxShape.rect(),
                            intensity: 1.0,
                            oppositeShadowLightSource: true,
                            shadowLightColor: Colors.transparent,
                            shadowLightColorEmboss: Colors.transparent,
                            color: this
                                .widget
                                .appThemeProvider
                                .currentTheme
                                .backgroundColor,
                          ),
                          child: SnipeForm(
                            snipeFormData: this.snipeFormData,
                            onCloseButtonPressed: () {
                              toggleSnipeFormVisibility(null, null);
                            },
                          ),
                        ),
                    ),
              ),
            ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !isSnipeFormVisible,
        child: FloatingActionButton(
          backgroundColor: Provider.of<AppThemeProvider>(context)
              .currentTheme
              .invert
              .neumorphicBackgroundColor,
          child: Icon(
            Icons.flash_on,
            color: Provider.of<AppThemeProvider>(context)
                .currentTheme
                .invert
                .regularTextColor,
          ),
          onPressed: () {
            toggleSnipeFormVisibility(null, null);
          },
        ),
      ),
    );
  }

  void toggleSnipeFormVisibility(dynamic data, Token? tokenToBuy) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Provider.of<AppThemeProvider>(context, listen: false).currentTheme.backgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 30.0,
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: SnipeForm(snipeFormData: data,
            onCloseButtonPressed: (){
            Navigator.of(context).pop();
          },),
        );
      },
    );
    /*setState(() {
      if (data != null) {
        this.snipeFormData = data;
        this.tokenToBuy = tokenToBuy;
        this.isSnipeFormVisible = true;
      } else {
        this.snipeFormData = null;
        this.tokenToBuy = null;
        this.isSnipeFormVisible = !this.isSnipeFormVisible;
      }
    });*/
  }
}

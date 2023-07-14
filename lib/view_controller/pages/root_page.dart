
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import 'package:snipe_commander/view_controller/decoration/menu.dart';
import 'package:snipe_commander/view_controller/pages/home/home_page.dart';



class RootPage extends StatefulWidget {
  final AppThemeProvider appThemeProvider;

  RootPage({
    Key? key,
    required this.appThemeProvider,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  late Widget homePage;
  late Widget walletConfigurationPage;
  late Widget defaultPreferencesPage;

  final GlobalKey homePageKey = GlobalKey();
  final GlobalKey walletConfigurationPageKey = GlobalKey();
  final GlobalKey defaultPreferencesPageKey = GlobalKey();

  late Widget currentPage;
  late MainMenuDestinationItem currentPageEnum;

  @override
  void initState() {
    this.homePage = HomePage(appThemeProvider: this.widget.appThemeProvider,);
    this.walletConfigurationPage = Text("WALLET CONFIGURATION PAGE");
    this.defaultPreferencesPage = Text("DEFAULT PREFERENCES PAGE");

    this.currentPage = this.homePage;
    this.currentPageEnum = MainMenuDestinationItem.HomePage;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawerMenu(
        appThemeProvider: this.widget.appThemeProvider,
        selectedItem: this.currentPageEnum,
        disabledItems: [],
        onPageChange: (MainMenuDestinationItem destination) {
          setCurrentPage(destination);
        },
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(.2), width: .5),
        )),
        child: this.currentPage,
      ),
    );
  }

  void setCurrentPage(MainMenuDestinationItem destination) {
    setState(() {
      this.currentPageEnum = destination;

      switch (destination) {
        case MainMenuDestinationItem.HomePage:
          this.currentPage = homePage;
          break;

        case MainMenuDestinationItem.WalletConfigurationPage:
          this.currentPage = walletConfigurationPage;
          break;

        case MainMenuDestinationItem.DefaultPreferencesPage:
          this.currentPage = defaultPreferencesPage;
          break;

        default:
          throw ("unsupported value");
      }
    });
  }
}

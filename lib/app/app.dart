import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:snipe_commander/data/blockchain/decentralized_swaps.dart';
import 'package:snipe_commander/data/database/database.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import 'package:snipe_commander/data/providers/decentralized_swap_event_provider.dart';
import 'package:snipe_commander/data/providers/snipe_battlefield_info_provider.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:web3dart/web3dart.dart';
import '../view_controller/decoration/theme.dart';
import 'package:snipe_commander/view_controller/pages/root_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(onStart);
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final AppThemeProvider appThemeProvider = AppThemeProvider(preferences);

  runApp(
    NeumorphicApp(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
          baseColor: Color(0xffd8d8d8),
          lightSource: LightSource.topLeft,
          depth: 2,
          intensity: 1.0,
          shadowLightColor: Colors.transparent,
          shadowLightColorEmboss: Colors.transparent,
          textTheme: Typography.blackCupertino,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 2,
        intensity: 1.0,
        shadowLightColor: Colors.transparent,
        shadowLightColorEmboss: Colors.transparent,
      ),
      home: Stack(
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: SplashScreen(
              seconds: 2,
              navigateAfterSeconds: App(
                appThemeProvider: appThemeProvider,
              ),
              title: Text("Snipe Commander"),
              image: Image.asset('assets/timely_logo_gradient2.png'),
              backgroundColor: appThemeProvider.currentTheme.neumorphicBackgroundColor,
              //styleTextUnderTheLoader: new TextStyle(),
              loadingText: Text(
                "Version 1.0\n© Timely 2020",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appThemeProvider.currentTheme.regularTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              photoSize: 100.0,
              useLoader: false,
              //loaderColor: timelyThemeProvider.currentTheme.highlightColor
            ),
          ),
          Shimmer.fromColors(
            //baseColor: timelyThemeProvider.currentTheme.highlightColor,
            //baseColor: timelyThemeProvider.currentTheme.invert.neumorphicBackgroundColor,
            baseColor:
            appThemeProvider.currentTheme.neumorphicBackgroundColor,
            //baseColor: Colors.blueAccent,
            //highlightColor: TimelyTheme.Dark.regularTextColor,
            highlightColor: appThemeProvider.currentTheme.regularTextColor,
            //highlightColor: timelyThemeProvider.currentTheme.highlightColor,
            period: Duration(seconds: 2),
            child: Center(
              child: Text(
                "Welcome back",
                //"Timely".toUpperCase(),
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  //color: timelyThemeProvider.currentTheme.regularTextColor,
                  decoration: TextDecoration.none,
                  //fontFamily: "woodhouse",
                  //fontFamily: "woodpecker_2",
                  fontFamily: "Roboto",
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Client httpClient;
  Web3Client web3Client;
  DeployedContract decentralizedSwapContract;
  List<Liquidity> detectedLiquidities = [];
  List<Token> knownTokens = [];

  httpClient = Client();
  web3Client =
      Web3Client(DecentralizedSwaps.PANCAKE_SWAP.providerURL, httpClient);

  // load the swap contract
  ContractUtils.loadContract(
    contractName: SnipeBattlefieldInfoProvider.SWAP_DAPP.FACTORY_name,
    contractAddressHex:
    SnipeBattlefieldInfoProvider.SWAP_DAPP.FACTORY_contract,
    contractABIJson: SnipeBattlefieldInfoProvider.SWAP_DAPP.ABI,
  ).then((swapContract) {
    decentralizedSwapContract = swapContract;

    //contract.abi.events.forEach((element) {print("---------------------${element.name}");});

    // set the event filter
    web3Client
        .events(FilterOptions.events(
      contract: decentralizedSwapContract,
      event: decentralizedSwapContract.abi.events[0],
    ))
        .listen((event) {

      String token1 = sanitizeTokenAddress(event.topics![1]);
      String token2 = sanitizeTokenAddress(event.topics![2]);

      bool isNewTokenToken1 = (token1 !=
          SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1 &&
          token1 !=
              SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2);

      String tokenToSpendAddress = (isNewTokenToken1)? token2 : token1;
      String tokenToBuyAddress = (isNewTokenToken1)? token1 : token2;

      AppDatabase().snipeDao.insertLiquidityModel(
        tokenToSpendAddress: tokenToSpendAddress,
        tokenToBuyAddress: tokenToBuyAddress,
      ).then((liquidityId) {

        ContractUtils.loadContract(
            contractName: "",
            contractABIJson: SnipeBattlefieldInfoProvider.SWAP_DAPP.ERP_20_ABI,
            contractAddressHex: tokenToBuyAddress).then((erc20Contract) {


          Token token = Token(address: tokenToBuyAddress);

          /*List<String> functionNames = ["name", "symbol"];
                List<Function> functionCallBacks = [
                  (name) =>  token = token.copyWith(name: name),
                  (symbol) =>  token = token.copyWith(name: symbol),
                ];*/


          ContractUtils.callFunction(
              web3Client: web3Client,
              functionName: "name",
              contract: erc20Contract,
              params: []).then((name){

            ContractUtils.callFunction(
                web3Client: web3Client,
                functionName: "symbol",
                contract: erc20Contract,
                params: []).then((symbol){
              print("----------------------------------------------$name");
              print("----------------------------------------------$symbol");
              token = token.copyWith(name: name[0], symbol: symbol[0]);
              AppDatabase().snipeDao.replaceTokenModel(token).then((value) {

                service.setNotificationInfo(
                  title: "Liquidity Patrol",
                  content: "${Jiffy(DateTime.now()).format("dd MMMM yyy\nhh:mm a")} : $name",
                );
              });
            });
          });
        });

      });
    });
  });
}

String sanitizeTokenAddress(String tokenAddress) {

  tokenAddress = tokenAddress.substring(2);

  for (int i=0; i<tokenAddress.length; i++) {
    if (tokenAddress[i] != '0') {
      tokenAddress = tokenAddress.substring(i);
      break;
    }
  }

  tokenAddress = "0x" + tokenAddress;

  return tokenAddress;

  /*print("### ");
    print("### " + tokenAddress);
    print("### " + SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1);
    print("### " + SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2);
    print("### ");
    print("------ ");

    if (tokenAddress.trim() ==
        SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1)
      return SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1_name;

    if (tokenAddress.trim() ==
        SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2)
      return SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2_name;
    else
      return tokenAddress.trim();*/
}

class App extends StatefulWidget {
  //final SharedPreferences preferences;

  final AppThemeProvider appThemeProvider;

  App({
    Key? key,
    required this.appThemeProvider,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final rootPageKey = GlobalKey();

  _AppState();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;

      case AppLifecycleState.inactive:
    }
  }*/

  @override
  Widget build(BuildContext context) {

    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => this.widget.appThemeProvider),
              ChangeNotifierProvider(create: (_) => SnipeCommander()),
            ],
            child: NeumorphicApp(
                debugShowCheckedModeBanner: false,
                title: 'SNIPE COMMANDER',
                home: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: RootPage(
                        key: this.rootPageKey,
                        appThemeProvider: this.widget.appThemeProvider,
                      )
                  ),
                )
              //], child: MyHomePage(title: 'My Note Shelf')),
            ),
          );
        },
      ),
    );
  }
}

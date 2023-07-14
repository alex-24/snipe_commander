import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:jiffy/jiffy.dart';
import 'package:snipe_commander/data/database/database.dart';
import 'package:snipe_commander/data/providers/snipe_battlefield_info_provider.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
  String sanitize() {
    return this.trim().toLowerCase();
  }
}

class ColorUtils {
  static final Color defaultDarkShadowColor =
      NeumorphicColors.decorationMaxDarkColor;

  static Color randomColor() {
    return Color(0xff000000 + Random().nextInt(0x00ffffff));
  }

  static Color randomMaterialColor() {
    List colors = Colors.primaries;
    return colors[Random().nextInt(colors.length)];
  }

  static List<Color> randomColorArray(int size) {
    List<Color> res = [];

    for (int i = 0; i < size; i++)
      res.add(Color(0xff000000 + Random().nextInt(0x00ffffff)));

    return res;
  }

  static Color blackOrWhiteForBackground(Color backgroundColor) {
    return TinyColor(backgroundColor).isDark() ? Colors.white : Colors.black;
  }

  static Color oppositeBlackOrWhiteForBackground(Color backgroundColor) {
    return TinyColor(backgroundColor).isDark() ? Colors.black : Colors.white;
  }

  static Color darken(Color color, [int amount = 10]) {
    return TinyColor(color).darken(amount).color;
  }

  static Color lighten(Color color, [int amount = 10]) {
    return TinyColor(color).lighten(amount).color;
  }

  static Color complement(Color color) {
    return TinyColor(color).complement().color;
  }

  static Color grayscale(Color color) {
    return TinyColor(color).greyscale().color;
  }

  static Color spin(Color color, [double amount = 120.0]) {
    return TinyColor(color).spin(amount).color;
  }

  /// color must be in 0xXXXXXXX format; Defaults to transparent
  static Color fromHexString(String color) {
    if (color == null || color.length == null) return Colors.transparent;

    int start = color.indexOf("0x");
    int end = start + 10;
    Color res = Color(int.parse(color.substring(start, end)));
    return res;
  }
}

enum DateDisplayType {
  SHORT,
  LONG,
}

class DateTimeUtils {
  //static String dateFormat = "d MMM yyyy hh:mm";
  static String dateFormat = "dd/MM/yyyy hh:mm";

  static String parseDate(DateTime dateTime) {
    return Jiffy(dateTime).format(dateFormat);
  }
}

class TokenUtils {

  static Token? getTokenFromAddress({
    required List<Token> tokenList,
    required String? tokenAddress,
  }) {
    for (Token t in tokenList) {
      if (t.address == tokenAddress) {
        return t;
      }
    }

    return null;
  }

  static String? parseTokenToBuyName({
    required List<Token> tokenList,
    required String tokenToBuyAddress,
    required bool parseAsMultiline,
    String defaultValue = ""}) {

    Token? token = TokenUtils.getTokenFromAddress(
        tokenList: tokenList,
        tokenAddress: tokenToBuyAddress,
    );

    if (token != null) {
      String res = token.name!;
      if (token.symbol != null && token.symbol != "" && token.symbol != token.name) res += (parseAsMultiline) ? "\n(${token.symbol})" : " (${token.symbol})";
      return res;
    }

    return null;
  }

  static Token? decodeTokenToSpend(String? tokenToSpendAddress) {

    if (tokenToSpendAddress == null)
      return null;

    if (tokenToSpendAddress.trim() ==
        SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1.address) {
      return SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1;
    }
    if (tokenToSpendAddress.trim() ==
        SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2.address) {
      return SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2;
    }

    return null;
  }

  static void openPooCoinPage({
    required String tokenAddress,
    Color? toolbarColor,
    Color? navColor,
  }) {
    NetUtils.openWebPage(
      url: "https://poocoin.app/tokens/$tokenAddress",
      toolbarColor: toolbarColor,
      navColor: navColor,
    );
  }

  static void openBscScanPage({
    required String tokenAddress,
    Color? toolbarColor,
    Color? navColor,
  }) {
    NetUtils.openWebPage(
      url: "https://bscscan.com/address/$tokenAddress",
      toolbarColor: toolbarColor,
      navColor: navColor,
    );
  }

  static bool verifyAddressLength(String tokenAddress) {
    return tokenAddress.length == 42;
  }

  static Color? parseColorForToken(String? tokenAddress) {

    //return Color(int.parse("ff${tokenAddress.substring(tokenAddress.length - 8, tokenAddress.length - 2)}", radix: 16));
    return (tokenAddress == null)? null : Color(int.parse("ff${tokenAddress.substring(2, 2+6)}", radix: 16));
  }
}

class NetUtils {

  static void openWebPage({
    required String url,
    Color? toolbarColor,
    Color? navColor,
  }) {

    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        toolbarColor: toolbarColor,// Colors.deepPurple,
        //secondaryToolbarColor: Colors.green,
        navigationBarColor: navColor,// Colors.amber,
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: toolbarColor,// Colors.green,
        preferredControlTintColor: navColor,// Colors.amber,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }
}
class ContractUtils {

  static Future<DeployedContract> loadContract({
    required String contractName,
    required String contractAddressHex,
    required String contractABIJson,
  }) async {
    return DeployedContract(ContractAbi.fromJson(contractABIJson, contractName), EthereumAddress.fromHex(contractAddressHex));
  }

  static Future<List<dynamic>> callFunction({
    required Web3Client web3Client,
    required functionName,
    required DeployedContract contract,
    required List<dynamic> params
  }) async {

    ContractFunction function = contract.function(functionName);
    return await web3Client.call(
        contract: contract,
        function: function,
        params: params
    );
  }
}



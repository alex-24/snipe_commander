import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
import 'package:snipe_commander/data/database/database.dart';
import 'package:snipe_commander/data/database/db_dao_&_tables.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import 'package:snipe_commander/data/providers/decentralized_swap_event_provider.dart';
import 'package:snipe_commander/data/providers/snipe_battlefield_info_provider.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:snipe_commander/view_controller/decoration/theme.dart';
import 'package:tinycolor/tinycolor.dart';

enum SnipeFormType {
  DEFAULT_CONFIG,
  NEW_SNIPE,
  INVEST,
}

typedef OnSnipeConfirm = Function(
    String tokenToBuyAddress,
    String tokenSpendAddress,
    String spendAmount,
    String slippage,
    String gas,
    String buyTrigger,
    String sellTrigger,
    );

class SnipeForm extends StatefulWidget {
  late final Function onCloseButtonPressed;
  late final dynamic snipeFormData;
  //late final OnSnipeConfirm onSnipeConfirmed;

  SnipeFormType snipeFormType = SnipeFormType.NEW_SNIPE;

  String? tokenToBuyAddress;
  String? tokenToSpendAddress;
  double spendAmount = 0.1; // todo:  read from default config
  double slippage = 8; //   todo:  read from default config
  int gas = 15; //     todo:  read from default config

  SnipeForm({required this.snipeFormData, required this.onCloseButtonPressed}) {
    if (snipeFormData is Liquidity) {
      snipeFormType = SnipeFormType.INVEST;
      tokenToBuyAddress = (snipeFormData as Liquidity).tokenToBuyAddress;
      tokenToSpendAddress = (snipeFormData as Liquidity).tokenToSpendAddress;
    }
  }

  @override
  _SnipeFormState createState() => _SnipeFormState();
}

class _SnipeFormState extends State<SnipeForm> {
  late List<Token> tokenList;
  late Token? tokenToBuy;
  late String? tokenToBuyName;
  late Token tokenToSpend;

  List<Token> spendingCurrencyType = [
    SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1,
    SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2,
  ];

  late TextEditingController tokenToBuyTextController;
  late TextEditingController spendAmountTextController;
  late TextEditingController slippageTextController;
  late TextEditingController gasTextController;
  late TextEditingController buyTriggerTextController;
  late TextEditingController sellTriggerTextController;

  @override
  void initState() {

    tokenToBuyTextController = TextEditingController(text: widget.tokenToBuyAddress);
    tokenToSpend = TokenUtils.decodeTokenToSpend(widget.tokenToSpendAddress) ?? SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1;
    spendAmountTextController = TextEditingController(text: "${widget.spendAmount}");
    slippageTextController = TextEditingController(text: "${widget.slippage}");
    gasTextController = TextEditingController(text: "${widget.gas}");
    buyTriggerTextController = TextEditingController(text: "0.1");
    sellTriggerTextController = TextEditingController(text: "+100");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.tokenList =
        Provider.of<SnipeCommander>(context, listen: false).knownTokens;
    this.tokenToBuy = TokenUtils.getTokenFromAddress(
        tokenList: tokenList, tokenAddress: widget.tokenToBuyAddress);

    this.tokenToBuyName = (tokenToBuy == null)
        ? null
        : TokenUtils.parseTokenToBuyName(
            tokenList: tokenList,
            tokenToBuyAddress: tokenToBuy!.address,
            parseAsMultiline: false,//todo: dis is horrible
          );

    Color headerColor = TokenUtils.parseColorForToken(tokenToBuy?.address) ??
        Provider.of<AppThemeProvider>(context).currentTheme.backgroundColor;

    Color chipTextColor = Provider.of<AppThemeProvider>(context).currentTheme.regularTextColor;
    Color chipBGColor = Provider.of<AppThemeProvider>(context).currentTheme.backgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 12.0,
            right: 12.0,
          ),
          color: headerColor,
          height: 110.0,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: RichText(
                      text: TextSpan(
                          text: tokenToBuyName ?? "",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.blackOrWhiteForBackground(
                                  headerColor)),
                          children: [
                            TextSpan(
                              text: " Token",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                //color: Provider.of<AppThemeProvider>(context).currentTheme.regularTextColor
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(
                      Icons.close,
                      color: Provider.of<AppThemeProvider>(context)
                          .currentTheme
                          .invert
                          .neumorphicBackgroundColor,
                    ),
                    onTap: () {
                      this.widget.onCloseButtonPressed.call();
                    },
                  )
                ],
              ),
              if (TokenUtils.verifyAddressLength(tokenToBuyTextController.text))
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        if (widget.snipeFormData is Liquidity)
                          Chip(
                            label: Text(
                              DateTimeUtils.parseDate((widget.snipeFormData as Liquidity).dateCreated!),
                              style: TextStyle(
                                  color: chipTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: chipBGColor,
                          ),
                        if (widget.snipeFormData is Liquidity)
                          Container(width: 8.0),
                        ActionChip(
                          avatar: Image.asset("assets/poocoin.png"),
                          label: Text(
                            "Poocoin",
                            style: TextStyle(
                                color: chipTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: chipBGColor,
                          onPressed: () =>
                              TokenUtils.openPooCoinPage(
                                tokenAddress: tokenToBuy!.address,
                                toolbarColor: headerColor,
                                navColor: headerColor,
                              ),
                        ),
                        Container(width: 8.0),
                        ActionChip(
                          avatar: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Image.asset("assets/bscscan.png"),
                          ),
                          label: Text(
                            "BSC Scan",
                            style: TextStyle(
                                color: chipTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: chipBGColor,
                          onPressed: () =>
                              TokenUtils.openBscScanPage(
                                tokenAddress: tokenToBuy!.address,
                                toolbarColor: headerColor,
                                navColor: headerColor,
                              ),
                        ),
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
        Divider(
          height: 0.0,
          color: Provider.of<AppThemeProvider>(context)
              .currentTheme
              .invert
              .neumorphicBackgroundColor,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 12.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "SWAP PARAMS",
                            style: TextStyle(
                              color: Provider.of<AppThemeProvider>(context)
                                  .currentTheme
                                  .regularTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        Text("Buy", textAlign: TextAlign.right),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: tokenToBuyTextController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                labelText: (tokenToBuy == null)
                                    ? "Token to buy"
                                    : tokenToBuyName,
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text("With", textAlign: TextAlign.right),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormField<Token>(
                            enabled: widget.snipeFormData != null,
                            builder: (FormFieldState<Token> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal),
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16.0),
                                    hintText:
                                        "${SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1.name} or ${SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2.name}",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                isEmpty: tokenToSpend == null,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Token>(
                                    value: tokenToSpend,
                                    isDense: true,
                                    onChanged: (Token? newValue) {
                                      setState(() {
                                        tokenToSpend = (newValue ?? null)!;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: spendingCurrencyType
                                        .map((Token token) {
                                      return DropdownMenuItem<Token>(
                                        value: token,
                                        child: Text(
                                          token.name!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text("Spending\n(${tokenToSpend.symbol})", textAlign: TextAlign.right),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: spendAmountTextController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                hintText: "Min: 0.1 WBNB or 35 BUSD",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text("Max\nslippage", textAlign: TextAlign.right),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: slippageTextController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: "Buying",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                hintText:
                                    "",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text("And gas\n(GWEI)", textAlign: TextAlign.right),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: gasTextController,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: "Buying",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                hintText:
                                    "15",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Divider(
                    color: Provider.of<AppThemeProvider>(context)
                        .currentTheme
                        .invert
                        .neumorphicBackgroundColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "INVESTMENT STRATEGY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.settings),
                      ],
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        Text("Buy\nTrigger", textAlign: TextAlign.right,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: TextEditingController(
                              text: "0.1",
                            ),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: "When price <=",
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              hintText: "X BNB",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text("Sell\nTrigger", textAlign: TextAlign.right,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: TextEditingController(
                              text: "+100%",
                            ),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: "When ROI >=",
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              hintText: "X%",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 0.0,
          color: headerColor,
        ),
        Container(
          padding: const EdgeInsets.only(top: 4.0, bottom: 10.0, right: 16.0),
          color: headerColor.withAlpha(125),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Showcase(
                key: ShowCaseUtils().getGlobalKey(ShowCaseElement
                    .ADD_ARTICLE_CONFIRMATION_BUTTON),
                title: ShowCaseElement
                    .ADD_ARTICLE_CONFIRMATION_BUTTON.title,
                description: ShowCaseElement
                    .ADD_ARTICLE_CONFIRMATION_BUTTON.subtitle,
                showArrow: true,
                contentPadding: EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  width: 100.0,
                  child: Stack(
                    children: <Widget>[
                      NeumorphicButton(
                        onPressed: () {},
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(6.0)),
                          color: headerColor,
                          depth: 1,
                          //oppositeShadowLightSource: true,
                        ),
                        child: Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                  color: ColorUtils
                                      .blackOrWhiteForBackground(headerColor),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppDatabase().snipeDao.insertSnipeModel(Snipe(
                            id: 0,
                            tokenToBuyId: tokenToBuyTextController.text,
                            tokenToSpendId: tokenToSpend.address,
                            amountToSpend: double.parse(spendAmountTextController.text),
                            gas: double.parse(gasTextController.text),
                            slippage: double.parse(slippageTextController.text),
                            snipeStatusId: SnipeStatus.INACTIVE.index,
                            dcaBuyTargets: false,
                            dcaSellTargets: false,
                            amountReceived: 0,
                            amountSold: 0,
                            autoTransac: true,
                            amountSpent: 0.0,
                            dcaBuyTrigger: 0,
                            dcaSellTrigger: 0,
                            datesBought: "",
                            datesSold: "",
                          ));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:snipe_commander/data/database/database.dart';
import 'package:snipe_commander/data/providers/app_theme_provider.dart';
import 'package:snipe_commander/data/providers/decentralized_swap_event_provider.dart';
import 'package:snipe_commander/data/providers/snipe_battlefield_info_provider.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:snipe_commander/view_controller/decoration/theme.dart';

typedef OnLiquidityClick(Liquidity liquidity, Token tokenToBuy);

class LiquidityList extends StatefulWidget {
  late final OnLiquidityClick onLiquidityClick;

  LiquidityList({required this.onLiquidityClick});

  @override
  _LiquidityListState createState() => _LiquidityListState();
}

class _LiquidityListState extends State<LiquidityList> {
  int selectedLiquidity = -1;

  late SnipeCommander snipeCommander;
  late List<Token> tokenList;

  @override
  Widget build(BuildContext context) {
    this.snipeCommander = Provider.of<SnipeCommander>(context);
    this.tokenList = this.snipeCommander.knownTokens;

    //DeployedContract new token = Erc20(address: address, client: client)

    return StreamBuilder<List<Liquidity>>(
        stream: AppDatabase().snipeDao.watchAllDetectedLiquidities(),
        builder: (context, snapshot) {
          List<Liquidity> liquidityList = snapshot.data ?? [];
          return SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return Provider.of<AppThemeProvider>(context)
                    .currentTheme
                    .invert
                    .neumorphicBackgroundColor;
              }),
              showCheckboxColumn: false,
              headingTextStyle: TextStyle(
                color: Provider.of<AppThemeProvider>(context)
                    .currentTheme
                    .invert
                    .regularTextColor,
                fontWeight: FontWeight.bold,
              ),
              showBottomBorder: true,
              columns: [
                DataColumn(label: Text("Spend")),
                DataColumn(label: Text("To Buy")),
                //DataColumn(label: Text("Pair detected on")),
                DataColumn(label: Text("Exchange")),
              ],
              rows: [
                for (Liquidity liquidity in liquidityList)
                  DataRow(
                      selected: this.selectedLiquidity ==
                          liquidityList.indexOf(liquidity),
                      onSelectChanged: (isSelected) {
                        setState(() {
                          if (isSelected == true) {
                            this.selectedLiquidity =
                                liquidityList.indexOf(liquidity);
                            Function.apply(this.widget.onLiquidityClick, [
                              liquidity,
                              TokenUtils.getTokenFromAddress(
                                  tokenList: this.tokenList,
                                  tokenAddress: liquidity.tokenToBuyAddress)
                            ]);
                          } else {
                            this.selectedLiquidity = -1;
                          }
                        });
                      },
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected))
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        // Even rows will have a grey color.
                        if (liquidityList.indexOf(liquidity).isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: [
                        DataCell(Text(
                            TokenUtils.decodeTokenToSpend(liquidity.tokenToSpendAddress)?.name ?? "°_°"),),
                        DataCell(Text(
                            "${TokenUtils.parseTokenToBuyName(tokenList: this.tokenList, tokenToBuyAddress: liquidity.tokenToBuyAddress, parseAsMultiline: true)}",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: TokenUtils.parseColorForToken(liquidity.tokenToBuyAddress),
                              fontWeight: FontWeight.bold,
                            ))),
                        //DataCell(Text("${Jiffy(liquidity.dateCreated).format("dd MMMM yyy\nhh:mm a")}")),
                        DataCell(
                          Center(
                            child: Neumorphic(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 0.0),
                              style: NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.rect(),
                                  depth: 0),
                              child: Image.asset('assets/pcs.png'),
                            ),
                          ),
                        ),
                      ]),
              ],
            ),
          );
        });
  }
}

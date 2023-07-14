import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:snipe_commander/data/blockchain/decentralized_swaps.dart';
import 'package:snipe_commander/data/database/database.dart';
import 'package:snipe_commander/data/providers/snipe_battlefield_info_provider.dart';
import 'package:snipe_commander/utils/utils.dart';
import 'package:web3dart/web3dart.dart';

import '../../app/app.dart';

class SnipeCommander extends ChangeNotifier {
  late Client httpClient;
  late Web3Client web3Client;
  late DeployedContract decentralizedSwapContract;
  List<Liquidity> detectedLiquidities = [];
  List<Token> knownTokens = [];

  SnipeCommander() {

    AppDatabase().snipeDao.watchAllTokens().listen((tokens) {
      this.knownTokens = tokens;
      notifyListeners();
    });

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
                SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_1.address &&
            token1 !=
                SnipeBattlefieldInfoProvider.SWAP_DAPP.CURRENCY_2.address);

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
                      });
                  });
                });
          });

        });
      });
    });
  }
}

import 'package:web3dart/web3dart.dart';

class PairCreatedEvent_response {

  late final bool removed;
  late final int logIndex;
  late final int transactionIndex;
  late final String transactionHash;
  late final String blockHash;
  late final int blockNumber;
  late final EthereumAddress address;
  late final String data;
  late final List<String> topics;

  PairCreatedEvent_response(FilterEvent pairCreatedEvent) {
    this.removed = pairCreatedEvent.removed!;
    this.logIndex = pairCreatedEvent.logIndex!;
    this.transactionIndex = pairCreatedEvent.transactionIndex!;
    this.transactionHash = pairCreatedEvent.transactionHash!;
    this.blockHash = pairCreatedEvent.blockHash!;
    this.blockNumber = pairCreatedEvent.blockNum!;
    this.address = pairCreatedEvent.address!;
    this.data = pairCreatedEvent.data!;
    this.topics = pairCreatedEvent.topics!;
  }

}
class LedgerStock {
  final String lastAmount;
  final String lastDiscount;
  final String lastRate;
  final DateTime lastDate;
  final String itemName;
  final String totalAmount;
  final String totalActualQty;
  final int totalBilledQty;
  final String numVouchers;

  LedgerStock({this.itemName, this.lastAmount, this.lastDate, this.lastDiscount,
  this.lastRate, this.numVouchers, this.totalActualQty, this.totalAmount, this.totalBilledQty});

}
class VoucherItem {
  
  final String stockItemName;
  final String partyLedgerName;
  final DateTime vDate;
  final String vMasterId;
  final String rate;
  final String primaryVoucherType;
  final String discount;
  final String gstPercent;
  final int billedQty;
  final String actualQty;
  final int amount;
  final String taxAmount;




  VoucherItem({this.stockItemName, this.primaryVoucherType, this.actualQty, this.amount, this.billedQty, this.discount, 
  this.gstPercent, this.partyLedgerName, this.rate, this.vDate, this.vMasterId, this.taxAmount});

}
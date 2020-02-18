
class Voucher {

  final DateTime date;
  final String partyname;
  final int amount;
  final String masterid;
  final String iscancelled;
  final String primaryVoucherType;

  Voucher ({this.date, this.partyname, this.amount, this.masterid, this.iscancelled, this.primaryVoucherType});
}
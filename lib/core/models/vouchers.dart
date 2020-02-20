
class Voucher {

  final DateTime date;
  final String partyname;
  final int amount;
  final String masterid;
  final String iscancelled;
  final String primaryVoucherType;
  final String isInvoice;
  final String type;
  final String isPostDated;
  final String reference;


  Voucher ({this.date, this.partyname, this.amount, this.masterid, this.iscancelled, this.primaryVoucherType,
  this.isInvoice, this.isPostDated, this.reference, this.type
  });
}
class LedgerParty {

  final int amount;
  final String isDeemedPositive;
  final String isPartyLedger;
  final String ledgerGuid;
  final String ledgerMasterId;
  final String ledgerRefMasterId;
  final String primaryVoucherType;
  final String primaryGroup;
  final String ledgerName;
  final String ledgerRefName;
  final String partyName;
  final DateTime date;
  final String voucherMasterID;

  LedgerParty({this.amount, this.primaryVoucherType, this.date, this.isDeemedPositive, this.isPartyLedger,
  this.ledgerGuid, this.ledgerMasterId, this.ledgerName, this.ledgerRefMasterId, this.ledgerRefName,
  this.partyName, this.primaryGroup, this.voucherMasterID });

}
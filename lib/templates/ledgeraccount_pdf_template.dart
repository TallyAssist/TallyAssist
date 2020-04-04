import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

createLedgerPdf({
  String companyName,
  String partyName,
  String startDate,
  String endDate,
  List<List<String>> ledgerList,
  // String openingBalance,
  // String closingBalance,
  // String totalCreditWithoutClosingBalance,
  // String totalDebitWithoutClosingBalance,
  // String totalCredit,
  // String totalDebit
}) {
  final pdf = Document();
  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return Header(
            level: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(companyName, textScaleFactor: 1.5),
                SizedBox(height: 10),
                Text(partyName, textScaleFactor: 1.5),
                Text('Ledger Account', textScaleFactor: 1.10),
                SizedBox(height: 20),
                Text('$startDate to $endDate', textScaleFactor: 1.10),
              ],
            ),
          );
        }
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const BoxDecoration(
              border:
                  BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(companyName),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$partyName   Ledger Account: $startDate to $endDate'),
                  Text('Page ${context.pageNumber}'),
                ],
              ),
              Table.fromTextArray(context: context, data: [
                [
                  'Date',
                  'Particulars',
                  'Vch Type',
                  'Vch No.',
                  'Debit',
                  'Credit'
                ],
              ]),
            ],
          ),
        );
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        SizedBox(height: 30),
        // Ledger entry table
        // Table.fromTextArray(
        //   context: context,
        //   data: [
        //     ['Date', 'Particulars', 'Vch Type', 'Vch No.', 'Debit', 'Credit'],
        //   ],
        // ),
        Table.fromTextArray(
          context: context,
          data: ledgerList,
        ),
        SizedBox(height: 30),
        Padding(padding: const EdgeInsets.all(10)),
      ],
    ),
  );
  return pdf;
}
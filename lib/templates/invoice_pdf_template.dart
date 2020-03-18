import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

createSamplePdf() {
  final pdf = Document();
  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('TallyAssist',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
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
        Header(
          level: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('GST Invoice', textScaleFactor: 2),
                // PdfLogo()
              ]),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder(
                      bottom: true,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Paragraph(text: 'Dayal Industries'),
                      Paragraph(text: 'Khasra No 1561/1 & 166/2'),
                      Paragraph(text: 'Acchronda, Gogoi Road'),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder(
                      top: true,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Paragraph(text: 'Buyer'),
                      Paragraph(text: 'Venkatesh Agencies, Nadurbar'),
                      Paragraph(text: '1352/4, Gandhi Chowk Hat, Darwaja'),
                      Paragraph(text: 'Distt Nandurbar (Maharashtra)'),
                      Paragraph(text: 'GSTIN/UIN: 27AAEFV9980G1ZK'),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView(
                crossAxisCount: 2,
                childAspectRatio: 0.3,
                children: <Widget>[
                  gridChild('Invoice No.', '19/20/NK/0192'),
                  gridChild('Dated', '5-Feb-2020'),
                  gridChild('Delivery Notes', ''),
                  gridChild('Mode/Terms of Payment', ''),
                  gridChild('Suppliers Ref', ''),
                  gridChild('Other Reference(s)', ''),
                  gridChild('Buyers order no', ''),
                  gridChild('Dated', ''),
                  gridChild('Despatch Document No', ''),
                  gridChild('Delivery Note Date', ''),
                  gridChild('Despatched through', ''),
                  gridChild('Destination', ''),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Table.fromTextArray(context: context, data: const <List<String>>[
          [
            'SI No.',
            'Description of Goods',
            'HSN/SAC',
            'Quantity',
            'Rate',
            'per',
            'Disc%',
            'Amount'
          ],
          [
            '1',
            'PARAM LURE REFILL FRUIT FLY (O) (PACK)',
            '3808',
            '10 Pack (100 Pcs)',
            '180.00',
            'Pack',
            '',
            '1,800.00'
          ],
          ['', 'CGST- MH (27)', '', '', '', '', '', '162.00'],
          ['', 'Total', '', '10 Pack', '', '', '', 'Rs. 2,124.00']
        ]),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Company PAN:'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder(
                    top: true,
                    left: true,
                    right: true,
                    bottom: true,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('For Dayal Crop Care Pvt Ltd'),
                    SizedBox(height: 25),
                    Text('Authorised Signatory'),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(10)),
      ],
    ),
  );
  return pdf;
}

gridChild(String text1, String text2) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: BoxBorder(
        left: true,
        right: true,
        top: true,
        bottom: true,
      ),
    ),
    child: Column(
      children: <Widget>[
        Text(text1),
        Text(text2),
      ],
    ),
  );
}

import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

createInvoicePdf({
  String companyName,
  String companyAddress,
  String companyPincode,
  // Need to add Company GST, signature, terms and conditions, payment link..
  // String companyPan,
  String partyName,
  String partyAddress,
  String partyPincode,
  String partyState,
  String partyGST,
  String invoiceNumber,
  String invoiceDate,
  List<List<String>> itemList,
  String logoPath,
}) {
  final pdf = Document();
  final logoImage = PdfImage(
    pdf.document,
    image: File(logoPath).readAsBytesSync(),
    width: 40,
    height: 40,
  );

  // final logoImage = PdfImage(
  //   pdf.document,
  //   image: File(logoPath).readAsBytesSync(),
  //   width: 49,
  //   height: 49,
  // );

  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.topLeft,
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
          margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Generated using TallyAssist',
                    style: TextStyle(
                        color: PdfColors.purple400, font: Font.timesItalic())),
                Text('Page ${context.pageNumber} of ${context.pagesCount}',
                    style: Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.grey))
              ]),
        );
      },
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: Container(
            decoration: BoxDecoration(
              border: BoxBorder(
                bottom: true,
                top: true,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(companyName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(companyAddress),
                      Text(companyPincode),
                      Text('GSTIN: ABCD123456SDS')
                    ],
                  ),
                  Center(
                    child: Image(logoImage),
                  ), // C,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('GST Invoice',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text('Invoice No.: $invoiceNumber'),
                      Text('Invoice Date: $invoiceDate'),
                      Text('Place of supply:'),
                    ],
                  ), // Need this to be

                  // PdfLogo()
                ]),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Customer Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(partyName),
                      Text(partyAddress),
                      Text(partyPincode),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Customer GSTIN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(partyGST),
                    Text('State: $partyState',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Due Date:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )) //TODO need to add due date from invoice
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 470,
              child: GridView(
                crossAxisCount: 4,
                childAspectRatio: 0.3,
                children: <Widget>[
                  // Need to add fields here from the invoice
                  gridChild('Delivery Notes', ''),
                  gridChild('Mode/Terms of Payment', ''),
                  // gridChild('Suppliers Ref', ''),
                  // gridChild('Other Reference(s)', ''),
                  gridChild('Buyers order no', ''),
                  gridChild('Dated', ''),
                  gridChild('Despatch Doc No', ''),
                  gridChild('Delivery Note Date', ''),
                  gridChild('Despatched through', ''),
                  gridChild('Destination', ''),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Table.fromTextArray(context: context, data: itemList),
        // const <List<String>>[
        //   [
        //     'SI No.',
        //     'Description of Goods',
        //     'HSN/SAC',
        //     'Quantity',
        //     'Rate',
        //     'per',
        //     'Disc%',
        //     'Amount'
        //   ],
        //   [
        //     '1',
        //     'PARAM LURE REFILL FRUIT FLY (O) (PACK)',
        //     '3808',
        //     '10 Pack (100 Pcs)',
        //     '180.00',
        //     'Pack',
        //     '',
        //     '1,800.00'
        //   ],
        //   ['', 'CGST- MH (27)', '', '', '', '', '', '162.00'],
        //   ['', 'Total', '', '10 Pack', '', '', '', 'Rs. 2,124.00']
        // ]),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Company PAN:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )), // TODO need to add
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
                      color: PdfColors.grey400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('For $companyName'),
                    SizedBox(height: 25),
                    Text('Authorised Signatory'),
                  ],
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: 20),

        Padding(padding: const EdgeInsets.all(10)),
      ],
    ),
  );
  return pdf;
}

gridChild(String text1, String text2) {
  return Container(
    padding: const EdgeInsets.only(left: 2.0 * PdfPageFormat.mm),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      border: BoxBorder(
          left: true,
          right: true,
          top: true,
          bottom: true,
          color: PdfColors.grey400),
    ),
    child: Column(
      children: <Widget>[
        Text(text1),
        Text(text2),
      ],
    ),
  );
}

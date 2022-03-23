import 'dart:io';
import 'dart:typed_data';

import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFUtils {
  static Future<File> generateReceipt(List<CartProduct>? _productList, double total, double discount, String paymentMethod) async {
    final pw.Document pdf = pw.Document();
    final String month = DateFormat.M().format(DateTime.now());
    final String d = DateFormat.d().format(DateTime.now());
    final String y = DateFormat.y().format(DateTime.now());
    final String h = DateFormat.H().format(DateTime.now());
    final String m = DateFormat.m().format(DateTime.now());
    final String s = DateFormat.s().format(DateTime.now());

    final String receiptName = 'receipt-$d-$month-$y-$h-$m-$s';
    pw.Font fallbackFont = await PdfGoogleFonts.robotoBlack();
    pw.Font mainFont = await PdfGoogleFonts.exo2Medium();

    pdf.addPage(
      pw.MultiPage(
        footer: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Divider(),
              pw.Text('Thank you for your purchase', style: pw.TextStyle(fontSize: 18, font: mainFont)),
              pw.Text('Basta Git`Tea, yummy!', style: pw.TextStyle(fontSize: 18, font: mainFont)),
            ],
          );
        },
        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Git`Tees Lapaz', style: pw.TextStyle(fontSize: 24, font: mainFont)),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.cm, width: 0),
                    pw.Text(
                      '02-024 Jocson Drive, Jereos Street',
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      'Lapaz, Iloilo City, Iloilo, 5000',
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      '09494943017',
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.cm, width: 0),
                    pw.Text(
                      'Receipt Number ${(DateTime.now().millisecondsSinceEpoch / 100000).truncate()}',
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      Utils.dateTimeToString(DateTime.now()),
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      'Payment method: $paymentMethod',
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 130,
                  width: 130,
                  child: pw.BarcodeWidget(data: 'https://github.com/angelocordero/git_tees_shop', barcode: pw.Barcode.qrCode()),
                )
              ],
            ),
            pw.SizedBox(height: 2 * PdfPageFormat.cm, width: 0),
            pw.Text('Receipt', style: pw.TextStyle(fontSize: 20, font: mainFont)),
            pw.SizedBox(height: 1 * PdfPageFormat.cm, width: 0),
            pw.Table.fromTextArray(
              cellHeight: 20,
              cellStyle: pw.TextStyle(fontFallback: [fallbackFont]),
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.lightBlue),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
              },
              headers: [
                'Description',
                'Quantity',
                'Unit Price',
                'Amount',
              ],
              data: _productList?.map(
                    (_cartProduct) {
                      return [
                        '${_cartProduct.tshirts.productName} - ${_cartProduct.tshirts.color} - ${_cartProduct.tshirts.size}',
                        _cartProduct.cartQuantity.toString(),
                        Utils.formatToPHPString(_cartProduct.tshirts.price * .88),
                        Utils.formatToPHPString(_cartProduct.tshirts.price * .88 * _cartProduct.cartQuantity),
                      ];
                    },
                  ).toList() ??
                  [],
            ),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 5),
                  pw.Expanded(
                    flex: 5,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Subtotal:',
                              style: pw.TextStyle(fontSize: 14, fontFallback: [fallbackFont]),
                            ),
                            pw.Spacer(),
                            pw.Text(
                              Utils.formatToPHPString(total * .88),
                              style: pw.TextStyle(fontFallback: [fallbackFont]),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Value Added Tax (12%):',
                              style: pw.TextStyle(fontFallback: [fallbackFont]),
                            ),
                            pw.Spacer(),
                            pw.Text(
                              Utils.formatToPHPString(total * .12),
                              style: pw.TextStyle(fontFallback: [fallbackFont]),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Git`Tee Voucher Discount:',
                              style: pw.TextStyle(fontFallback: [fallbackFont]),
                            ),
                            pw.Spacer(),
                            pw.Text(
                              '-${Utils.formatToPHPString(discount)}',
                              style: pw.TextStyle(fontFallback: [fallbackFont]),
                            ),
                          ],
                        ),
                        pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Total:',
                              style: pw.TextStyle(fontFallback: [fallbackFont], fontSize: 16),
                            ),
                            pw.Spacer(),
                            pw.Text(
                              Utils.formatToPHPString(total - discount),
                              style: pw.TextStyle(fontFallback: [fallbackFont], fontSize: 16),
                            ),
                          ],
                        ),
                        pw.Divider(height: 5),
                        pw.Divider(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ];
        },
      ),
    );

    final Uint8List bytes = await pdf.save();
    final Directory dir = await getTemporaryDirectory();
    final File file = File('${dir.path}/$receiptName');

    return await file.writeAsBytes(bytes);
  }

  static Future openReceipt(File file) async {
    await OpenFile.open(file.path, type: 'application/pdf');
  }
}

// Copyright (c) 2026 Bengin Sternas.
//
// Project: Belegium
// This project is licensed under the Apache License 2.0.
// See the LICENSE file in the root directory for details.

import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/kassenanordnung_model.dart';

class PdfGenerator {
  static Future<void> generateAndSave(
      List<KassenanordnungModel> models, String directoryPath) async {
    for (var model in models) {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                pw.SizedBox(height: 20),
                _buildTopInfo(model),
                pw.SizedBox(height: 20),
                _buildSectionTitle('- F i n a n z r e f e r a t -'),
                pw.SizedBox(height: 10),
                _buildFinanzreferat(model),
                pw.SizedBox(height: 20),
                _buildSectionTitle('- B u c h f ü h r u n g -'),
                pw.SizedBox(height: 10),
                _buildBuchfuehrung(),
                pw.SizedBox(height: 20),
                _buildSectionTitle('- K a s s e n v e r w a l t u n g -'),
                pw.SizedBox(height: 10),
                _buildKassenverwaltung(model),
              ],
            );
          },
        ),
      );

      final fileName =
          'Kassenanordnung_${model.name}_${model.vorname}.pdf'.replaceAll(' ', '_');
      final file = File('$directoryPath/$fileName');
      await file.writeAsBytes(await pdf.save());
    }
  }

  static pw.Widget _buildHeader() {
    return pw.Center(
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 1.5, color: PdfColors.black),
          color: PdfColors.grey300,
        ),
        padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 80),
        child: pw.Text(
          'Kassenanordnung',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
      ),
    );
  }

  static pw.Widget _buildTopInfo(KassenanordnungModel model) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 60),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Container(
                    width: 12,
                    height: 12,
                    decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text('Einnahme', style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
              pw.SizedBox(height: 6),
              pw.Row(
                children: [
                  pw.Container(
                    width: 12,
                    height: 12,
                    decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                    child: pw.Center(
                      child: pw.Text(
                        'x',
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Text('Ausgabe', style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(right: 40),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.SizedBox(width: 80, child: pw.Text('Haushaltsjahr', style: const pw.TextStyle(fontSize: 10))),
                  _buildLineText(model.haushaltsjahr, width: 120, center: true, bold: true),
                ],
              ),
              pw.SizedBox(height: 6),
              pw.Row(
                children: [
                  pw.SizedBox(width: 80, child: pw.Text('Titel-Nr.', style: const pw.TextStyle(fontSize: 10))),
                  _buildLineText(model.titelNr, width: 120, center: true, bold: true),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSectionTitle(String title) {
    return pw.Container(
      width: double.infinity,
      color: PdfColors.grey300,
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Text(
        title,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, letterSpacing: 2),
      ),
    );
  }

  static pw.Widget _buildFinanzreferat(KassenanordnungModel model) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Annahme / Auszahlung von', style: const pw.TextStyle(fontSize: 10)),
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
              padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 200,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(model.betrag, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Euro', style: const pw.TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Text('(in Worten:', style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(width: 8),
            _buildLineText(model.betragInWorten, width: 380, bold: true),
            pw.Text(')', style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: 120, child: pw.Text('Einzahler / Empfänger:', style: const pw.TextStyle(fontSize: 10))),
            pw.Expanded(
              child: pw.Column(
                children: [
                  _buildLineText('${model.name} ${model.vorname}'.trim(), width: double.infinity, bold: true),
                  pw.SizedBox(height: 20, child: pw.Divider(color: PdfColors.black)),
                  pw.SizedBox(height: 20, child: pw.Divider(color: PdfColors.black)),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.SizedBox(width: 120, child: pw.Text('bei Auszahlung:', style: const pw.TextStyle(fontSize: 10))),
            pw.Text('Kreditinstitut', style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(width: 10),
            pw.Expanded(child: _buildLineText('', width: double.infinity)),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Text('IBAN:', style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(width: 10),
            _buildLineText(model.iban, width: 280, bold: true),
            pw.SizedBox(width: 10),
            pw.Text('BIC:', style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(width: 10),
            pw.Expanded(child: _buildLineText('', width: double.infinity)),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: 80, child: pw.Text('Begründung:', style: const pw.TextStyle(fontSize: 10))),
            pw.Expanded(
              child: pw.Column(
                children: [
                  _buildLineText(model.begruendung, width: double.infinity, bold: true),
                  pw.SizedBox(height: 20, child: pw.Divider(color: PdfColors.black)),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          children: [
            pw.SizedBox(width: 120, child: pw.Text('Anlage/n:', style: const pw.TextStyle(fontSize: 10))),
            pw.Container(width: 10, height: 10, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
            pw.SizedBox(width: 5),
            pw.SizedBox(width: 80, child: pw.Text('Rechnung', style: const pw.TextStyle(fontSize: 10))),
            pw.Container(width: 10, height: 10, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
            pw.SizedBox(width: 5),
            pw.SizedBox(width: 120, child: pw.Text('Überweisungsbeleg', style: const pw.TextStyle(fontSize: 10))),
            pw.Container(width: 10, height: 10, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
            pw.SizedBox(width: 5),
            pw.Text('Quittung', style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Ort / Datum', style: const pw.TextStyle(fontSize: 9)),
                    pw.SizedBox(width: 10),
                    _buildLineText(model.ortDatum, width: 120, bold: true, center: true),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text('Rechnerisch richtig:', style: const pw.TextStyle(fontSize: 9)),
                pw.SizedBox(height: 20),
                pw.Container(width: 180, decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 0.5)))),
                pw.SizedBox(height: 2),
                pw.Container(width: 180, alignment: pw.Alignment.center, child: pw.Text('(AStA-Mitglied)', style: const pw.TextStyle(fontSize: 7))),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Ort / Datum', style: const pw.TextStyle(fontSize: 9)),
                    pw.SizedBox(width: 10),
                    _buildLineText('', width: 120),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text('Sachlich richtig und angeordnet:', style: const pw.TextStyle(fontSize: 9)),
                pw.SizedBox(height: 20),
                pw.Container(width: 180, decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 0.5)))),
                pw.SizedBox(height: 2),
                pw.Container(width: 180, alignment: pw.Alignment.center, child: pw.Text('(Finanzreferent/in)', style: const pw.TextStyle(fontSize: 7))),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildBuchfuehrung() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.SizedBox(width: 120, child: pw.Text('Gebucht bei Titel', style: const pw.TextStyle(fontSize: 10))),
            _buildLineText('', width: 150),
            pw.SizedBox(width: 20),
            pw.Text('am', style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(width: 10),
            _buildLineText('', width: 150),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.SizedBox(width: 120, child: pw.Text('Gebucht nach Zeitfolge', style: const pw.TextStyle(fontSize: 10))),
            _buildLineText('', width: 150),
            pw.SizedBox(width: 20),
            pw.Text('am', style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(width: 10),
            _buildLineText('', width: 150),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: 80, child: pw.Text('Bemerkungen:', style: const pw.TextStyle(fontSize: 10))),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.SizedBox(height: 15, child: pw.Divider(color: PdfColors.black, thickness: 0.5)),
                  pw.SizedBox(height: 20, child: pw.Divider(color: PdfColors.black, thickness: 0.5)),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          children: [
            pw.Text('Ort / Datum', style: const pw.TextStyle(fontSize: 9)),
            pw.SizedBox(width: 10),
            _buildLineText('', width: 150),
            pw.Spacer(),
            pw.Column(
              children: [
                pw.Container(width: 200, decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 0.5)))),
                pw.SizedBox(height: 2),
                pw.Text('(Buchhalter/in)', style: const pw.TextStyle(fontSize: 7)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildKassenverwaltung(KassenanordnungModel model) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.SizedBox(width: 200, child: pw.Text('Einzahlung angenommen / Auszahlung veranlasst', style: const pw.TextStyle(fontSize: 9))),
            pw.Text('am', style: const pw.TextStyle(fontSize: 9)),
            pw.SizedBox(width: 5),
            _buildLineText('', width: 100),
            pw.SizedBox(width: 10),
            pw.Text('über', style: const pw.TextStyle(fontSize: 9)),
            pw.SizedBox(width: 5),
            _buildLineText(model.auszugNr, width: 120, bold: true, center: true),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Container(width: 10, height: 10, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
                    pw.SizedBox(width: 5),
                    pw.SizedBox(width: 100, child: pw.Text('IBAN.', style: const pw.TextStyle(fontSize: 9))),
                    _buildLineText('', width: 120),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Row(
                  children: [
                    pw.Container(width: 10, height: 10, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
                    pw.SizedBox(width: 5),
                    pw.SizedBox(width: 100, child: pw.Text('Sonstiges Konto Nr.', style: const pw.TextStyle(fontSize: 9))),
                    _buildLineText('', width: 120),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Row(
                  children: [
                    pw.Container(width: 10, height: 10, decoration: pw.BoxDecoration(border: pw.Border.all(width: 1))),
                    pw.SizedBox(width: 5),
                    pw.SizedBox(width: 100, child: pw.Text('Barkasse', style: const pw.TextStyle(fontSize: 9))),
                    _buildLineText('', width: 120),
                  ],
                ),
              ],
            ),
            pw.SizedBox(width: 30),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.SizedBox(width: 60, child: pw.Text('Auszug-Nr.', style: const pw.TextStyle(fontSize: 9))),
                    _buildLineText('', width: 100),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Row(
                  children: [
                    pw.SizedBox(width: 60, child: pw.Text('Auszug-Nr.', style: const pw.TextStyle(fontSize: 9))),
                    _buildLineText('', width: 100),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Row(
                  children: [
                    pw.SizedBox(width: 60, child: pw.Text('Quittung-Nr.', style: const pw.TextStyle(fontSize: 9))),
                    _buildLineText('', width: 100),
                  ],
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: 80, child: pw.Text('Bemerkungen:', style: const pw.TextStyle(fontSize: 10))),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.SizedBox(height: 15, child: pw.Divider(color: PdfColors.black, thickness: 0.5)),
                  pw.SizedBox(height: 20, child: pw.Divider(color: PdfColors.black, thickness: 0.5)),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          children: [
            pw.Text('Ort / Datum', style: const pw.TextStyle(fontSize: 9)),
            pw.SizedBox(width: 10),
            _buildLineText('', width: 150),
            pw.Spacer(),
            pw.Column(
              children: [
                pw.Container(width: 200, decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 0.5)))),
                pw.SizedBox(height: 2),
                pw.Text('(Kassenverwalter/in)', style: const pw.TextStyle(fontSize: 7)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildLineText(String text,
      {required double width, bool center = false, bool bold = false}) {
    return pw.Container(
      width: width,
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
      ),
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Text(
        text,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}

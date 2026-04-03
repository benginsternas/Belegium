// Copyright (c) 2026 Bengin Sternas.
//
// Project: Belegium
// This project is licensed under the Apache License 2.0.
// See the LICENSE file in the root directory for details.

import 'dart:io';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import '../models/kassenanordnung_model.dart';

class ExcelParser {
  static Future<List<KassenanordnungModel>> parse(String filePath) async {
    final bytes = File(filePath).readAsBytesSync();
    final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    final List<KassenanordnungModel> result = [];

    for (final tableName in decoder.tables.keys) {
      final rows = decoder.tables[tableName]?.rows;
      if (rows == null || rows.isEmpty) continue;

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.isEmpty || row[0] == null || row[0].toString().trim().isEmpty) continue;

        String asString(dynamic d) {
          if (d == null) return '';
          return d.toString().trim();
        }

        result.add(KassenanordnungModel(
          name: asString(row.length > 0 ? row[0] : null),
          vorname: asString(row.length > 1 ? row[1] : null),
          iban: asString(row.length > 2 ? row[2] : null),
          begruendung: asString(row.length > 3 ? row[3] : null),
          betrag: asString(row.length > 4 ? row[4] : null),
          betragInWorten: asString(row.length > 5 ? row[5] : null),
          haushaltsjahr: asString(row.length > 6 ? row[6] : null),
          titelNr: asString(row.length > 7 ? row[7] : null),
          ortDatum: asString(row.length > 8 ? row[8] : null),
          auszugNr: asString(row.length > 9 ? row[9] : null),
        ));
      }
    }

    return result;
  }
}

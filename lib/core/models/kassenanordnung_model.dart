// Copyright (c) 2026 Bengin Sternas.
//
// Project: Belegium
// This project is licensed under the Apache License 2.0.
// See the LICENSE file in the root directory for details.

class KassenanordnungModel {
  final String name;
  final String vorname;
  final String iban;
  final String begruendung;
  final String betrag;
  final String betragInWorten;
  final String haushaltsjahr;
  final String titelNr;
  final String ortDatum;
  final String auszugNr;

  KassenanordnungModel({
    required this.name,
    required this.vorname,
    required this.iban,
    required this.begruendung,
    required this.betrag,
    required this.betragInWorten,
    required this.haushaltsjahr,
    required this.titelNr,
    required this.ortDatum,
    required this.auszugNr,
  });
}

# 📜 Belegium
**Von der Excel-Tabelle zum fertigen PDF. Automatisiert und zuverlässig.**

Belegium ist ein Tool, das den Prozess der Kassenanordnung vereinfacht. Es extrahiert Finanzdaten aus einer formatierten Excel-Liste und exportiert diese als PDF-Dateien, basierend auf dem offiziellen Formular-Layout.

## 🚀 Das Problem
Die manuelle Übertragung hunderter Abrechnungsdaten in einzelne PDF-Formulare ist fehleranfällig und erfordert großen manuellen Zeitaufwand für die Finanzverwaltung. 

## ✨ Die Lösung: Belegium
Die Anwendung automatisiert genau diesen Schnittstellenprozess:

- **Datenextraktion:** Einlesen der Tabellenwerte aus bereitgestellten `.xlsx` Dateien.
- **Formular-Erstellung:** Die eingelesenen Werte werden direkt passgenau in die vorgegebenen Kassenanordnungs-Vorlagen eingesetzt.
- **Benutzeroberfläche:** Einfache, strukturierte UI zur direkten Anwendung.
- **Stapelverarbeitung:** Mehrere Kassenanordnungen können zeitgleich aus einer einzigen Excel-Liste als separate Dokumente generiert werden.

## 🛠️ Tech Stack
- **Framework:** Dart / Flutter (Natives Cross-Platform Desktop-App-Format für macOS, Windows & Linux)
- **Excel-Verarbeitung:** `spreadsheet_decoder` Package
- **PDF-Generierung:** `pdf` Package 
- **Design:** Material 3

## 📖 Anwendung
1. Excel-Datei (`.xlsx`) mit den entsprechenden Abrechnungsdaten vorbereiten.
2. **Belegium** starten und die Datei via Drag & Drop oder über die Dateiauswahl in die App laden.
3. Speicherort für die konvertierten PDF-Formulare festlegen.
4. Fertige Kassenanordnungs-PDFs aus dem Ordner abrufen.

## 🏛️ Warum Belegium?

Die korrekte Handhabung von buchhalterischen Papieren erfordert eine strikte Form. Das Tool stellt sicher, dass die übertragenen Daten immer in dem Format vorliegen, welches für amtliche oder interne Nachweise erforderlich ist.

---
**Entwickelt von Bengin Sternas** | [benginsternas.com](https://benginsternas.com)  
*Copyright © 2026 Bengin Sternas. All rights reserved.*
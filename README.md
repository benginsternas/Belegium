# 📜 Belegium
**Von der Excel-Tabelle zur fertigen Kassenanordnung. Automatisiert und rechtssicher.**

Belegium ist ein Tool, das den Prozess der Kassenanordnung vereinfacht. Es extrahiert Finanzdaten aus einer formatierten Excel-Liste und exportiert diese als PDF-Dateien, basierend auf dem offiziellen Formular-Layout. 
Der Name setzt sich zusammen aus Beleg und Gremium und beschreibt genau, wofür die App steht

Die Anwendung entstand aus dem Bedarf der studentischen Gremien der Technischen Hochschule Köln. Als Open-Source-Projekt unter der Apache-2.0-Lizenz steht sie jedoch allen offen: Jeder darf Belegium kostenfrei nutzen, den Quellcode einsehen, weitergeben und nach eigenen Bedürfnissen anpassen.

## 🚀 Das Problem
Kassenanordnungen wurden bisher manuell erstellt: Abrechnungsdaten aus einer Excel-Datei wurden einzeln und händisch in die vorgesehenen Formulare übertragen. Ein zeitaufwändiger und fehleranfälliger Prozess.

## ✨ Die Lösung: Belegium
Belegium automatisiert genau diesen Prozess. Aus einer einzigen Excel-Datei werden automatisch mehrere Kassenanordnungen gleichzeitig generiert, vollständig, rechtssicher und ohne manuellen Aufwand.

- **Datenextraktion:** Einlesen der Abrechnungsdaten aus bereitgestellten .xlsx Dateien.
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

Belegium wurde entwickelt, um die Finanzprozesse studentischer Gremien zu entlasten. Die korrekte Handhabung buchhalterischer Dokumente erfordert eine strikte Form. Belegium stellt sicher, dass jede erzeugte Kassenanordnung diesen Anforderungen entspricht.

---
**Entwickelt von Bengin Sternas** | [benginsternas.com](https://benginsternas.com)  
*Copyright © 2026 Bengin Sternas. Licensed under the [Apache License 2.0](LICENSE).*

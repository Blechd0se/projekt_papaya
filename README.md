Dozentenverwaltungssystem
=========================

Generelle "Spielregeln" für unser Projekt. 
Dateien werden immer im jeweiligen Unterordner abgelegt.
Sie werden eingecheckt, sobald ein logischer Schritt abgeschlossen
ist. Eine Aufteilung in kleinere Commits (1/3, 2/3, 3/3) darf auch
erfolgen.


Styleguide (Programmierung)
===========================

DB
--

* Namen innerhalb der DB sind in Deutsch zu wählen (Ausnahme bilden sinnhafte Synonyme) 
* Namen sind klein zu schreiben (ro_rolle)
* Tabellennamen und Spalten besitzten einen Präfiz bestehend aus den Anfangskürzeln der Tabelle
* Schlüsselwörter werden groß geschrieben, alles andere klein (SELECT, FROM, etc...)
* Die Einrückung beträgt exact 4 Zeichen (Leerzeichen)
* Parameter bekommen einen Präfix; i für IN, o für OUT, io für INOUT
* Variablen bekommen den Präfix "v"
* Globale Variablen den Präfix "gv"
* Funktionen bestehen aus zweiteiligen deutschen Wörtern (FUNCTION hole_daten)
* SELECTs sind wie folgt zu formartieren;

	SELECT spalte_a,
	       spalte_b,
	       spalte_c
          FROM tabelle_a,
               tabelle_b
         WHERE spalte_a = spalte_b
         GROUP BY spalte_a,
                  spalte_b
         ORDER BY spalte_a,
                  spalte_b; 
* Kommentare folgen dem Schema /** Kommentar */
* Am Anfang einer jeden Datei befindet sich;

	/**
	  Datum: 10.02.2015
	  Autor: Ich
	  Thema: View-Layer-Beschreibung
	*/


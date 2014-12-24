<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Testimport</title>
<link rel="stylesheet" href="style/layout1.css" type="text/css" />
</head>

<body>

<?php
	#importklasse definieren
	class Dozent
	{
		//SubklassenAttribute
		public $kontaktdaten;
		public $bankdaten;
		public $adressdaten;
		public $firmendaten;
		
		//Einfache Attribute
		public $anrede;
		public $titel;
		public $abschluss;
		public $name;
		public $vorname;
		public $beruf;
		public $geburtsdatum;
		public $geburtsort;
		public $ehemaliger;
		public $bevStudienfach;
		public $bevVorlesungszeit = array();
		public $lehrauftrag;
		public $taetigkeiten;
		public $info; #"Weitere mögliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen";
		public $kommentar;
		public $vorlesung = array(); # Vorlesung und Sprache ist ein Array
		public $sprache = array();
		public $eingang;
		
		public function MenschAnlegen(){
			
		}
	}
	class Bank{
		public $name;
		public $BLZ;
		public $BIC;
		public $IBAN;
		public $kontonummer;
		public $LBVNr;
	}
	
	class Adresse {
		public $straßeNr;
		public $PLZ;
		public $ort;
	}
	
	class Firma {
		public $name;
		public $abteilung;
		public $firmaAdresse;
		public $kontaktdaten;
	}
	class Kontakt{
		public $telefon;
		public $mobil;
		public $email;
		public $webseite;
		public $fax;
	}
	
	/** Error reporting */
	# Welche fehler angezeigt werden Sollen.
	error_reporting(E_ALL);
	ini_set('display_errors', TRUE);
	ini_set('display_startup_errors', TRUE);
	  
	/** Include PHPExcel */
	# PHPExcel Modul Laden
	
	require_once dirname(__FILE__) . '/Classes/PHPExcel.php';

	# prüft ob das Exceldokument vorhanden ist.
	if (file_exists("Testdaten_2014.xlsx")) {

		#Das Exceldokument öffnen und in ein PHPExcel-Objekt laden
		$objPHPExcel = PHPExcel_IOFactory::load("Testdaten_2014.xlsx");
	
		#Erstes Tabellenblatt wählen
		$objPHPExcel->setActiveSheetIndex(0);
		
		#Excelblatt Zeile für Zeile durchlaufen
		#getRowIterator() gibt dabei immer die aktuelle Zeile aus, 
		#die dann Spalte für Spalte durchgearbeitet werden kann
		foreach ($objPHPExcel->getActiveSheet()->getRowIterator() as $row) {
			#neues Dozent-Objekt erzeugen
			$dozent = new Dozent();
			
			#prüfen ob die Zeile möglicherweise ausgeblendet sit (Ist aber nciht wichtig!)
			if ($objPHPExcel->getActiveSheet()->getRowDimension($row->getRowIndex())->getVisible()) {
				
				# Mit dem Folgenden Befehl wird auf die Spalte A der aktuellen Zeile zugegriffen
				# $objPHPExcel->getActiveSheet()->getCell('A'.$row->getRowIndex())->getValue()
				# Hier beispielsweise:
				# Gehen in die Zelle A1 und lies dort den Wert aus
				
				# Wenn der Wert ausgelesen wird wird dieser in das Entsprechende Attribut von Dozent eingetragen
				# $dozent->anrede = 'Ermittelter Wert'
								
				$dozent->anrede = $objPHPExcel->getActiveSheet()->getCell('A'.$row->getRowIndex())->getValue();
				$dozent->titel = $objPHPExcel->getActiveSheet()->getCell('B'.$row->getRowIndex())->getValue();
				$dozent->abschluss = $objPHPExcel->getActiveSheet()->getCell('C'.$row->getRowIndex())->getValue();
				$dozent->name = $objPHPExcel->getActiveSheet()->getCell('D'.$row->getRowIndex())->getValue();
				$dozent->vorname = $objPHPExcel->getActiveSheet()->getCell('E'.$row->getRowIndex())->getValue();
				$dozent->straßeNr = $objPHPExcel->getActiveSheet()->getCell('F'.$row->getRowIndex())->getValue();
				$dozent->PLZ = $objPHPExcel->getActiveSheet()->getCell('G'.$row->getRowIndex())->getValue();
				$dozent->ort = $objPHPExcel->getActiveSheet()->getCell('H'.$row->getRowIndex())->getValue();
				$dozent->beruf = $objPHPExcel->getActiveSheet()->getCell('I'.$row->getRowIndex())->getValue();
				$dozent->telefon = $objPHPExcel->getActiveSheet()->getCell('J'.$row->getRowIndex())->getValue();
				$dozent->mobil = $objPHPExcel->getActiveSheet()->getCell('K'.$row->getRowIndex())->getValue();
				$dozent->email = $objPHPExcel->getActiveSheet()->getCell('L'.$row->getRowIndex())->getValue();
				$dozent->webseite = $objPHPExcel->getActiveSheet()->getCell('M'.$row->getRowIndex())->getValue();
				
				#Ein Datum muss speziell Ausgelesen werden 
				$datum = $objPHPExcel->getActiveSheet()->getCell('N'.$row->getRowIndex())->getValue();
				$dozent->geburtsdatum = date('d-m-Y', PHPExcel_Shared_Date::ExcelToPHP($datum));
				
				$dozent->geburtsort = $objPHPExcel->getActiveSheet()->getCell('O'.$row->getRowIndex())->getValue();
				$dozent->bank = $objPHPExcel->getActiveSheet()->getCell('P'.$row->getRowIndex())->getValue();
				$dozent->BLZ = $objPHPExcel->getActiveSheet()->getCell('Q'.$row->getRowIndex())->getValue();
				$dozent->BIC = $objPHPExcel->getActiveSheet()->getCell('R'.$row->getRowIndex())->getValue();
				$dozent->IBAN = $objPHPExcel->getActiveSheet()->getCell('S'.$row->getRowIndex())->getValue();
				$dozent->kontonummer = $objPHPExcel->getActiveSheet()->getCell('T'.$row->getRowIndex())->getValue();
				$dozent->LBVNr = $objPHPExcel->getActiveSheet()->getCell('U'.$row->getRowIndex())->getValue();
				$dozent->firma = $objPHPExcel->getActiveSheet()->getCell('V'.$row->getRowIndex())->getValue();
				$dozent->firmaAbteilung = $objPHPExcel->getActiveSheet()->getCell('W'.$row->getRowIndex())->getValue();
				$dozent->firmaStraßeNr = $objPHPExcel->getActiveSheet()->getCell('X'.$row->getRowIndex())->getValue();
				$dozent->firmaPLZ = $objPHPExcel->getActiveSheet()->getCell('Y'.$row->getRowIndex())->getValue();
				$dozent->firmaOrt = $objPHPExcel->getActiveSheet()->getCell('Z'.$row->getRowIndex())->getValue();
				$dozent->firmaTelefon = $objPHPExcel->getActiveSheet()->getCell('AA'.$row->getRowIndex())->getValue();
				$dozent->firmaFax = $objPHPExcel->getActiveSheet()->getCell('AB'.$row->getRowIndex())->getValue();
				$dozent->firmaMobil = $objPHPExcel->getActiveSheet()->getCell('AC'.$row->getRowIndex())->getValue();
				$dozent->ehemaliger = $objPHPExcel->getActiveSheet()->getCell('AD'.$row->getRowIndex())->getValue();
				$dozent->bevStudienfach = $objPHPExcel->getActiveSheet()->getCell('AE'.$row->getRowIndex())->getValue();
				#todo splitten				
				$dozent->bevVorlesungszeit[] = preg_split('[\n]', $objPHPExcel->getActiveSheet()->getCell('AF'.$row->getRowIndex())->getValue());
				
				$dozent->lehrauftrag = $objPHPExcel->getActiveSheet()->getCell('AG'.$row->getRowIndex())->getValue();
				$dozent->taetigkeiten = $objPHPExcel->getActiveSheet()->getCell('AH'.$row->getRowIndex())->getValue();
				$dozent->info = $objPHPExcel->getActiveSheet()->getCell('AI'.$row->getRowIndex())->getValue();
				$dozent->kommentar = $objPHPExcel->getActiveSheet()->getCell('AJ'.$row->getRowIndex())->getValue();
				# todo Splitten
				# Da die Vorlesungen auf mehrere Spalten im Excel Dokument verteilt
				# sind muss hier das vorlesungs-Array mehrvach befüllt werden
				
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AK'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AL'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AM'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AN'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AO'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AP'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AQ'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AR'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AS'.$row->getRowIndex())->getValue();
				$dozent->vorlesung[] = $objPHPExcel->getActiveSheet()->getCell('AT'.$row->getRowIndex())->getValue();
				#todo splitten
				$dozent->sprache[] = $objPHPExcel->getActiveSheet()->getCell('AU'.$row->getRowIndex())->getValue();
				
				$dozent->eingang = $objPHPExcel->getActiveSheet()->getCell('AV'.$row->getRowIndex())->getValue();
				
				#Testeinträge
				# Hier werden einfach exemplarisch einige Daten angezeigt um zu schauen was drinn steht
				
				echo $dozent->anrede.' ';
				echo $dozent->geburtsdatum.' ';
				echo $datum.' ';
				echo $dozent->vorlesung[0];
				echo '<br>';
				echo '<br>';
				
				foreach ($dozent->bevVorlesungszeit as $zeiten){
					//echo $zeiten;
					foreach ($zeiten as $zeit){
						echo $zeit." | ";
					}
					//var_dump($zeit);
				}
				
				# hier Werden die Daten dann in die DB übertragen
				# toDo
			}
		}		 
	}
	else{
		exit("Noch irgendeine Nachricht.");
	}

?>
</body></html>
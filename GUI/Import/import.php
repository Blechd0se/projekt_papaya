<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Testimport</title>
<link rel="stylesheet" href="style/layout1.css" type="text/css" />
</head>

<body>

<?php
require_once dirname(__FILE__) . '/ExcelImport.php';

$import = new ExcelImport("Testdaten_2014.xlsx");

echo '<table>';
$import->showData();

echo '</table>';

$import->dozentenEintragen();
// 	require_once dirname(__FILE__) . '/Classes/PHPExcel.php';

// 	#importklasse definieren
	
	
// 	class Dozent
// 	{
// 		//SubklassenAttribute
// 		public $kontaktdaten;
// 		public $bankdaten;
// 		public $adressdaten;
// 		public $firmendaten;
		
// 		//Einfache Attribute
// 		public $anrede;
// 		public $titel;
// 		public $abschluss;
// 		public $name;
// 		public $vorname;
// 		public $beruf;
// 		public $geburtsdatum;
// 		public $geburtsort;
// 		public $ehemaliger;
// 		public $bevStudienfach;
// 		public $bevVorlesungszeit = array();
// 		public $lehrauftrag;
// 		public $taetigkeiten;
// 		public $info; #"Weitere m�gliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen";
// 		public $kommentar;
// 		public $vorlesung = array(); # Vorlesung und Sprache ist ein Array
// 		public $sprache = array();
// 		public $eingang;
		
// 		public function menschAnlegen(){
// 			try {
				
// 			} 
// 			catch (Exception $e) {
// 				throw new Exception("Daten konnten nicht �bertragen werden.");
// 			}
// 		}
		
// 	}
// 	class Bank{
// 		public $name;
// 		public $BLZ;
// 		public $BIC;
// 		public $IBAN;
// 		public $kontonummer;
// 		public $LBVNr;
// 	}
	
// 	class Adresse {
// 		public $stra�eNr;
// 		public $PLZ;
// 		public $ort;
// 	}
	
// 	class Firma {
// 		public $name;
// 		public $abteilung;
// 		public $firmaAdresse;
// 		public $kontaktdaten;
// 	}
// 	class Kontakt{
// 		public $telefon;
// 		public $mobil;
// 		public $email;
// 		public $webseite;
// 		public $fax;
// 	}
	
// 	class ExcelImport
// 	{
// 		static function excelAuslesen($ExcelPfad){
// 			/** Error reporting */
// 			# Welche fehler angezeigt werden Sollen.
// 			error_reporting(E_ALL);
// 			ini_set('display_errors', TRUE);
// 			ini_set('display_startup_errors', TRUE);
	
// 			/** Include PHPExcel */
// 			# PHPExcel Modul Laden
				
// 			# pr�ft ob das Exceldokument vorhanden ist.
// 			if (file_exists("Testdaten_2014.xlsx")) {
					
// 				#Das Exceldokument �ffnen und in ein PHPExcel-Objekt laden
// 				$objPHPExcel = PHPExcel_IOFactory::load("Testdaten_2014.xlsx");
					
// 				#Erstes Tabellenblatt w�hlen
// 				$objPHPExcel->setActiveSheetIndex(0);
					
// 				#Excelblatt Zeile f�r Zeile durchlaufen
// 				#getRowIterator() gibt dabei immer die aktuelle Zeile aus,
// 				#die dann Spalte f�r Spalte durchgearbeitet werden kann
// 				foreach ($objPHPExcel->getActiveSheet()->getRowIterator() as $row) {
// 					#neues Dozent-Objekt erzeugen
// 					$dozent = new Dozent();
						
// 					#pr�fen ob die Zeile m�glicherweise ausgeblendet sit (Ist aber nciht wichtig!)
// 					$rowNumber = $row->getRowIndex();
// 					if ($rowNumber > 1 and $objPHPExcel->getActiveSheet()->getRowDimension($row->getRowIndex())->getVisible()) {
							
// 						# Mit dem Folgenden Befehl wird auf die Spalte A der aktuellen Zeile zugegriffen
// 						# $objPHPExcel->getActiveSheet()->getCell('A'.$row->getRowIndex())->getValue()
// 						# Hier beispielsweise:
// 						# Gehen in die Zelle A1 und lies dort den Wert aus
						
// 						# Wenn der Wert ausgelesen wird wird dieser in das Entsprechende Attribut von Dozent eingetragen
// 						# $dozent->anrede = 'Ermittelter Wert'
						
// 						//$dozent->anrede = $objPHPExcel->getActiveSheet()->getCell('A'.$row->getRowIndex())->getValue();
// 						$dozent->anrede = getColumnValue('A', $row->getRowIndex());
// 						$dozent->titel = $objPHPExcel->getActiveSheet()->getCell('B'.$row->getRowIndex())->getValue();
// 						$dozent->abschluss = $objPHPExcel->getActiveSheet()->getCell('C'.$row->getRowIndex())->getValue();
// 						//$dozent->name = $objPHPExcel->getActiveSheet()->getCell('D'.$row->getRowIndex())->getValue();
// 						$dozent->name = getColumnValue('D', $row->getRowIndex());
// 						$dozent->vorname = $objPHPExcel->getActiveSheet()->getCell('E'.$row->getRowIndex())->getValue();
// 						$dozent->stra�eNr = $objPHPExcel->getActiveSheet()->getCell('F'.$row->getRowIndex())->getValue();
// 						$dozent->PLZ = $objPHPExcel->getActiveSheet()->getCell('G'.$row->getRowIndex())->getValue();
// 						$dozent->ort = $objPHPExcel->getActiveSheet()->getCell('H'.$row->getRowIndex())->getValue();
// 						$dozent->beruf = $objPHPExcel->getActiveSheet()->getCell('I'.$row->getRowIndex())->getValue();
// 						$dozent->telefon = $objPHPExcel->getActiveSheet()->getCell('J'.$row->getRowIndex())->getValue();
// 						$dozent->mobil = $objPHPExcel->getActiveSheet()->getCell('K'.$row->getRowIndex())->getValue();
// 						$dozent->email = $objPHPExcel->getActiveSheet()->getCell('L'.$row->getRowIndex())->getValue();
// 						$dozent->webseite = $objPHPExcel->getActiveSheet()->getCell('M'.$row->getRowIndex())->getValue();
							
// 						#Ein Datum muss speziell Ausgelesen werden
// 						$datum = $objPHPExcel->getActiveSheet()->getCell('N'.$row->getRowIndex())->getValue();
// 						$dozent->geburtsdatum = date('d-m-Y', PHPExcel_Shared_Date::ExcelToPHP($datum));
							
// 						$dozent->geburtsort = $objPHPExcel->getActiveSheet()->getCell('O'.$row->getRowIndex())->getValue();
// 						$dozent->bank = $objPHPExcel->getActiveSheet()->getCell('P'.$row->getRowIndex())->getValue();
// 						$dozent->BLZ = $objPHPExcel->getActiveSheet()->getCell('Q'.$row->getRowIndex())->getValue();
// 						$dozent->BIC = $objPHPExcel->getActiveSheet()->getCell('R'.$row->getRowIndex())->getValue();
// 						$dozent->IBAN = $objPHPExcel->getActiveSheet()->getCell('S'.$row->getRowIndex())->getValue();
// 						$dozent->kontonummer = $objPHPExcel->getActiveSheet()->getCell('T'.$row->getRowIndex())->getValue();
// 						$dozent->LBVNr = $objPHPExcel->getActiveSheet()->getCell('U'.$row->getRowIndex())->getValue();
// 						$dozent->firma = $objPHPExcel->getActiveSheet()->getCell('V'.$row->getRowIndex())->getValue();
// 						$dozent->firmaAbteilung = $objPHPExcel->getActiveSheet()->getCell('W'.$row->getRowIndex())->getValue();
// 						$dozent->firmaStra�eNr = $objPHPExcel->getActiveSheet()->getCell('X'.$row->getRowIndex())->getValue();
// 						$dozent->firmaPLZ = $objPHPExcel->getActiveSheet()->getCell('Y'.$row->getRowIndex())->getValue();
// 						$dozent->firmaOrt = $objPHPExcel->getActiveSheet()->getCell('Z'.$row->getRowIndex())->getValue();
// 						$dozent->firmaTelefon = $objPHPExcel->getActiveSheet()->getCell('AA'.$row->getRowIndex())->getValue();
// 						$dozent->firmaFax = $objPHPExcel->getActiveSheet()->getCell('AB'.$row->getRowIndex())->getValue();
// 						$dozent->firmaMobil = $objPHPExcel->getActiveSheet()->getCell('AC'.$row->getRowIndex())->getValue();
// 						$dozent->ehemaliger = $objPHPExcel->getActiveSheet()->getCell('AD'.$row->getRowIndex())->getValue();
// 						$dozent->bevStudienfach = $objPHPExcel->getActiveSheet()->getCell('AE'.$row->getRowIndex())->getValue();
// 						#todo splitten
// 						$dozent->bevVorlesungszeit = explode("\n", rtrim($objPHPExcel->getActiveSheet()->getCell('AF'.$row->getRowIndex())->getValue(),"\n"));
							
// 						$dozent->lehrauftrag = $objPHPExcel->getActiveSheet()->getCell('AG'.$row->getRowIndex())->getValue();
// 						$dozent->taetigkeiten = $objPHPExcel->getActiveSheet()->getCell('AH'.$row->getRowIndex())->getValue();
// 						$dozent->info = $objPHPExcel->getActiveSheet()->getCell('AI'.$row->getRowIndex())->getValue();
// 						$dozent->kommentar = $objPHPExcel->getActiveSheet()->getCell('AJ'.$row->getRowIndex())->getValue();
							
// 						# Da die Vorlesungen auf mehrere Spalten im Excel Dokument verteilt
// 						# sind muss hier das vorlesungs-Array mehrvach bef�llt werden
// 						#Einsortieren der Verschiedenen Spalten von Vorlesungen in ein einizges Array
// 						$vorlesungsSpalten = array('AK', 'AL','AM','AN','AO','AP','AQ','AR','AS','AT',);
// 								$vorlesungen = "";
									
// 								foreach ($vorlesungsSpalten as $vs){
// 									$zelle = $objPHPExcel->getActiveSheet()->getCell($vs.$row->getRowIndex())->getValue();
// 									if ($zelle <> "") {
// 										if ($vorlesungen == ""){
// 											$vorlesungen = $zelle;
// 											}
// 										else{
// 											$vorlesungen = $vorlesungen ."\n". $zelle;
// 											}
// 									}
									
// 								}
// 								#String in Array konvertieren
// 								$dozent->vorlesung = explode("\n", $vorlesungen);
// 								$dozent->sprache = explode("\n",$objPHPExcel->getActiveSheet()->getCell('AU'.$row->getRowIndex())->getValue());
// 								$dozent->eingang = $objPHPExcel->getActiveSheet()->getCell('AV'.$row->getRowIndex())->getValue();
									
// 								#Testeintr�ge
// 								# Hier werden einfach exemplarisch einige Daten angezeigt um zu schauen was drinn steht
// 								echo '<table>';
// 								echo '<tr>';
// 								echo '<td>'.$dozent->vorname.'</td>';
// 								echo '<td>'.$dozent->geburtsdatum.'</td>';
// 								//echo '<td>'.$datum.'</td>';
// 								echo '<td>'.$vorlesungen.'</td>';
// 								echo '</tr>';
// 								echo '</table>';
											
// 										# hier Werden die Daten dann in die DB �bertragen
// 										# toDo
											
// 								$dozent = null;
// 								}
// 						}
// 				}
// 				else{
// 					exit("Noch irgendeine Nachricht.");
// 				}
		
// 			function getColumnValue($colName, $row){
// 				global $objPHPExcel;
						
// 				$value = $objPHPExcel->getActiveSheet()->getCell($colName.$row)->getValue();
						
// 				if ($colName == "D" || $colName == "E") {
// 					# \d a digit (0-9) pr�fe auf Zahl
// 					if (preg_match("[\d]", $value) ){
// 						throw new Exception("Textformatierung in Zeile Spalte  $colName pr�fen");
// 					}
// 				}
// 				elseif ($colName == "N") {
// 					if (!preg_match("/^\d{1,2}\.\d{1,2}\.\d{4}$/", $value)){
// 						throw new Exception("Datumsformat in Zeile  Spalte $colname pr�fen");
// 					}
// 				}
						
// 				return $value;
// 					# FEHLERPR�FUNGEN DATUM PFLICHTFELD LEER
// 			}
// 		}
// 	}

?>
</body></html>
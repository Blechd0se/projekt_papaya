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
	public $studienfach;
	public $vorlesungszeiten = array();
	public $lehrauftrag;
	public $taetigkeiten;
	public $info; #"Weitere mˆgliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen";
	public $kommentar;
	public $vorlesungen = array(); # Vorlesung und Sprache ist ein Array
	public $sprachen = array();
	public $eingang;
}

class Bank{
	public $name;
	public $blz;
	public $bic;
	public $iban;
	public $kontonummer;
	public $lbvnr;
}

class Adresse {
	public $straﬂe;
	public $plz;
	public $ort;
}

class Firma {
	public $name;
	public $abteilung;
	public $firmaadresse;
	public $kontaktdaten;
}

class Kontakt{
	public $telefon;
	public $mobil;
	public $email;
	public $webseite;
	public $fax;
}

require_once dirname(__FILE__) . '/Classes/PHPExcel.php';

class ExcelImport{

	private $objPHPExcel;
	private $dozenten  = array();
	
	function __construct($datei){
		/** Error reporting */
		# Welche fehler angezeigt werden Sollen.
		error_reporting(E_ALL);
		ini_set('display_errors', TRUE);
		ini_set('display_startup_errors', TRUE);

		/** Include PHPExcel */
		# PHPExcel Modul Laden

		# pr¸ft ob das Exceldokument vorhanden ist.
		if (file_exists($datei)) {
					
		#Das Exceldokument ˆffnen und in ein PHPExcel-Objekt laden
		$this->objPHPExcel = PHPExcel_IOFactory::load($datei);
			
				#Erstes Tabellenblatt w‰hlen
				$this->objPHPExcel->setActiveSheetIndex(0);
					
				#Excelblatt Zeile f¸r Zeile durchlaufen
				#getRowIterator() gibt dabei immer die aktuelle Zeile aus,
				#die dann Spalte f¸r Spalte durchgearbeitet werden kann
				foreach ($this->objPHPExcel->getActiveSheet()->getRowIterator() as $row) {
				#neues Dozent-Objekt erzeugen
					$dozent = new Dozent();
					$dozent->adressdaten = new Adresse();
					$dozent->kontaktdaten = new Kontakt();
					$dozent->bankdaten = new Bank();
					$dozent->firmendaten = new Firma();
					$dozent->firmendaten->firmaadresse = new Adresse();
					$dozent->firmendaten->kontaktdaten = new Kontakt();

					#pr¸fen ob die Zeile mˆglicherweise ausgeblendet sit (Ist aber nciht wichtig!)
					$rowNumber = $row->getRowIndex();
					if ($rowNumber > 1 and $this->objPHPExcel->getActiveSheet()->getRowDimension($row->getRowIndex())->getVisible()) {
						
					# Mit dem Folgenden Befehl wird auf die Spalte A der aktuellen Zeile zugegriffen
						# $objPHPExcel->getActiveSheet()->getCell('A'.$row->getRowIndex())->getValue()
						# Hier beispielsweise:
						# Gehen in die Zelle A1 und lies dort den Wert aus

						# Wenn der Wert ausgelesen wird wird dieser in das Entsprechende Attribut von Dozent eingetragen
						# $dozent->anrede = 'Ermittelter Wert'

						$dozent->anrede = $this->getColumnValue('A', $row->getRowIndex());
						$dozent->titel = $this->getColumnValue('B',$row->getRowIndex());
						$dozent->abschluss = $this->getColumnValue('C',$row->getRowIndex());
						$dozent->name = $this->getColumnValue('D', $row->getRowIndex());
						$dozent->vorname = $this->getColumnValue('E',$row->getRowIndex());
						
						$dozent->adressdaten->straﬂe = $this->getColumnValue('F',$row->getRowIndex());
						$dozent->adressdaten->plz = $this->getColumnValue('G',$row->getRowIndex());
						$dozent->adressdaten->ort = $this->getColumnValue('H',$row->getRowIndex());
						
						$dozent->beruf = $this->getColumnValue('I',$row->getRowIndex());
						
						$dozent->kontaktdaten->telefon = $this->getColumnValue('J',$row->getRowIndex());
						$dozent->kontaktdaten->mobil = $this->getColumnValue('K',$row->getRowIndex());
						$dozent->kontaktdaten->email = $this->getColumnValue('L',$row->getRowIndex());
						$dozent->kontaktdaten->webseite = $this->getColumnValue('M',$row->getRowIndex());
							
						#Ein Datum muss speziell Ausgelesen werden
						$datum = $this->getColumnValue('N',$row->getRowIndex());
						$dozent->geburtsdatum = date('Y-m-d', PHPExcel_Shared_Date::ExcelToPHP($datum));
							
						$dozent->geburtsort = $this->getColumnValue('O',$row->getRowIndex());
						$dozent->bankdaten->bank = $this->getColumnValue('P',$row->getRowIndex());
						$dozent->bankdaten->blz = $this->getColumnValue('Q',$row->getRowIndex());
						$dozent->bankdaten->bic = $this->getColumnValue('R',$row->getRowIndex());
						$dozent->bankdaten->iban = $this->getColumnValue('S',$row->getRowIndex());
						$dozent->bankdaten->kontonummer = $this->getColumnValue('T',$row->getRowIndex());
						$dozent->bankdaten->lbvnr = $this->getColumnValue('U',$row->getRowIndex());
						
						$dozent->firmendaten->name = $this->getColumnValue('V',$row->getRowIndex());
						$dozent->firmendaten->abteilung = $this->getColumnValue('W',$row->getRowIndex());
						$dozent->firmendaten->firmaadresse->straﬂe = $this->getColumnValue('X',$row->getRowIndex());
						$dozent->firmendaten->firmaadresse->plz = $this->getColumnValue('Y',$row->getRowIndex());
						$dozent->firmendaten->firmaadresse->ort = $this->getColumnValue('Z',$row->getRowIndex());
						$dozent->firmendaten->kontaktdaten->telefon = $this->getColumnValue('AA',$row->getRowIndex());
						$dozent->firmendaten->kontaktdaten->fax = $this->getColumnValue('AB',$row->getRowIndex());
						$dozent->firmendaten->kontaktdaten->mobil = $this->getColumnValue('AC',$row->getRowIndex());
						
						$dozent->ehemaliger = $this->getColumnValue('AD',$row->getRowIndex());
						$dozent->studienfach = $this->getColumnValue('AE',$row->getRowIndex());
						$dozent->vorlesungszeiten = explode("\n", rtrim($this->getColumnValue('AF',$row->getRowIndex()),"\n"));	
						$dozent->lehrauftrag = $this->getColumnValue('AG',$row->getRowIndex());
						$dozent->taetigkeiten = $this->getColumnValue('AH',$row->getRowIndex());
						$dozent->info = $this->getColumnValue('AI',$row->getRowIndex());
						$dozent->kommentar = $this->getColumnValue('AJ',$row->getRowIndex());
							
						# Da die Vorlesungen auf mehrere Spalten im Excel Dokument verteilt
						# sind muss hier das vorlesungs-Array mehrvach bef¸llt werden
						#Einsortieren der Verschiedenen Spalten von Vorlesungen in ein einizges Array
						$spalten = array('AK', 'AL','AM','AN','AO','AP','AQ','AR','AS','AT',);
						$tempVorlesungen = "";
									
						foreach ($spalten as $vs){
							$zelle = $this->getColumnValue($vs,$row->getRowIndex());
							if ($zelle <> "") {
								if ($tempVorlesungen == ""){
									$tempVorlesungen = $zelle;
								}
								else{
									$tempVorlesungen = $tempVorlesungen ."\n". $zelle;
								}
							}
													
						}
						$dozent->vorlesungen = explode("\n", $tempVorlesungen);
						$dozent->sprachen = explode("\n",$this->getColumnValue('AU',$row->getRowIndex()));
						$dozent->eingang = $this->getColumnValue('AV',$row->getRowIndex());

						array_push($this->dozenten, $dozent);
						
						$dozent = null;
					}
				}
		}
		else{
			exit("Noch irgendeine Nachricht.");
		}
	}
	public function dozentenEintragen(){
		
		try {
			//Datenbank-Server verbinden
			$mysqli = new mysqli("localhost", "root", "", "import");
			mysqli_autocommit($mysqli, FALSE);
			
			if ($mysqli->connect_errno) {
				echo "Verbindung zur Datenbank nicht mˆglich: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
			}
			foreach ($this->dozenten as $dozent){
				$commit = false;
				$menschquery = "CALL neuen_mensch_anlegen(".$dozent->anrede .","
														   .$dozent->titel.","
														   	.$dozent->vorname.","
														   	.$dozent->name.","
														   	.$dozent->abschluss.","
														   	.$dozent->geburtsort.","
														   	.$dozent->geburtsdatum.","
														   	.$dozent->ehemaliger.","
														   	.$dozent->beruf.","
														   	."iRONR ka was das sein soll".","
														   	.$dozent->firmendaten->name.","
														   	.$dozent->firmendaten->abteilung.","
														   	."iUS_NR".","
														   	.$dozent->adressdaten->straﬂe.","
														   	.$dozent->adressdaten->plz.","
														   	.$dozent->adressdaten->ort.","
														   	.$dozent->kontaktdaten->telefon.","
														   	.$dozent->kontaktdaten->mobil.","
														   	.$dozent->kontaktdaten->email.","
														   	.$dozent->kontaktdaten->webseite.","
														   	.$dozent->kontaktdaten->fax.")";
				
				echo $menschquery;
				echo "<br>";
				echo "<br>";
				//$menschID = $mysqli->query($menschquery);
				
				if ($menschID <> NULL){
					$commit = true;
				}
				else{
					$commit = false;
				}
				
				$ausgabe = "";
				foreach ($dozent->vorlesungen as $vorlesung){
					$ausgabe = $ausgabe." ". $vorlesung;
				}
			}
			if ($commit = true){
				mysqli_commit($mysqli);
			}
			else{
				mysqli_rollback($mysqli);
				throw new Exception("Daten wurden nicht ¸bertragen, da ein Fehler aufgetreten ist");
			}
			
		} catch (Exception $e) {
			
		}
	}
	public function showData(){
		#Testeintr‰ge
		# Hier werden einfach exemplarisch einige Daten angezeigt um zu schauen was drinn steht
		
		foreach ($this->dozenten as $dozent){
			echo '<tr>';
			echo '<td>'.$dozent->vorname.'</td>';
			echo '<td>'.$dozent->geburtsdatum.'</td>';
			echo '<td>'.$dozent->firmendaten->name.'</td>';
			echo '<td>'.$dozent->firmendaten->firmaadresse->straﬂe.'</td>';
			$ausgabe = "";
			foreach ($dozent->vorlesungen as $vorlesung){
				$ausgabe = $ausgabe." ". $vorlesung;
			}
			echo '<td>'.$ausgabe.'</td>';

			echo '</tr>';
		}
		# hier Werden die Daten dann in die DB ¸bertragen
		# toDo
	}
	private function getColumnValue($colName, $row){
			
		$value = $this->objPHPExcel->getActiveSheet()->getCell($colName.$row)->getValue();
	
		if ($colName == "D" || $colName == "E") {
			# \d a digit (0-9) pr¸fe auf Zahl
			if (preg_match("[\d]", $value) ){
				throw new Exception("Textformatierung in Zeile Spalte  $colName pr¸fen");
			}
		}
// 		elseif ($colName == "N") {
// 			if (!preg_match("/^\d{1,2}\.\d{1,2}\.\d{4}$/", $value)){
// 				throw new Exception("Datumsformat in Zeile  Spalte $colName pr¸fen");
// 			}
// 		}
	
		return $value;
		# FEHLERPR‹FUNGEN DATUM PFLICHTFELD LEER
	}
}

?>
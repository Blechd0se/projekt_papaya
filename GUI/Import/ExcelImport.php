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
	public $info; #"Weitere mögliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen";
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
	public $straße;
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
	private $template = array(); 
	
	function __construct($datei){
		/** Error reporting */
		# Welche fehler angezeigt werden Sollen.
		error_reporting(E_ALL);
		ini_set('display_errors', TRUE);
		ini_set('display_startup_errors', TRUE);

		/** Include PHPExcel */
		# PHPExcel Modul Laden

		$this->template = explode(";",utf8_encode("Anrede;Titel;Abschluss;Name;Vorname;Straße Nr.;PLZ;Ort;Beruf;Telefon;Mobil;E-Mail;Webseite;Geburtsdatum;Geburtsort;Bank;BLZ;BIC;IBAN;Kontonummer;LBV-Nr.;Arbeitgeber Firma;Abteilung;Straße Nr.;PLZ;Ort;Telefon;Fax;Mobil;Ehemalige/r BA-/DHBW-Student/in;Bevorzugtes Studienfach;Bevorzugte Vorlesungszeiten;Lehraufträge und Lehrtätigkeiten;Praktische Tätigkeiten;Weitere m;Anmerkungen, Ergänzungen;Methoden der Wirtschaftsinformatik;Informationstechnologie;Systementwicklung;Mathematik;Allgemeine BWL;Branchenorientierte Vertiefung;Branchenorientierte Vertiefung Bank;Branchenorientierte Vertiefung Versicherung;VWL;Recht;Allgemeine BWL;eingegangen am"));
		
		try{
			# prüft ob das Exceldokument vorhanden ist.
			if (file_exists($datei)) {
						
			#Das Exceldokument öffnen und in ein PHPExcel-Objekt laden
			$this->objPHPExcel = PHPExcel_IOFactory::load($datei);
				
					#Erstes Tabellenblatt wählen
					$this->objPHPExcel->setActiveSheetIndex(0);
						
					#Excelblatt Zeile für Zeile durchlaufen
					#getRowIterator() gibt dabei immer die aktuelle Zeile aus,
					#die dann Spalte für Spalte durchgearbeitet werden kann
					foreach ($this->objPHPExcel->getActiveSheet()->getRowIterator() as $row) {
					#neues Dozent-Objekt erzeugen
						$dozent = new Dozent();
						$dozent->adressdaten = new Adresse();
						$dozent->kontaktdaten = new Kontakt();
						$dozent->bankdaten = new Bank();
						$dozent->firmendaten = new Firma();
						$dozent->firmendaten->firmaadresse = new Adresse();
						$dozent->firmendaten->kontaktdaten = new Kontakt();
	
						
						$rowNumber = $row->getRowIndex();
						if ($rowNumber == 1 and $this->objPHPExcel->getActiveSheet()->getRowDimension($row->getRowIndex())->getVisible()){
							$this->pruefeExcelstuktur();
						}
						
						if ($rowNumber > 1 and $this->objPHPExcel->getActiveSheet()->getRowDimension($row->getRowIndex())->getVisible()) {
						# Mit dem Folgenden Befehl wird auf die Spalte A der aktuellen Zeile zugegriffen
							# $objPHPExcel->getActiveSheet()->getCell('A'.$row->getRowIndex())->getValue()
							# Hier beispielsweise:
							# Gehen in die Zelle A1 und lies dort den Wert aus
	
							# Wenn der Wert ausgelesen wird wird dieser in das Entsprechende Attribut von Dozent eingetragen
							# $dozent->anrede = 'Ermittelter Wert'
							$dozent->anrede = $this->zelleAuslesen('A', $rowNumber);
							$dozent->titel = $this->zelleAuslesen('B', $rowNumber);
							$dozent->abschluss = $this->zelleAuslesen('C', $rowNumber);
							$dozent->name = $this->zelleAuslesen('D', $rowNumber);
							$dozent->vorname = $this->zelleAuslesen('E', $rowNumber);
							
							$dozent->adressdaten->straße = $this->zelleAuslesen('F',$rowNumber);
							$dozent->adressdaten->plz = $this->zelleAuslesen('G',$rowNumber);
							$dozent->adressdaten->ort = $this->zelleAuslesen('H',$rowNumber);
							
							$dozent->beruf = $this->zelleAuslesen('I',$rowNumber);
							
							$dozent->kontaktdaten->telefon = $this->zelleAuslesen('J',$rowNumber);
							$dozent->kontaktdaten->mobil = $this->zelleAuslesen('K',$rowNumber);
							$dozent->kontaktdaten->email = $this->zelleAuslesen('L',$rowNumber);
							$dozent->kontaktdaten->webseite = $this->zelleAuslesen('M',$rowNumber);
								
							#Ein Datum muss speziell Ausgelesen werden
							$datum = $this->zelleAuslesen('N',$rowNumber);
							$dozent->geburtsdatum = date('Y-m-d', PHPExcel_Shared_Date::ExcelToPHP($datum));
								
							$dozent->geburtsort = $this->zelleAuslesen('O',$rowNumber);
							$dozent->bankdaten->bank = $this->zelleAuslesen('P',$rowNumber);
							$dozent->bankdaten->blz = $this->zelleAuslesen('Q',$rowNumber);
							$dozent->bankdaten->bic = $this->zelleAuslesen('R',$rowNumber);
							$dozent->bankdaten->iban = $this->zelleAuslesen('S',$rowNumber);
							$dozent->bankdaten->kontonummer = $this->zelleAuslesen('T',$rowNumber);
							$dozent->bankdaten->lbvnr = $this->zelleAuslesen('U',$rowNumber);
							
							$dozent->firmendaten->name = $this->zelleAuslesen('V',$rowNumber);
							$dozent->firmendaten->abteilung = $this->zelleAuslesen('W',$rowNumber);
							$dozent->firmendaten->firmaadresse->straße = $this->zelleAuslesen('X',$rowNumber);
							$dozent->firmendaten->firmaadresse->plz = $this->zelleAuslesen('Y',$rowNumber);
							$dozent->firmendaten->firmaadresse->ort = $this->zelleAuslesen('Z',$rowNumber);
							$dozent->firmendaten->kontaktdaten->telefon = $this->zelleAuslesen('AA',$rowNumber);
							$dozent->firmendaten->kontaktdaten->fax = $this->zelleAuslesen('AB',$rowNumber);
							$dozent->firmendaten->kontaktdaten->mobil = $this->zelleAuslesen('AC',$rowNumber);
							
							$dozent->ehemaliger = substr($this->zelleAuslesen('AD',$rowNumber),0,1);
							$dozent->studienfach = $this->zelleAuslesen('AE',$rowNumber);
							$dozent->vorlesungszeiten = explode("\n", rtrim($this->zelleAuslesen('AF',$rowNumber),"\n"));	
							$dozent->lehrauftrag = $this->zelleAuslesen('AG',$rowNumber);
							$dozent->taetigkeiten = $this->zelleAuslesen('AH',$rowNumber);
							$dozent->info = $this->zelleAuslesen('AI',$rowNumber);
							$dozent->kommentar = $this->zelleAuslesen('AJ',$rowNumber);
								
							# Da die Vorlesungen auf mehrere Spalten im Excel Dokument verteilt
							# sind muss hier das vorlesungs-Array mehrvach befüllt werden
							#Einsortieren der Verschiedenen Spalten von Vorlesungen in ein einizges Array
							$spalten = array('AK', 'AL','AM','AN','AO','AP','AQ','AR','AS','AT',);
							$tempVorlesungen = "";
										
							foreach ($spalten as $vs){
								$zelle = $this->zelleAuslesen($vs,$rowNumber);
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
							$dozent->sprachen = explode("\n",$this->zelleAuslesen('AU',$rowNumber));
							$dozent->eingang = $this->zelleAuslesen('AV',$rowNumber);
	
							array_push($this->dozenten, $dozent);
							
							$dozent = null;
						}
					}
			}
			else{
				exit("Noch irgendeine Nachricht.");
			}
		}
		catch (Exception $ex) {
			echo "Ein Fehler ist aufgetreten: \n".$ex->getMessage();
		}
	}
	public function dozentenEintragen(){
		
			//Datenbank-Server verbinden
			$mysqli = new mysqli("localhost", "root", "", "import");
			mysqli_autocommit($mysqli, FALSE);
			
			if ($mysqli->connect_errno) {
				echo "Verbindung zur Datenbank nicht möglich: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
			}
			else{
				foreach ($this->dozenten as $dozent){
					$commit = false;
					$menschquery = "select neuen_mensch_anlegen('"
																.$dozent->anrede ."','"
															    .$dozent->titel."','"
															   	.$mysqli->real_escape_string($dozent->vorname)."','"
															   	.$mysqli->real_escape_string($dozent->name)."','"
															   	.$dozent->abschluss."','"
															   	.$dozent->geburtsort."','"
															   	.$dozent->geburtsdatum."','"
															   	.$dozent->ehemaliger."','"
															   	.$dozent->beruf."','"
															   	.NULL."','"
															   	.$dozent->firmendaten->name."','"
															   	.$dozent->firmendaten->abteilung."','"
															   	."815"."','"
															   	.$dozent->adressdaten->straße."','"
															   	.$dozent->adressdaten->plz."','"
															   	.$dozent->adressdaten->ort."','"
															   	.$dozent->kontaktdaten->telefon."','"
															   	.$dozent->kontaktdaten->mobil."','"
															   	.$dozent->kontaktdaten->email."','"
															   	.$dozent->kontaktdaten->webseite."','"
															   	.$dozent->kontaktdaten->fax."',"
															   	.$dozent->bankdaten->bank.","
															   	.$dozent->bankdaten->blz.","
															   	.$dozent->bankdaten->bic.","
															   	.$dozent->bankdaten->iban.","
															   	.$dozent->bankdaten->kontonummer.","
															   	.$dozent->bankdaten->lbvnr.",'"
															   	.$dozent->studienfach."','"
															   	.$dozent->lehrauftrag."','"
															   	.$mysqli->real_escape_string(htmlspecialchars($dozent->taetigkeiten))."','"
															   	.$mysqli->real_escape_string(htmlspecialchars($dozent->info))."','"
															   	.$mysqli->real_escape_string(htmlspecialchars($dozent->kommentar))."')"
															   			;
				
					echo $menschquery;
					echo "<br>";
					echo "<br>";

					$menschID = $mysqli->query($menschquery);
					//$menschID = 111;
					echo "ID aus der DB ". $menschID;
					echo "<br>";
					echo "<br>";
									
					if ($menschID <> NULL){
						$commit = true;
						echo "commit gesendet";
					}
					else{
						$commit = false;
						echo "commit nicht gesendet";
					}
					echo "<br>";
					echo "<br>";
					
					//$ausgabe = "";
					foreach ($dozent->vorlesungen as $vorlesung){
						$vorlesungQuerry = "";
						$vorlesungQuerry = "select neue_mensch_vorlesung_anlegen(".$menschID.",'".$dozent->studienfach."','".$vorlesung."')";
						//hier kommt der Insert für die Vorlesungen hin
						echo $vorlesungQuerry;
						echo "<br>";
					}
					echo "<br>";
					echo "<br>";
				}
// 				if ($commit = true){
// 					mysqli_commit($mysqli);
// 				}
// 				else{
// 					mysqli_rollback($mysqli);
// 					echo "Daten wurden nicht übertragen, da ein Fehler aufgetreten ist";
// 				}
			}
	}
	
	public function showData(){
		#Testeinträge
		# Hier werden einfach exemplarisch einige Daten angezeigt um zu schauen was drinn steht
		
		foreach ($this->dozenten as $dozent){
			echo '<tr>';
			echo '<td>'.$dozent->vorname.'</td>';
			echo '<td>'.$dozent->geburtsdatum.'</td>';
			echo '<td>'.$dozent->firmendaten->name.'</td>';
			echo '<td>'.$dozent->firmendaten->firmaadresse->straße.'</td>';
			$ausgabe = "";
			foreach ($dozent->vorlesungen as $vorlesung){
				$ausgabe = $ausgabe.", ". $vorlesung;
			}
			echo '<td>'.$ausgabe.'</td>';
			echo '</tr>';
		}
	}

// 	}
	private function zelleAuslesen($colName, $row)
	{
		//global $objPHPExcel;
		$value = $this->objPHPExcel->getActiveSheet()->getCell($colName.$row)->getValue();
		if($value == "")
		{
			$value = NULL;
		}
	
		if ($colName == "A" || $colName == "D" || $colName == "E"|| $colName == "E"|| $colName == "F" || $colName == "G" || $colName == "H" || $colName == "I" || $colName == "L" || $colName == "N" || $colName == "O")
		{
			if ($value == "")  {
				throw new Exception("Ein Pflichtfeld ist nicht ausgefüllt!!! \n Zeile $row Spalte " .$colName);
			}
		}
	
		elseif ($colName == "N") {
			if (!preg_match("/^\d{1,2}\.\d{1,2}\.\d{4}$/", $value))
			{
				throw new Exception("Das Datumsfeld in Zeile $row Spalte $colname enthält keinen gültigen Wert!");
			}
		}
	
		elseif ($colName == "D" || $colName == "E") {
			# \d a digit (0-9) prüfe auf Zahl
			if (preg_match("[\d]", $value) )
			{
				throw new Exception("In den Namensfeldern dürfen keine Zahlen vorkommen! \n Zeile $row Spalte $colName prüfen");
			}
		}
		return $value;
	}
	
	private function pruefeExcelstuktur(){
		
		$pruef = TRUE;
		
		$spalten = $this->zelleAuslesen('A',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('B',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('C',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('D',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('E',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('F',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('G',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('H',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('I',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('J',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('K',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('L',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('M',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('N',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('O',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('P',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('Q',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('R',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('S',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('T',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('U',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('V',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('W',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('X',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('Y',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('Z',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AA',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AB',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AC',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AD',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AE',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AF',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AG',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AH',"1");
		$spalten = $spalten.";".substr($this->zelleAuslesen('AI',"1"),0,9);
		$spalten = $spalten.";".$this->zelleAuslesen('AJ',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AK',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AL',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AM',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AN',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AO',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AP',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AQ',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AR',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AS',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AT',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AO',"1");
		$spalten = $spalten.";".$this->zelleAuslesen('AV',"1");

		$test = explode(";", $spalten);

		$max = sizeof($this->template);
		if (sizeof($this->template) == sizeof($test)){
			
			for ($i=0; $i<$max; $i++)
			{
				if (!strcmp($test[$i], $this->template[$i]) == 0){
					
					throw new Exception("Spaltennamen stimmt nicht mit dem Template überein!");
				}

			}
		}
		else{
			throw new Exception("Spaltenanzahl stimmt nicht mit dem Template überein!");
		}
		
	}
}

?>
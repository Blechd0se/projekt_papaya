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
	private $template = array(); 
	
	function __construct($datei){
		/** Error reporting */
		# Welche fehler angezeigt werden Sollen.
		error_reporting(E_ALL);
		ini_set('display_errors', TRUE);
		ini_set('display_startup_errors', TRUE);

		/** Include PHPExcel */
		# PHPExcel Modul Laden

		$this->template = explode(";",utf8_encode("Anrede;Titel;Abschluss;Name;Vorname;Straﬂe Nr.;PLZ;Ort;Beruf;Telefon;Mobil;E-Mail;Webseite;Geburtsdatum;Geburtsort;Bank;BLZ;BIC;IBAN;Kontonummer;LBV-Nr.;Arbeitgeber Firma;Abteilung;Straﬂe Nr.;PLZ;Ort;Telefon;Fax;Mobil;Ehemalige/r BA-/DHBW-Student/in;Bevorzugtes Studienfach;Bevorzugte Vorlesungszeiten;Lehrauftr‰ge und Lehrt‰tigkeiten;Praktische T‰tigkeiten;Weitere mˆgliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen;Anmerkungen, Erg‰nzungen;Methoden der Wirtschaftsinformatik;Informationstechnologie;Systementwicklung;Mathematik;Allgemeine BWL;Branchenorientierte Vertiefung;Branchenorientierte Vertiefung Bank;Branchenorientierte Vertiefung Versicherung;VWL;Recht;Allgemeine BWL;eingegangen am"));
		
		try{
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
							$dozent->anrede = $this->getColumnValue('A', $rowNumber);
							$dozent->titel = $this->getColumnValue('B', $rowNumber);
							$dozent->abschluss = $this->getColumnValue('C', $rowNumber);
							$dozent->name = $this->getColumnValue('D', $rowNumber);
							$dozent->vorname = $this->getColumnValue('E', $rowNumber);
							
							$dozent->adressdaten->straﬂe = $this->getColumnValue('F',$rowNumber);
							$dozent->adressdaten->plz = $this->getColumnValue('G',$rowNumber);
							$dozent->adressdaten->ort = $this->getColumnValue('H',$rowNumber);
							
							$dozent->beruf = $this->getColumnValue('I',$rowNumber);
							
							$dozent->kontaktdaten->telefon = $this->getColumnValue('J',$rowNumber);
							$dozent->kontaktdaten->mobil = $this->getColumnValue('K',$rowNumber);
							$dozent->kontaktdaten->email = $this->getColumnValue('L',$rowNumber);
							$dozent->kontaktdaten->webseite = $this->getColumnValue('M',$rowNumber);
								
							#Ein Datum muss speziell Ausgelesen werden
							$datum = $this->getColumnValue('N',$rowNumber);
							$dozent->geburtsdatum = date('Y-m-d', PHPExcel_Shared_Date::ExcelToPHP($datum));
								
							$dozent->geburtsort = $this->getColumnValue('O',$rowNumber);
							$dozent->bankdaten->bank = $this->getColumnValue('P',$rowNumber);
							$dozent->bankdaten->blz = $this->getColumnValue('Q',$rowNumber);
							$dozent->bankdaten->bic = $this->getColumnValue('R',$rowNumber);
							$dozent->bankdaten->iban = $this->getColumnValue('S',$rowNumber);
							$dozent->bankdaten->kontonummer = $this->getColumnValue('T',$rowNumber);
							$dozent->bankdaten->lbvnr = $this->getColumnValue('U',$rowNumber);
							
							$dozent->firmendaten->name = $this->getColumnValue('V',$rowNumber);
							$dozent->firmendaten->abteilung = $this->getColumnValue('W',$rowNumber);
							$dozent->firmendaten->firmaadresse->straﬂe = $this->getColumnValue('X',$rowNumber);
							$dozent->firmendaten->firmaadresse->plz = $this->getColumnValue('Y',$rowNumber);
							$dozent->firmendaten->firmaadresse->ort = $this->getColumnValue('Z',$rowNumber);
							$dozent->firmendaten->kontaktdaten->telefon = $this->getColumnValue('AA',$rowNumber);
							$dozent->firmendaten->kontaktdaten->fax = $this->getColumnValue('AB',$rowNumber);
							$dozent->firmendaten->kontaktdaten->mobil = $this->getColumnValue('AC',$rowNumber);
							
							$dozent->ehemaliger = $this->getColumnValue('AD',$rowNumber);
							$dozent->studienfach = $this->getColumnValue('AE',$rowNumber);
							$dozent->vorlesungszeiten = explode("\n", rtrim($this->getColumnValue('AF',$rowNumber),"\n"));	
							$dozent->lehrauftrag = $this->getColumnValue('AG',$rowNumber);
							$dozent->taetigkeiten = $this->getColumnValue('AH',$rowNumber);
							$dozent->info = $this->getColumnValue('AI',$rowNumber);
							$dozent->kommentar = $this->getColumnValue('AJ',$rowNumber);
								
							# Da die Vorlesungen auf mehrere Spalten im Excel Dokument verteilt
							# sind muss hier das vorlesungs-Array mehrvach bef¸llt werden
							#Einsortieren der Verschiedenen Spalten von Vorlesungen in ein einizges Array
							$spalten = array('AK', 'AL','AM','AN','AO','AP','AQ','AR','AS','AT',);
							$tempVorlesungen = "";
										
							foreach ($spalten as $vs){
								$zelle = $this->getColumnValue($vs,$rowNumber);
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
							$dozent->sprachen = explode("\n",$this->getColumnValue('AU',$rowNumber));
							$dozent->eingang = $this->getColumnValue('AV',$rowNumber);
	
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
				echo "Verbindung zur Datenbank nicht mˆglich: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
			}
			else{
				foreach ($this->dozenten as $dozent){
					$commit = false;
					$menschquery = "insert into me_mensch \n values('"
																.$dozent->anrede ."','"
															    .$dozent->titel."','"
															   	.$dozent->vorname."','"
															   	.$dozent->name."','"
															   	.$dozent->abschluss."','"
															   	.$dozent->geburtsort."','"
															   	.$dozent->geburtsdatum."','"
															   	.$dozent->ehemaliger."','"
															   	.$dozent->beruf."','"
															   	."'1'".","
															   	.$dozent->firmendaten->name."','"
															   	.$dozent->firmendaten->abteilung."','"
															   	."iUS_NR"."','"
															   	.$dozent->adressdaten->straﬂe."','"
															   	.$dozent->adressdaten->plz."','"
															   	.$dozent->adressdaten->ort."','"
															   	.$dozent->kontaktdaten->telefon."','"
															   	.$dozent->kontaktdaten->mobil."','"
															   	.$dozent->kontaktdaten->email."','"
															   	.$dozent->kontaktdaten->webseite."','"
															   	.$dozent->kontaktdaten->fax."')";
				

					//$menschID = $mysqli->query($menschquery);
					$menschID = NULL;
									
					if ($menschID <> NULL){
						$commit = true;
					}
					else{
						$commit = false;
					}
					
					$ausgabe = "";
					foreach ($dozent->vorlesungen as $vorlesung){
						//hier kommt der Insert f¸r die Vorlesungen hin
						$ausgabe = $ausgabe." ". $vorlesung;
					}
				}
				if ($commit = true){
					mysqli_commit($mysqli);
				}
				else{
					mysqli_rollback($mysqli);
					echo "Daten wurden nicht ¸bertragen, da ein Fehler aufgetreten ist";
				}
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
				$ausgabe = $ausgabe.", ". $vorlesung;
			}
			echo '<td>'.$ausgabe.'</td>';
			echo '</tr>';
		}
	}

// 	}
	private function getColumnValue($colName, $row)
	{
		//global $objPHPExcel;
		$value = $this->objPHPExcel->getActiveSheet()->getCell($colName.$row)->getValue();
	
		if ($colName == "A" || $colName == "D" || $colName == "E"|| $colName == "E"|| $colName == "F" || $colName == "G" || $colName == "H" || $colName == "I" || $colName == "L" || $colName == "N" || $colName == "O")
		{
			if ($value == "")  {
				throw new Exception("Ein Pflichtfeld ist nicht ausgef¸llt!!! \n Zeile $row Spalte " .$colName);
			}
		}
	
		elseif ($colName == "N") {
			if (!preg_match("/^\d{1,2}\.\d{1,2}\.\d{4}$/", $value))
			{
				throw new Exception("Das Datumsfeld in Zeile $row Spalte $colname enth‰lt keinen g¸ltigen Wert!");
			}
		}
	
		elseif ($colName == "D" || $colName == "E") {
			# \d a digit (0-9) pr¸fe auf Zahl
			if (preg_match("[\d]", $value) )
			{
				throw new Exception("In den Namensfeldern d¸rfen keine Zahlen vorkommen! \n Zeile $row Spalte $colName pr¸fen");
			}
		}
		return $value;
	}
	
	private function pruefeExcelstuktur(){
		
		$pruef = TRUE;
		
		$spalten = $this->getColumnValue('A',"1");
		$spalten = $spalten.";".$this->getColumnValue('B',"1");
		$spalten = $spalten.";".$this->getColumnValue('C',"1");
		$spalten = $spalten.";".$this->getColumnValue('D',"1");
		$spalten = $spalten.";".$this->getColumnValue('E',"1");
		$spalten = $spalten.";".$this->getColumnValue('F',"1");
		$spalten = $spalten.";".$this->getColumnValue('G',"1");
		$spalten = $spalten.";".$this->getColumnValue('H',"1");
		$spalten = $spalten.";".$this->getColumnValue('I',"1");
		$spalten = $spalten.";".$this->getColumnValue('J',"1");
		$spalten = $spalten.";".$this->getColumnValue('K',"1");
		$spalten = $spalten.";".$this->getColumnValue('L',"1");
		$spalten = $spalten.";".$this->getColumnValue('M',"1");
		$spalten = $spalten.";".$this->getColumnValue('N',"1");
		$spalten = $spalten.";".$this->getColumnValue('O',"1");
		$spalten = $spalten.";".$this->getColumnValue('P',"1");
		$spalten = $spalten.";".$this->getColumnValue('Q',"1");
		$spalten = $spalten.";".$this->getColumnValue('R',"1");
		$spalten = $spalten.";".$this->getColumnValue('S',"1");
		$spalten = $spalten.";".$this->getColumnValue('T',"1");
		$spalten = $spalten.";".$this->getColumnValue('U',"1");
		$spalten = $spalten.";".$this->getColumnValue('V',"1");
		$spalten = $spalten.";".$this->getColumnValue('W',"1");
		$spalten = $spalten.";".$this->getColumnValue('X',"1");
		$spalten = $spalten.";".$this->getColumnValue('Y',"1");
		$spalten = $spalten.";".$this->getColumnValue('Z',"1");
		$spalten = $spalten.";".$this->getColumnValue('AA',"1");
		$spalten = $spalten.";".$this->getColumnValue('AB',"1");
		$spalten = $spalten.";".$this->getColumnValue('AC',"1");
		$spalten = $spalten.";".$this->getColumnValue('AD',"1");
		$spalten = $spalten.";".$this->getColumnValue('AE',"1");
		$spalten = $spalten.";".$this->getColumnValue('AF',"1");
		$spalten = $spalten.";".$this->getColumnValue('AG',"1");
		$spalten = $spalten.";".$this->getColumnValue('AH',"1");
		$spalten = $spalten.";".$this->getColumnValue('AI',"1");
		$spalten = $spalten.";".$this->getColumnValue('AJ',"1");
		$spalten = $spalten.";".$this->getColumnValue('AK',"1");
		$spalten = $spalten.";".$this->getColumnValue('AL',"1");
		$spalten = $spalten.";".$this->getColumnValue('AM',"1");
		$spalten = $spalten.";".$this->getColumnValue('AN',"1");
		$spalten = $spalten.";".$this->getColumnValue('AO',"1");
		$spalten = $spalten.";".$this->getColumnValue('AP',"1");
		$spalten = $spalten.";".$this->getColumnValue('AQ',"1");
		$spalten = $spalten.";".$this->getColumnValue('AR',"1");
		$spalten = $spalten.";".$this->getColumnValue('AS',"1");
		$spalten = $spalten.";".$this->getColumnValue('AT',"1");
		$spalten = $spalten.";".$this->getColumnValue('AO',"1");
		$spalten = $spalten.";".$this->getColumnValue('AV',"1");
		//$splaten = $spalten;
		$test = explode(";", $spalten);
// 		echo $spalten;
		
// 		echo "<br>";
// 		echo "<br>";
// 		echo $this->template;
// 		echo "<br>";
// 		echo strcmp($spalten, $this->template);
// 		echo "<br>";

		$max = sizeof($this->template);
		if (sizeof($this->template) == sizeof($test)){
			
			for ($i=0; $i<$max; $i++)
			{
				echo $this->template[$i]."|".$test[$i];
				echo "<br>";
				
				if (!strcmp($test[$i], $this->template[$i]) == 0){
					
					throw new Exception("Spaltennamen stimmt nicht mit dem Template ¸berein!");
				}

			}
		}
		else{
			throw new Exception("Spaltenanzahl stimmt nicht mit dem Template ¸berein!");
		}
		
	}
}

?>
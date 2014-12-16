<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Testimport</title>
<link rel="stylesheet" href="style/layout1.css" type="text/css" />
</head>

<body>

<?php

	class Dozent
	{
		public $anrede;
		public $titel;
		public $abschluss;
		public $name;
		public $vorname;
		public $straßeNr;
		public $PLZ;
		public $ort;
		public $beruf;
		public $telefon;
		public $mobil;
		public $email;
		public $webseite;
		public $geburtsdatum;
		public $geburtsort;
		public $bank;
		public $BLZ;
		public $BIC;
		public $IBAN;
		public $kontonummer;
		public $LBVNr;
		public $firma;
		public $firmaAbteilung;
		public $firmaStraßeNr;
		public $firmaPLZ;
		public $firmaOrt;
		public $firmaTelefon;
		public $firmaFax;
		public $firmaMobil;
		public $ehemaliger;
		public $bevStudienfach;
		public $bevVorlesungszeit = array();
		public $lehrauftrag;
		public $taetigkeiten;
		public $info; #"Weitere mögliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen";
		public $kommentar;
		public $vorlesung = array();
		public $sprache = array();
		public $eingang;
		
	}
	
	echo Start;
	/** Error reporting */
	error_reporting(E_ALL);
	ini_set('display_errors', TRUE);
	ini_set('display_startup_errors', TRUE);
	 
	#define('EOL',(PHP_SAPI == 'cli') ? PHP_EOL : '<br />');
	 
	/** Include PHPExcel */
	require_once dirname(__FILE__) . '/Classes/PHPExcel.php';
	 
	#echo ifteil-Anfang;
	
	if (file_exists("Testdaten_2014.xlsx")) {
	
		#echo date('H:i:s') , " Load from Excel2007 file" , EOL;
		#$callStartTime = microtime(true);
	
		$objPHPExcel = PHPExcel_IOFactory::load("Testdaten_2014.xlsx");
	
		#$callEndTime = microtime(true);
		#$callTime = $callEndTime - $callStartTime;
		#echo 'Call time to read Workbook was ' , sprintf('%.4f',$callTime) , " seconds" , EOL;
		// Echo memory usage
		$objPHPExcel->setActiveSheetIndex(0);
		
		foreach ($objPHPExcel->getActiveSheet()->getRowIterator() as $row) {
			#neues Dozent erzeugen
			$dozent = new Dozent();
			
			if ($objPHPExcel->getActiveSheet()->getRowDimension($row->getRowIndex())->getVisible()) {
				#echo '    Row number - ' , $row->getRowIndex() , ' ';
				
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
				$dozent->bevVorlesungszeit[] = $objPHPExcel->getActiveSheet()->getCell('AF'.$row->getRowIndex())->getValue();
				
				$dozent->lehrauftrag = $objPHPExcel->getActiveSheet()->getCell('AG'.$row->getRowIndex())->getValue();
				$dozent->taetigkeiten = $objPHPExcel->getActiveSheet()->getCell('AH'.$row->getRowIndex())->getValue();
				$dozent->info = $objPHPExcel->getActiveSheet()->getCell('AI'.$row->getRowIndex())->getValue();
				$dozent->kommentar = $objPHPExcel->getActiveSheet()->getCell('AJ'.$row->getRowIndex())->getValue();
				#todo Splitten
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
				echo $dozent->anrede.' ';
				echo $dozent->geburtsdatum.' ';
				echo $datum.' ';
				echo '<br>';

				
				#hier Werden die Daten dann in die DB übertragen
			}
		}
		
		
		#echo date('H:i:s') , ' Current memory usage: ' , (memory_get_usage(true) / 1024 / 1024) , " MB" , EOL;
		 
	}
	else{
		exit("Please run 05featuredemo.php first.");
	}

?>
</body></html>
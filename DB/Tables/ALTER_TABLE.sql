ALTER TABLE ad_adresse MODIFY COLUMN ad_strasse_nr VARCHAR (500)  NOT NULL COMMENT 'Definiert die Straße und Hausnummer dieser Adresse';

ALTER TABLE ad_adresse MODIFY COLUMN ad_plz VARCHAR (5)  NOT NULL COMMENT 'Definiert die Postleitzahl dieser Adresse';

ALTER TABLE ad_adresse MODIFY COLUMN ad_ort VARCHAR (200)  NOT NULL COMMENT 'Definiert den Ort dieser Adresse';

ALTER TABLE ad_adresse MODIFY COLUMN ad_erstellt_von VARCHAR (200)  DEFAULT NULL COMMENT 'Definiert den Erfasser dieser Adresse';

ALTER TABLE ad_adresse MODIFY COLUMN ad_kommentar VARCHAR (4000)  DEFAULT NULL COMMENT 'Definiert den Kommentar zu dieser Adresse';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_telefon VARCHAR (20) COMMENT 'Definiert die Telefonnummer zu diesem Kontakt';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_mobil VARCHAR (12)  COMMENT 'Definiert die Mobilnummer zu diesem Kontakt';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_email VARCHAR (250) NOT NULL COMMENT 'Definiert die Email-Adresse zu diesem Kontakt';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_webseite VARCHAR (300)  COMMENT 'Definiert die Website zu diesem Kontakt';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_fax VARCHAR (20) COMMENT 'Definiert die Faxnummer zu dieser Kontakt';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_erstellt_von VARCHAR (200)  DEFAULT NULL COMMENT 'Definiert wer diesen Kontakt erstellt hat';

ALTER TABLE ko_kontakt MODIFY COLUMN ko_kommentar VARCHAR (4000)  DEFAULT NULL COMMENT 'Definiert den Kommentar zu diesem Kontakt';

ALTER TABLE ba_bank MODIFY COLUMN ba_blz INT (8)  NOT NULL COMMENT 'Definiert die Bankleitzahl dieser Bank';

ALTER TABLE ba_bank MODIFY COLUMN ba_bic VARCHAR (11)  NOT NULL COMMENT 'Definiert die BIC dieser Bank';

ALTER TABLE ba_bank MODIFY COLUMN ba_erstellt_von VARCHAR (200)  COMMENT 'Definiert wer diese Bank erstellt hat';

ALTER TABLE ba_bank MODIFY COLUMN ba_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu dieser Bank';

ALTER TABLE vz_vorlesungszeit MODIFY COLUMN vz_bezeichnung VARCHAR (21) NOT NULL COMMENT 'Definiert die Bezeichnung der Vorlesungszeit';

ALTER TABLE vz_vorlesungszeit MODIFY COLUMN vz_erstellt_von VARCHAR (200) DEFAULT NULL COMMENT 'Definiert wann die Vorlesungszeit erstellt wurde';

ALTER TABLE vz_vorlesungszeit MODIFY COLUMN vz_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu dieser Vorlesungszeit';

ALTER TABLE su_studienfach MODIFY COLUMN su_bezeichnung VARCHAR (100)  NOT NULL COMMENT 'Definiert die Bezeichnung des Studienfachs';

ALTER TABLE su_studienfach MODIFY COLUMN su_erstellt_von VARCHAR (200) DEFAULT NULL COMMENT 'Definiert wann das Studienfach erstellt wurde';

ALTER TABLE su_studienfach MODIFY COLUMN su_kommentar VARCHAR (4000)  DEFAULT NULL COMMENT 'Definiert den Kommentar zu diesem Studienfach';

ALTER TABLE vo_vorlesung MODIFY COLUMN su_vo_nr INT NOT NULL COMMENT 'Definiert das Studienfach, dem die Vorlesung zugeordnet ist';

ALTER TABLE vo_vorlesung MODIFY COLUMN vo_erstellt_von VARCHAR (200) DEFAULT NULL COMMENT 'Definiert von wem die Vorlesung erstellt wurde';

ALTER TABLE vo_vorlesung MODIFY COLUMN vo_erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Definiert wann die Vorlesung erstellt wurde';

ALTER TABLE vo_vorlesung MODIFY COLUMN vo_geandert_von VARCHAR (200) COMMENT 'Definiert von wem die Vorlesung geändert wurde';

ALTER TABLE vo_vorlesung MODIFY COLUMN vo_geaendert_am TIMESTAMP COMMENT 'Definiert wann die Vorlesung geändert wurde';

ALTER TABLE vo_vorlesung MODIFY COLUMN vo_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu dieser Vorlesung';

ALTER TABLE ro_rolle MODIFY COLUMN ro_bezeichnung VARCHAR (200)  NOT NULL COMMENT 'Definiert den Fremdschlüssel auf das Studienfach der Rolle';

ALTER TABLE ro_rolle MODIFY COLUMN ro_erstellt_von VARCHAR (200)  DEFAULT NULL COMMENT 'Definiert von wem die Rolle erstellt wurde';

ALTER TABLE ro_rolle MODIFY COLUMN ro_erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Definiert wann die Rolle erstellt wurde';

ALTER TABLE ro_rolle MODIFY COLUMN ro_geaendert_von VARCHAR (400) COMMENT 'Definiert von wem die Rolle geändert wurde';

ALTER TABLE ro_rolle MODIFY COLUMN ro_geaendert_am TIMESTAMP COMMENT 'Definiert wann die Rolle geändert wurde';

ALTER TABLE ro_rolle MODIFY COLUMN ro_kommentar VARCHAR (4000)  DEFAULT NULL COMMENT 'Definiert den Kommentar zu dieser Rolle';

ALTER TABLE me_mensch MODIFY COLUMN ro_me_nr INT NOT NULL COMMENT 'Definiert den Fremdschlüssel auf die Rolle des Menschen';

ALTER TABLE me_mensch MODIFY COLUMN mf_me_nr INT NOT NULL COMMENT 'Definiert den Fremdschlüssel auf die Firma des Menschen';

ALTER TABLE me_mensch MODIFY COLUMN  me_anrede VARCHAR (4) NOT NULL COMMENT 'Definiert die Anrede (Herr oder Frau) dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_titel VARCHAR (10)  NOT NULL COMMENT 'Definiert den Titel (Prof. Dr. oder Dr.) dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_vorname VARCHAR (200)  NOT NULL COMMENT 'Definiert den Vornamen dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_nachname VARCHAR (200)  NOT NULL COMMENT 'Definiert den Nachnamen dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_abschluss VARCHAR (200)  COMMENT 'Definiert den Abschluss dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_gort VARCHAR (100)  NOT NULL COMMENT 'Definiert den Geburtsort dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_gdatum DATE  NOT NULL COMMENT 'Definiert dasGeburtsdatum dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_ist_ehmalig_jn VARCHAR (1)  NOT NULL COMMENT 'Definiert, ob der Mensch Ehemaliger/ Ehemalige der DHBW ist (J oder N)';

ALTER TABLE me_mensch MODIFY COLUMN me_beruf_bezeichnung VARCHAR (500)  NOT NULL COMMENT 'Definiert die Berufsbezeichnung dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_erstellt_von VARCHAR (200)  DEFAULT NULL COMMENT 'Definiert den Ersteller dieses Menschen';

ALTER TABLE me_mensch MODIFY COLUMN me_erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Definiert das Datum, an dem dieser Mensch erstellt wurde';

ALTER TABLE me_mensch MODIFY COLUMN me_geaendert_von VARCHAR (200)  COMMENT 'Definiert wer diesen Menschen geändert hat';

ALTER TABLE me_mensch MODIFY COLUMN me_geandert_am DATE  COMMENT 'Definiert wann dieser Mensch geändert wurde';

ALTER TABLE me_mensch MODIFY COLUMN me_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu diesem Menschen';

ALTER TABLE mensch_vorlesung_zuord MODIFY COLUMN me_mevo_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für den Menschen';

ALTER TABLE mensch_vorlesung_zuord MODIFY COLUMN vo_mevo_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für die Firma';

ALTER TABLE pr_praeferenz MODIFY COLUMN pr_nr INT  NOT NULL COMMENT 'Definiert den Primärschlüssel der Präferenz';

ALTER TABLE pr_praeferenz MODIFY COLUMN me_pr_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel des Menschen für diese Präferenz';

ALTER TABLE pr_praeferenz MODIFY COLUMN su_pr_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für das Studienfach des Menschen';

ALTER TABLE pr_praeferenz MODIFY COLUMN pr_lehrauftraege VARCHAR (1000) COMMENT 'Definiert Lehraufträge und Lehrtätigkeiten/Prüfungsaufträge des Menschen';

ALTER TABLE pr_praeferenz MODIFY COLUMN pr_prak_taetig   VARCHAR (1000) COMMENT 'Definiert die praktische Tätigkeiten des Bewerbers';

ALTER TABLE pr_praeferenz MODIFY COLUMN pr_weitere_infos VARCHAR (4000) COMMENT 'Definiert weitere mögliche Vorlesungsbereiche sowie bereits gehaltene Vorlesungen des Bewerbers';

ALTER TABLE pr_praeferenz MODIFY COLUMN pr_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert Anmerkungen und Ergänzungen des Bewerbers';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN mb_nr INT  NOT NULL COMMENT 'Definiert den Primärschlüssel der Mensch-Bank-Zuordnung';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN me_mb_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel des Menschen für diese Zuordnung';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN ba_mb_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel der Bank für diese Zuordnung';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN mb_iban VARCHAR (34) COMMENT 'Definiert die IBAN';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN mb_konto_nr  VARCHAR (10) COMMENT 'Definiert die Kontonummer';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN  mb_lbv_nr  VARCHAR (15) COMMENT 'Definiert die LBV-Personalnummer';

ALTER TABLE mensch_bank_zuord MODIFY COLUMN mb_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert einen Kommentar zu dieser Zuordnung ';

ALTER TABLE mensch_firma_zuord MODIFY COLUMN fi_mf_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel der Mensch-Firma-Zuordnung';

ALTER TABLE mensch_firma_zuord MODIFY COLUMN mf_abteilung VARCHAR (200) COMMENT 'Definiert die Abteilung des Menschen in der Firma';

ALTER TABLE mensch_firma_zuord MODIFY COLUMN mf_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu der Mensch-Firma-Zuordnung';

ALTER TABLE fi_firma MODIFY COLUMN fi_kommentar VARCHAR (4000)  DEFAULT NULL COMMENT 'Definiert den Kommentar zu dieser Firma';

ALTER TABLE fi_firma MODIFY COLUMN ad_fi_nr INT COMMENT 'Definiert den Fremdschlüssel der Adresse für diese Firma';

ALTER TABLE fi_firma MODIFY COLUMN ko_fi_nr INT COMMENT 'Definiert den Fremdschlüssel für die Kontaktdaten für diese Firma';

ALTER TABLE mensch_vorleszeit_zuord MODIFY COLUMN vz_mevz_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel der Vorlesungszeit zum Menschen';

ALTER TABLE mensch_vorleszeit_zuord MODIFY COLUMN me_mevz_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel des Menschen zur Vorlesungszeit';

ALTER TABLE mensch_persondaten_zuord MODIFY COLUMN mp_nr INT  NOT NULL COMMENT 'Definiert den Primärschlüssel der Mensch_Personendaten-Zuordnung';

ALTER TABLE mensch_persondaten_zuord MODIFY COLUMN ad_mp_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel der Adresse zu einem Menschen';

ALTER TABLE mensch_persondaten_zuord MODIFY COLUMN ko_mp_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für die Kontaktdaten zu einem Menschen';

ALTER TABLE mensch_persondaten_zuord MODIFY COLUMN me_mp_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für den Menschen zu dieser Zuordnung';

ALTER TABLE us_user MODIFY COLUMN us_username VARCHAR (200) NOT NULL COMMENT 'Definiert den Namen des Users';

ALTER TABLE us_user MODIFY COLUMN us_password VARCHAR (200) NOT NULL COMMENT 'Definiert das Passwort zu diesem User';

ALTER TABLE us_user MODIFY COLUMN us_me_nr INT COMMENT 'Definiert den Fremdschlüssel des Users für den Menschen';

ALTER TABLE us_user MODIFY COLUMN us_erstellt_von VARCHAR (200) DEFAULT NULL COMMENT 'Definiert von wem die Userdaten erstellt wurden';

ALTER TABLE us_user MODIFY COLUMN us_erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Definiert wann die Userdaten erstellt wurden';

ALTER TABLE us_user MODIFY COLUMN us_geaendert_von VARCHAR (200) COMMENT 'Definiert von wem die Userdaten geändert wurden';

ALTER TABLE us_user MODIFY COLUMN us_geaendert_am TIMESTAMP NOT NULL COMMENT 'Definiert wann die Userdaten geändert wurden';

ALTER TABLE us_user MODIFY COLUMN us_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu diesem User';

ALTER TABLE st_status MODIFY COLUMN st_bezeichnung VARCHAR (200) NOT NULL COMMENT 'Definiert die Bezeichnung des Status';

ALTER TABLE st_status MODIFY COLUMN st_erstellt_von VARCHAR (200) DEFAULT NULL COMMENT 'Definiert den Ersteller des Status';

ALTER TABLE st_status MODIFY COLUMN st_erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Definiert wann der Status erstellt wurde';

ALTER TABLE st_status MODIFY COLUMN st_geaendert_von VARCHAR (200) COMMENT 'Definiert von wem der Status geändert wurde';

ALTER TABLE st_status MODIFY COLUMN st_geaendert_am TIMESTAMP COMMENT 'Definiert wann der Status geändert wurde';

ALTER TABLE st_status MODIFY COLUMN st_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu diesem Status';

ALTER TABLE sl_status_logging MODIFY COLUMN sl_nr INT  NOT NULL COMMENT 'Definiert den Primärschlüssel des Status Loggings';

ALTER TABLE sl_status_logging MODIFY COLUMN st_sl_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für den Status für das Status Logging';

ALTER TABLE sl_status_logging MODIFY COLUMN me_sl_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für den Menschenfür das Status Logging';

ALTER TABLE sl_status_logging MODIFY COLUMN us_sl_nr INT  NOT NULL COMMENT 'Definiert den Fremdschlüssel für den User für das Status Logging';

ALTER TABLE sl_status_logging MODIFY COLUMN sl_erstellt_von VARCHAR (200) DEFAULT NULL COMMENT 'Definiert von wem das Status Logging durchgeführt wurde';

ALTER TABLE sl_status_logging MODIFY COLUMN sl_erstellt_am TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Definiert wann das Status Logging war';

ALTER TABLE sl_status_logging MODIFY COLUMN sl_kommentar VARCHAR (4000) DEFAULT NULL COMMENT 'Definiert den Kommentar zu dem Status Logging';

-- Auto Increments;
ALTER TABLE ad_adresse CHANGE ad_nr ad_nr INT AUTO_INCREMENT;
ALTER TABLE ba_bank CHANGE ba_nr ba_nr INT AUTO_INCREMENT;
ALTER TABLE fi_firma CHANGE fi_nr fi_nr INT AUTO_INCREMENT;
ALTER TABLE ko_kontakt CHANGE ko_nr ko_nr INT AUTO_INCREMENT;
ALTER TABLE me_mensch CHANGE me_nr me_nr INT AUTO_INCREMENT;
ALTER TABLE mensch_bank_zuord CHANGE mb_nr mb_nr INT AUTO_INCREMENT;
ALTER TABLE mensch_firma_zuord CHANGE mf_nr mf_nr INT AUTO_INCREMENT;
ALTER TABLE mensch_persondaten_zuord CHANGE mp_nr mp_nr INT AUTO_INCREMENT;
ALTER TABLE pr_praeferenz CHANGE pr_nr pr_nr INT AUTO_INCREMENT;
ALTER TABLE ro_rolle CHANGE ro_nr ro_nr INT AUTO_INCREMENT;
ALTER TABLE sl_status_logging CHANGE sl_nr sl_nr INT AUTO_INCREMENT;
ALTER TABLE st_status CHANGE st_nr st_nr INT AUTO_INCREMENT;
ALTER TABLE su_studienfach CHANGE su_nr su_nr INT AUTO_INCREMENT;
ALTER TABLE us_user CHANGE us_nr us_nr INT AUTO_INCREMENT;
ALTER TABLE vo_vorlesung CHANGE vo_nr vo_nr INT AUTO_INCREMENT;
ALTER TABLE vz_vorlesungszeit CHANGE vz_nr vz_nr INT AUTO_INCREMENT;


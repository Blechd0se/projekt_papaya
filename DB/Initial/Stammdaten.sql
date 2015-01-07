/**
 * Autor: Alexander Christ
 * Datum: 29.11.2014
 * Thema: Initiale Daten
 */
 
-- Initialer 'Admin'-User:
INSERT INTO v0_us_user (us_username, us_password                            , us_erstellt_von, us_ist_admin_JN)
                VALUES ('admin'    , '81dc9bdb52d04dc20036dbd8313ed055'     , 'SYSTEM'       ,   'J'          );

-- Status zum Testen:                
INSERT INTO v0_st_status (st_bezeichnung    , st_erstellt_von)
                  VALUES ('Initialer Status', 'SYSTEM');

INSERT INTO v0_st_status (st_bezeichnung         , st_erstellt_von)
                  VALUES ('Bewerbung eingegangen', 'SYSTEM');
                  
INSERT INTO v0_st_status (st_bezeichnung    , st_erstellt_von)
                  VALUES ('Kontaktaufnahme' , 'SYSTEM');

-- Rollen:
INSERT INTO v0_ro_rolle (ro_bezeichnung , ro_erstellt_von)
                 VALUES ('ADMINISTRATOR', 'SYSTEM');
                 
-- Firma-Zuordnung:
INSERT INTO v0_fi_firma  (fi_bezeichnung)
                  VALUES ('DHBW Admin');
                  
-- Mensch-Firma-Zurdonung:
INSERT INTO v0_mensch_firma_zuord (fi_mf_nr)
                           VALUES ((SELECT fi_nr
                                     FROM v0_fi_firma
                                    WHERE fi_bezeichnung = 'DHBW Admin'));
                              
-- Admin-User als Mensch:
INSERT INTO v0_me_mensch (me_anrede, me_titel  , me_vorname, me_nachname, me_gort     , me_gdatum   , me_ist_ehmalig_jn, ro_me_nr                                   , mf_me_nr                                                   , me_beruf_bezeichnung    , me_erstellt_von)
                  VALUES ('Herr'   , 'Prof.Dr.', 'Vorname' , 'Nachname' , 'Stuttgart' , '1900-12-24', 'J'               , (SELECT ro_nr
                                                                                                                             FROM v0_ro_rolle
                                                                                                                            WHERE ro_bezeichnung = 'ADMINISTRATOR') , (SELECT mf_nr
                                                                                                                                                                                                                       FROM v0_mensch_firma_zuord
                                                                                                                                                                                                                      WHERE fi_mf_nr = (SELECT fi_nr
                                                                                                                                                                                                                                          FROM v0_fi_firma
                                                                                                                                                                                                                                         WHERE fi_bezeichnung = 'DHBW Admin')) , 'Administrator der DHBW', 'SYSTEM');
                                                                                                                                                                                                                                         
-- Stammdaten;
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Chinesisch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Deutsch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Englisch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Französisch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Griechisch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Italienisch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Russisch");
INSERT INTO v0_sp_sprache (sp_bezeichnung) VALUES ("Spanisch");


INSERT INTO v0_ro_rolle (ro_bezeichnung) VALUES ("Dozent");
INSERT INTO v0_ro_rolle (ro_bezeichnung) VALUES ("Admin");
INSERT INTO v0_ro_rolle (ro_bezeichnung) VALUES ("User");
INSERT INTO v0_ro_rolle (ro_bezeichnung) VALUES ("Betreuer");
INSERT INTO v0_ro_rolle (ro_bezeichnung) VALUES ("Gast");

INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Methoden der Wirtschaftsinformatik");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Informationstechnologie");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Systementwicklung");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Mathematik");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Allgemeine BWL");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Branchenorientierte Vertiefung");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Branchenorientierte Vertiefung Bank");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Branchenorientierte Vertiefung Versicherung");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("VWL");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Recht");
INSERT INTO v0_su_studienfach (su_bezeichnung) VALUES ("Sprachen");
		

INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Montag Vormittag");	
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Montag Nachmittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Dienstag Vormittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Dienstag Nachmittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Mittwoch Vormittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Mittwoch Nachmittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Donnerstag Vormittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Donnerstag Nachmittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("Freitag Vormittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung)  VALUES ("Freitag Nachmittag");
INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung) VALUES ("zeitlich flexibel");	

  
INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Einführung in die Wirtschaftsinformatik", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung = "Methoden der Wirtschaftsinformatik"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Projektmanagement", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Methoden der Wirtschaftsinformatik"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Programmierung in PHP", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Systementwicklung"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("SAP", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Systementwicklung"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Logik und Algebra", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Mathematik"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Investierung und Finanzierung", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Allgemeine BWL"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Unternehmensführung", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Allgemeine BWL"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Dienstleistungsmanagement", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Branchenorientierte Vertiefung"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Kredit", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Branchenorientierte Vertiefung Bank"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Grundlagen Versicherungswesen", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Branchenorientierte Vertiefung Versicherung"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Geld; Kredit und Währung", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="VWL"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Wirtschafts-/Arbeits-/ Sozialpolitik", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="VWL"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("EDV-Recht", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Recht"));

INSERT INTO v0_vo_vorlesung (vo_bezeichnung, su_vo_nr) VALUES ("Spanisch", (SELECT su_nr FROM v0_su_studienfach WHERE su_bezeichnung="Sprachen"));

                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         
COMMIT;                                                                                                                                                                                                                                    
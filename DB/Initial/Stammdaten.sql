/**
 * Autor: Alexander Christ
 * Datum: 29.11.2014
 * Thema: Initiale Daten
 */
 
-- Initialer 'Admin'-User:
INSERT INTO v0_us_user (us_username, us_password, us_erstellt_von)
                VALUES ('admin'    , '1234'     , 'SYSTEM');

-- Status zum Testen:                
INSERT INTO v0_st_status (st_bezeichnung    , st_erstellt_von)
                  VALUES ('Initialer Status', 'SYSTEM');

INSERT INTO v0_st_status (st_bezeichnung         , st_erstellt_von)
                  VALUES ('Bewerbung eingegangen', 'SYSTEM');
                  
INSERT INTO v0_st_status (st_bezeichnung    , st_erstellt_von)
                  VALUES ('Kontaktaufnahme' , 'SYSTEM');

-- Rollen:
INSERT INTO v0_ro_rolle (ro_intern_jn, ro_bezeichnung , ro_erstellt_von)
                 VALUES ( 'J'        , 'ADMINISTRATOR', 'SYSTEM');
                 
-- Firma-Zuordnung:
INSERT INTO v0_fi_firma  (fi_bezeichnung)
                  VALUES ('DHBW Admin');
                  
-- Mensch-Firma-Zurdonung:
INSERT INTO v0_mensch_firma_zuord (fi_mf_nr)
                           VALUES ((SELECT fi_nr
                                     FROM v0_fi_firma
                                    WHERE fi_bezeichnung = 'DHBW Admin'));
                              
-- Admin-User als Mensch:
INSERT INTO v0_me_mensch (me_anrede, me_titel  , me_vorname, me_nachname, me_gort     , me_gdatum   , me_ist_ehmalig_jn, ro_me_nr                                  , st_me_nr                                   , mf_me_nr                                                   , me_beruf_bezeichnung    , me_erstellt_von)
                  VALUES ('Herr'   , 'Prof.Dr.', 'Vorname' , 'Nachname' , 'Stuttgart' , '1900-12-24', 'J'               , (SELECT ro_nr
                                                                                                                             FROM v0_ro_rolle
                                                                                                                            WHERE ro_bezeichnung = 'ADMINISTRATOR') , (SELECT st_nr
                                                                                                                                                                         FROM v0_st_status
                                                                                                                                                                        WHERE st_bezeichnung = 'Initialer Status'), (SELECT mf_nr
                                                                                                                                                                                                                       FROM v0_mensch_firma_zuord
                                                                                                                                                                                                                      WHERE fi_mf_nr = (SELECT fi_nr
                                                                                                                                                                                                                                          FROM v0_fi_firma
                                                                                                                                                                                                                                         WHERE fi_bezeichnung = 'DHBW Admin')) , 'Administrator der DHBW', 'SYSTEM');
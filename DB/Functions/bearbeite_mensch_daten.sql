DROP FUNCTION bearbeite_mensch_daten;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei Erfolg einen Erfolgstext, ansonsten der genaue Fehler
 * 
 * iME_NR, Mensch_Nr, die einen neuen Status erhalten soll
 * iME_TITEL, String der dem Titel des Menschen entspricht
 * iME_VORNAME, String der dem Vornamen des Menschen entspricht
 * iME_NACHNAME, String der dem Nachnamen des Menschen entspricht
 * iME_ABSCHLUSS, String der dem Abschluss des Menschen entspricht
 * iME_GORT, String der dem Geburtsort des Menschen entspricht
 * iME_GDATUM, Date das dem Datum (1900-12-31) des Menschen entspricht
 * iME_EHEMALIG, String welcher als Flag angibt, ob ehemalig oder nicht
 * iME_BERUF, String der den Beruf des Menschen entspricht
 * iBA_BEZEICHNUNG, String der der Bezeichnung der Bank des Menschen entspricht
 * iBA_BLZ, String Bankleitzahl BLZ der Bank entspricht
 * iBA_BIC, String die BIC (Bank Identifier Code) der Bank entspricht
 * iFI_AD_STRASSE_NR, String der der Stra�e (Wohnort) der Firma entspricht
 * iFI_AD_PLZ, String der der PLZ (Wohnort) der Firma entspricht
 * iFI_AD_ORT, String der dem Ort (Wohnort) der Firma entspricht
 * iFI_KO_TELEFON, String der der (Festnetz-)Telefonnumer der Firma entspricht
 * iFI_KO_MOBIL, String der der Mobiltelefonnummer der Firma entspricht
 * iFI_KO_EMAIL, String der der Email-Adresse der Firma entspricht
 * iFI_KO_WEBSEITE, String der der Webseite der Firma entspricht
 * iFI_KO_FAX, String der dem Fax-Anschluss der Firma entspricht
 * iAD_STRASSE_NR, String der der Straße (Wohnort) des Menschen entspricht
 * iAD_PLZ, String der der PLZ (Wohnort) des Menschen entspricht
 * iAD_ORT, String der dem Ort (Wohnort) des Menschen entspricht
 * iKO_TELEFON, String der der (Festnetz-)Telefonnumer des Menschen entspricht
 * iKO_MOBIL, String der der Mobiltelefonnummer des Menschen entspricht
 * iKO_EMAIL, String der der Email-Adresse des Menschen entspricht
 * iKO_WEBSEITE, String der der Webseite des Menschen entspricht
 * iKO_FAX, String der dem Fax-Anschluss des Menschen entspricht
 */
CREATE FUNCTION bearbeite_mensch_daten(
    iME_NR            INT,
    iME_ANREDE        VARCHAR(4), 
    iME_TITEL         VARCHAR(10),
    iME_VORNAME       VARCHAR(200),
    iME_NACHNAME      VARCHAR(200),
    iME_ABSCHLUSS     VARCHAR(200),
    iME_BERUF         VARCHAR(500),
    iME_GORT          VARCHAR(100),
    iME_GDATUM        DATE,
    iBA_BEZEICHNUNG   VARCHAR(500),
    iBA_BLZ           INT(8),
    iBA_BIC           VARCHAR(11),
    iMB_IBAN          VARCHAR(34),
    iMB_KONTO_NR      VARCHAR(10),
    iMB_LBV_NR        VARCHAR(15),
    iMF_ABTEILUNG     VARCHAR(200),
    iFI_BEZEICHNUNG   VARCHAR(500),
    iFI_KO_TELEFON    VARCHAR(20),
    iFI_KO_MOBIL      VARCHAR(12),
    iFI_KO_EMAIL      VARCHAR(250),
    iFI_KO_WEBSEITE   VARCHAR(300),
    iFI_KO_FAX        VARCHAR(20),
    iFI_AD_STRASSE_NR VARCHAR(500),
    iFI_AD_PLZ        VARCHAR(5),
    iFI_AD_ORT        VARCHAR(200),
    iKO_TELEFON       VARCHAR(20),
    iKO_MOBIL         VARCHAR(12),
    iKO_EMAIL         VARCHAR(250),
    iKO_WEBSEITE      VARCHAR(300),
    iKO_FAX           VARCHAR(20),
    iAD_STRASSE_NR    VARCHAR(500),
    iAD_PLZ           VARCHAR(5),
    iAD_ORT           VARCHAR(200)
  ) RETURNS VARCHAR(100)
    DETERMINISTIC
BEGIN
    DECLARE v_ba_nr INT DEFAULT NULL;
    DECLARE v_counter INT DEFAULT NULL;
    DECLARE v_looper INT DEFAULT 0;
    DECLARE v_loop_ended INT DEFAULT FALSE;
    DECLARE v_mf_nr INT DEFAULT NULL;
    DECLARE v_fi_nr INT DEFAULT NULL;
    DECLARE v_ad_fi_nr INT DEFAULT NULL;
    DECLARE v_ko_fi_nr INT DEFAULT NULL;
    DECLARE v_ad_nr INT DEFAULT NULL;
    DECLARE v_ko_nr INT DEFAULT NULL;
    DECLARE c_ba_cursor CURSOR FOR SELECT ba_nr
                                     FROM v_mensch_bankdaten
                                    WHERE me_nr = iME_NR;
    DECLARE c_ad_cursor CURSOR FOR SELECT ad_nr
                                     FROM v_mensch_daten
                                    WHERE me_nr = iME_NR;
    DECLARE c_ko_cursor CURSOR FOR SELECT ko_nr
                                     FROM v_mensch_daten
                                    WHERE me_nr = iME_NR
                                    LIMIT 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_loop_ended = TRUE;                                
    
    
    -- Update unseren Menschen zuerst;
    UPDATE v0_me_mensch
       SET me_anrede    = iME_ANREDE,
           me_titel     = iME_TITEL,
           me_vorname   = iME_VORNAME,
           me_nachname  = iME_NACHNAME,
           me_abschluss = iME_ABSCHLUSS,
           me_gort      = iME_GORT,
           me_gdatum    = iME_GDATUM,
           me_beruf_bezeichnung = iME_BERUF
     WHERE me_nr = iME_NR;
    
    
    -- Loop für unsere Bank-Daten;
    IF iBA_BEZEICHNUNG <> '' THEN
    
       SELECT count(ba_nr)
         INTO v_counter
         FROM v_mensch_bankdaten
        WHERE me_nr = iME_NR;
    
        IF v_counter = 0 THEN
            CALL neue_bankdaten_anlegen(iME_NR,
                                        iBA_BEZEICHNUNG,
                                        iBA_BLZ,
                                        iBA_BIC,
                                        iMB_IBAN,
                                        iMB_KONTO_NR,
                                        iMB_LBV_NR);
        END IF;
    
        OPEN c_ba_cursor;
        bank_loop: LOOP
    
            FETCH c_ba_cursor INTO v_looper;
        
            IF v_loop_ended THEN
                LEAVE bank_loop;
            END IF;
        
            SELECT count(me_nr)
              INTO v_counter
              FROM v_mensch_bankdaten
             WHERE ba_nr = v_looper;
         
            IF v_counter = 0 THEN
                -- Wir haben keinen Satz gefunden, wir können einen Insert starten
                RETURN 'Es ist ein außerordentlicher Fehler innheralb des Bank-Loops aufgetreten';
            ELSEIF v_counter = 1 THEN
                -- Wir haben genau einen Satz gefunden, das ist unser Mensch!
            
                -- Dubletten-Check;
                SELECT ba_nr
                  INTO v_ba_nr
                  FROM v0_ba_bank
                 WHERE ba_bezeichnung = iBA_BEZEICHNUNG;
            
                IF v_ba_nr IS NOT NULL THEN
                    UPDATE v0_mensch_bank_zuord
                       SET ba_mb_nr = v_ba_nr
                     WHERE me_mb_nr = iME_NR
                       AND ba_mb_nr = v_looper;
                       
                    UPDATE v0_ba_bank
                       SET ba_blz         = iBA_BLZ,
                           ba_bic         = iBA_BIC
                     WHERE ba_nr = v_looper;   
                ELSE
                    UPDATE v0_ba_bank
                       SET ba_bezeichnung = iBA_BEZEICHNUNG,
                           ba_blz         = iBA_BLZ,
                           ba_bic         = iBA_BIC
                     WHERE ba_nr = v_looper;
             
                END IF;
                
            ELSEIF v_counter >= 2 THEN
                -- Mehrere Menschen zeigen auf diesen Bank Satz
            
                -- Dubletten-Check;
                SELECT ba_nr
                  INTO v_ba_nr
                  FROM v0_ba_bank
                 WHERE ba_bezeichnung = iBA_BEZEICHNUNG;
            
                IF v_ba_nr IS NULL THEN
                    -- Neue Bank erstellen;
                    INSERT INTO v0_ba_bank (ba_bezeichnung  , ba_blz  , ba_bic )
                                    VALUES (iBA_BEZEICHNUNG , iBA_BLZ , iBA_BIC);
                    SELECT LAST_INSERT_ID()
                      INTO v_ba_nr;
                                
                END IF;
            END IF;
            
                -- Update unseren Menschen;
                UPDATE v0_mensch_bank_zuord
                   SET ba_mb_nr = v_ba_nr,
                       mb_iban  = iMB_IBAN,
                       mb_konto_nr = iMB_KONTO_NR,
                       mb_lbv_nr = iMB_LBV_NR
                 WHERE me_mb_nr = iME_NR
                   AND ba_mb_nr = v_looper;
            
        END LOOP bank_loop;
  
        CLOSE c_ba_cursor;
    
    END IF;

    -- Abteilungs Zuordnung;
    SELECT mf_nr, fi_mf_nr
      INTO v_mf_nr, v_fi_nr
      FROM v_mensch_firma_daten
     WHERE me_nr = iME_NR;
     
    -- Fall; Wir hatten davor noch keine Abteilung angegeben 
    IF iMF_ABTEILUNG IS NOT NULL THEN
        UPDATE v0_mensch_firma_zuord
           SET mf_abteilung = iMF_ABTEILUNG
         WHERE mf_nr = v_mf_nr;
    END IF;
    
    IF iFI_BEZEICHNUNG IS NOT NULL THEN
        UPDATE v0_fi_firma
           SET fi_bezeichnung = iFI_BEZEICHNUNG
         WHERE fi_nr = v_fi_nr;
    ELSE
        RETURN 'Keine Firmenbezeichnung angeben';
    END IF;
    
    -- Optionale Adresse/Kontakt pro Firma �berpr�fen;
    SELECT ad_nr, ko_nr
      INTO v_ad_fi_nr, v_ko_fi_nr
      FROM v_mensch_firma_daten
     WHERE me_nr = iME_NR; 
    
    IF v_ad_fi_nr IS NULL AND
       iFI_AD_STRASSE_NR IS NOT NULL THEN
       
        INSERT INTO v0_ad_adresse (ad_strasse_nr,     ad_plz    , ad_ort    )
                           VALUES (iFI_AD_STRASSE_NR, iFI_AD_PLZ, iFI_AD_ORT);
        SELECT LAST_INSERT_ID()
          INTO v_ad_fi_nr;
    ELSE
        UPDATE v0_ad_adresse 
           SET ad_strasse_nr = iFI_AD_STRASSE_NR,
               ad_plz        = iFI_AD_PLZ,
               ad_ort        = iFI_AD_ORT
         WHERE ad_nr = v_ad_fi_nr;
    
    END IF;
    
    IF v_ko_fi_nr IS NULL AND
       iFI_KO_EMAIL IS NOT NULL AND
       iFI_KO_EMAIL <> '' THEN
       
       INSERT INTO v0_ko_kontakt (ko_telefon     , ko_mobil    , ko_email    , ko_webseite    , ko_fax    )
                          VALUES (iFI_KO_TELEFON , iFI_KO_MOBIL, iFI_KO_EMAIL, iFI_KO_WEBSEITE, iFI_KO_FAX);
       SELECT LAST_INSERT_ID()
         INTO v_ko_fi_nr;
    
    ELSE
      SELECT count(ko_email)
        INTO v_counter
        FROM v0_ko_kontakt
       WHERE ko_email = iFI_KO_EMAIL;
       
      IF v_counter > 0 THEN
          UPDATE v0_ko_kontakt
             SET ko_telefon  = iFI_KO_TELEFON,
                 ko_mobil    = iFI_KO_MOBIL,
                 ko_webseite = iFI_KO_WEBSEITE,
                 ko_fax      = iFI_KO_FAX
           WHERE ko_nr = v_ko_fi_nr;
      END IF;
    
      UPDATE v0_ko_kontakt
         SET ko_telefon  = iFI_KO_TELEFON,
             ko_mobil    = iFI_KO_MOBIL,
             ko_email    = iFI_KO_EMAIL,
             ko_webseite = iFI_KO_WEBSEITE,
             ko_fax      = iFI_KO_FAX
       WHERE ko_nr = v_ko_fi_nr;
    END IF;
      
    -- Firmen-Referenz updaten;
    UPDATE v0_fi_firma
       SET ad_fi_nr = v_ad_fi_nr,
           ko_fi_nr = v_ko_fi_nr
     WHERE fi_nr = v_fi_nr;
    
    UPDATE v0_me_mensch
       SET mf_me_nr = v_mf_nr
     WHERE me_nr = iME_NR;
    
    SET v_loop_ended = FALSE;
    
    -- Loop f�r unsere Adress-Daten;
    OPEN c_ad_cursor;
    adress_loop: LOOP
    
        FETCH c_ad_cursor INTO v_looper;
        
        IF v_loop_ended THEN
            LEAVE adress_loop;
        END IF;
        
        SELECT count(me_nr)
          INTO v_counter
          FROM v_mensch_daten
         WHERE ad_nr = v_looper;
         
        IF v_counter = 0 THEN
            -- Wir haben keinen Satz gefunden, wir können einen Insert starten
            RETURN 'Es ist ein außerordentlicher Fehler aufgetreten innerhalb des Adress-Loops';
        ELSEIF v_counter = 1 THEN
            -- Wir haben genau einen Satz gefunden, das ist unser Mensch!
            
            -- Dubletten-Check;
            SELECT ad_nr
              INTO v_ad_nr
              FROM v0_ad_adresse
             WHERE ad_strasse_nr = iAD_STRASSE_NR
               AND ad_plz        = iAD_PLZ
               AND ad_ort        = iAD_ORT;
            
            IF v_ad_nr IS NOT NULL THEN
                UPDATE v0_mensch_persondaten_zuord
                   SET ad_mp_nr = v_ad_nr
                 WHERE me_mp_nr = iME_NR
                   AND ad_mp_nr = v_looper;
            ELSE
                UPDATE v0_ad_adresse
                   SET ad_strasse_nr = iAD_STRASSE_NR,
                       ad_plz        = iAD_PLZ,
                       ad_ort        = iAD_ORT
                 WHERE ad_nr = v_looper;
             
            END IF; 
        ELSEIF v_counter >= 2 THEN
            -- Mehrere Menschen zeigen auf diesen Bank Satz
            
            -- Dubletten-Check;
            SELECT ad_nr
              INTO v_ad_nr
              FROM v0_ad_adresse
             WHERE ad_strasse_nr = iAD_STRASSE_NR
               AND ad_plz        = iAD_PLZ
               AND ad_ort        = iAD_ORT;
            
            IF v_ad_nr IS NULL THEN
                -- Neue Adresse erstellen;
                INSERT INTO v0_ad_adresse (ad_strasse_nr  , ad_plz  , ad_ort )
                                   VALUES (iAD_STRASSE_NR , iAD_PLZ , iAD_ORT);
                SELECT LAST_INSERT_ID()
                  INTO v_ad_nr;
                                
            END IF;
            
            -- Update unseren Menschen;
            UPDATE v0_mensch_persondaten_zuord
               SET ad_mp_nr = v_ad_nr
             WHERE me_mp_nr = iME_NR
               AND ad_mp_nr = v_looper;
        END IF;
    
    END LOOP adress_loop;
  
    CLOSE c_ad_cursor;
    
    SET v_loop_ended = FALSE;
    
    -- Loop für unsere Kontakt-Daten;
    OPEN c_ko_cursor;
    kontakt_loop: LOOP
    
        FETCH c_ko_cursor INTO v_looper;
        
        IF v_loop_ended THEN
            LEAVE kontakt_loop;
        END IF;
        
        
        SELECT count(me_nr)
          INTO v_counter
          FROM (SELECT me_nr
                  FROM v_mensch_daten
                 WHERE ko_nr = v_looper
                 GROUP BY me_nr) AS tabelle;
         
        IF v_counter = 0 THEN
            -- Wir haben keinen Satz gefunden, wir k�nnen einen Insert starten
            RETURN 'Es ist ein außerordentlicher Fehler aufgetreten innerhalb des Kontakt-Loops';
        ELSEIF v_counter = 1 THEN
            -- Wir haben genau einen Satz gefunden, das ist unser Mensch!
            
            -- Dubletten-Check;
            SELECT ko_nr
              INTO v_ko_nr
              FROM v0_ko_kontakt
             WHERE ko_email = iKO_EMAIL;
            
            IF v_ko_nr IS NOT NULL THEN
                UPDATE v0_mensch_persondaten_zuord
                   SET ko_mp_nr = v_ko_nr
                 WHERE me_mp_nr = iME_NR
                   AND ko_mp_nr = v_looper;  
            END IF;
            
            UPDATE v0_ko_kontakt
               SET ko_telefon  = iKO_TELEFON, 
                   ko_mobil    = iKO_MOBIL,
                   ko_email    = iKO_EMAIL,
                   ko_webseite = iKO_WEBSEITE,
                   ko_fax      = iKO_FAX
             WHERE ko_nr = v_looper;
            
        ELSEIF v_counter >= 2 THEN
            -- Mehrere Menschen zeigen auf diesen Bank Satz
                        
            -- Dubletten-Check;
            SELECT ko_nr
              INTO v_ko_nr
              FROM v0_ko_kontakt
             WHERE ko_email = iKO_EMAIL;
            
            IF v_ko_nr IS NULL THEN
                -- Neuen Kontakt erstellen;
                INSERT INTO v0_ko_kontakt (ko_telefon  , ko_mobil  , ko_email  , ko_webseite  , ko_fax )
                                   VALUES (iKO_TELEFON , iKO_MOBIL , iKO_EMAIL , iKO_WEBSEITE , iKO_FAX);
                SELECT LAST_INSERT_ID()
                  INTO v_ko_nr;               
            END IF;
            
            UPDATE v0_ko_kontakt
               SET ko_telefon  = iKO_TELEFON, 
                   ko_mobil    = iKO_MOBIL,
                   ko_email    = iKO_EMAIL,
                   ko_webseite = iKO_WEBSEITE,
                   ko_fax      = iKO_FAX
             WHERE ko_nr = v_ko_nr; 
            
            -- Update unseren Menschen;
            UPDATE v0_mensch_persondaten_zuord
               SET ko_mp_nr = v_ko_nr
             WHERE me_mp_nr = iME_NR
               AND ko_mp_nr = v_looper;
               
        END IF;
    
    END LOOP kontakt_loop;
  
    CLOSE c_ko_cursor;
      
    RETURN 'Erfolgreich abgearbeitet';
END;
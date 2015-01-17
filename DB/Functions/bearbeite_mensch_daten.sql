DROP FUNCTION bearbeite_mensch_daten;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei Erfolg 1 zurück, ansonsten 0
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
 */
CREATE FUNCTION bearbeite_mensch_daten(
    iME_NR          INT,
    iME_ANREDE      VARCHAR(4), 
    iME_TITEL       VARCHAR(10),
    iME_VORNAME     VARCHAR(200),
    iME_NACHNAME    VARCHAR(200),
    iME_ABSCHLUSS   VARCHAR(200),
    iME_GORT        VARCHAR(100),
    iME_GDATUM      DATE,
    iBA_BEZEICHNUNG VARCHAR(500),
    iBA_BLZ         INT(8),
    iBA_BIC         VARCHAR(11)
  ) RETURNS VARCHAR(100)
    DETERMINISTIC
BEGIN
    DECLARE v_ba_nr INT DEFAULT NULL;
    DECLARE v_counter INT DEFAULT NULL;
    DECLARE v_looper INT DEFAULT 0;
    DECLARE v_loop_ended INT DEFAULT FALSE;
    DECLARE c_ba_cursor CURSOR FOR SELECT ba_nr
                                     FROM v_mensch_bankdaten
                                    WHERE me_nr = iME_NR;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_loop_ended = TRUE;                                
    
    
    -- Update unseren Menschen zuerst;
    UPDATE v0_me_mensch
       SET me_anrede    = iME_ANREDE,
           me_titel     = iME_TITEL,
           me_vorname   = iME_VORNAME,
           me_nachname  = iME_NACHNAME,
           me_abschluss = iME_ABSCHLUSS,
           me_gort      = iME_GORT,
           me_gdatum    = iME_GDATUM
     WHERE me_nr = iME_NR;
    
    
    -- Loop für unsere Bank-Daten;
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
            RETURN 'Es ist ein außerordentlicher Fehler aufgetreten';
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
            
            -- Update unseren Menschen;
            UPDATE v0_mensch_bank_zuord
               SET ba_mb_nr = v_ba_nr
             WHERE me_mb_nr = iME_NR
               AND ba_mb_nr = v_looper;
        END IF;
    
    END LOOP bank_loop;
  
    CLOSE c_ba_cursor;

    RETURN 'Erfolgreich abgearbeitet';
END;
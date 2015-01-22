DROP FUNCTION setze_status_mensch;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei Erfolg 1 zurück, ansonsten 0
 * 
 * iME_NR, Mensch_Nr, die einen neuen Status erhalten soll
 * iST_NR, Status_Nr, die Status Nr, die gesetzt werden soll
 * iUS_NR, User_nr, der den Status geändert hat
 * iSL_KOMMENTAR, Optionales Kommentar
 */
CREATE FUNCTION setze_status_mensch(
    iME_NR INT,
    iST_NR INT,
    iUS_NR INT,
    iSL_KOMMENTAR VARCHAR(4000)
  ) RETURNS INT
    DETERMINISTIC
BEGIN

    DECLARE v_aktuelle_st_nr INT DEFAULT NULL;

    SELECT st_nr
      INTO v_aktuelle_st_nr
      FROM v_mensch_aktueller_status
     WHERE me_nr = iME_NR
     ORDER BY sl_erstellt_am DESC
     LIMIT 1;
     
    IF iST_NR <> v_aktuelle_st_nr THEN
     
        INSERT INTO v0_sl_status_logging (st_sl_nr, me_sl_nr, us_sl_nr, sl_kommentar )
                                   VALUES (iST_NR  , iME_NR  , iUS_NR , iSL_KOMMENTAR);
                                   
        RETURN 1;
     
    END IF;

    RETURN 0;
END;
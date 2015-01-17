DROP FUNCTION bearbeite_mensch_daten;

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
CREATE FUNCTION bearbeite_mensch_daten(
    iME_NR INT,
    iBA_BEZEICHNUNG VARCHAR(500)
  ) RETURNS VARCHAR(100)
    DETERMINISTIC
BEGIN
    DECLARE v_ba_counter INT DEFAULT NULL;
    
    -- Hole unsere banken;
    SELECT count(ba_nr)
      INTO v_ba_counter
      FROM v_mensch_bankdaten
     WHERE ba_bezeichnung = iBA_BEZEICHNUNG; 

    IF v_ba_counter = 0 THEN
        RETURN 'Genau keinen Satz gefunden, kann inserted werden';
    ELSEIF v_ba_counter = 1 THEN
        RETURN 'Genau einen Satz gefunden';
    ELSEIF v_ba_counter >= 2 THEN
        RETURN 'Multiple S�tze gefunden, COW notwendig!';
    END IF;

    RETURN 'Irgendwas ist schiefgelaufen';
END;
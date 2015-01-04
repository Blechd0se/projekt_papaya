DROP FUNCTION neues_studienfach_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 04.01.2015
 * Thema: Legt ein neues Studienfach an und liefert dessen Primärschlüssel
 *        zurück.
 * 
 * iSU_BEZEICHNUNG, String der dem Namen des Studienfaches entspricht
 */
CREATE FUNCTION neues_studienfach_anlegen(
    iSU_BEZEICHNUNG VARCHAR(100)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_su_nr INT DEFAULT NULL;

    SELECT su_nr
      INTO v_su_nr
      FROM v0_su_studienfach
     WHERE su_bezeichnung = iSU_BEZEICHNUNG;

    IF v_su_nr IS NULL THEN

        INSERT INTO v0_su_studienfach (su_bezeichnung )
                               VALUES (iSU_BEZEICHNUNG);
        
         SELECT LAST_INSERT_ID()
           INTO v_su_nr;    
                    
    END IF;
       
    RETURN v_su_nr;
END;

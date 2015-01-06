DROP PROCEDURE neue_mensch_vorleszeit_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 06.01.2015
 * Thema: Legt eine neue Mensch-Vorlesungszeit-Zuordnung an und prüft dabei auf eventuell
 *        vorhandene Dubletten.
 * 
 * iME_NR, INT zu welchem Menschen soll der Datensatz gehören
 * iVZ_BEZEICHNUNG, String der der Vorlesungszeit entspricht
 */
CREATE PROCEDURE neue_mensch_vorleszeit_anlegen(
    iME_NR          INT,
    iVZ_BEZEICHNUNG VARCHAR(21)
  )
    DETERMINISTIC
BEGIN
    DECLARE v_vz_nr INT DEFAULT NULL;
    DECLARE v_mevz_nr INT DEFAULT NULL;
    
    -- Dubletten-Check für Vorlesungszeit;
    SELECT vz_nr
      INTO v_vz_nr
      FROM v0_vz_vorlesungszeit
     WHERE vz_bezeichnung = iVZ_BEZEICHNUNG;
    
    IF v_vz_nr IS NULL THEN
        INSERT INTO v0_vz_vorlesungszeit (vz_bezeichnung )
                                  VALUES (iVZ_BEZEICHNUNG);
        
        SELECT LAST_INSERT_ID()
          INTO v_vz_nr;
    END IF;
    
    -- Dubletten-Check;
    SELECT me_mevz_nr
      INTO v_mevz_nr
      FROM v0_mensch_vorleszeit_zuord
     WHERE vz_mevz_nr = v_vz_nr
       AND me_mevz_nr = iME_NR;
       
    IF v_mevz_nr IS NULL THEN
        INSERT INTO v0_mensch_vorleszeit_zuord (vz_mevz_nr, me_mevz_nr )
                                        VALUES (v_vz_nr   , iME_NR);
    END IF;
    
END;

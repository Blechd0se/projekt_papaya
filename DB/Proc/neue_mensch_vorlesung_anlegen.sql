DROP PROCEDURE neue_mensch_vorlesung_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 04.01.2015
 * Thema: Legt eine neue Mensch-Vorlesung-Zuordnung an und prüft dabei auf eventuell
 *        vorhandene Dubletten.
 * 
 * iME_NR, INT zu welchem Menschen soll der Datensatz gehören
 * iSU_BEZEICHNUNG, String der dem Studienfach der Vorlesung entspricht
 * iVO_BEZEICHNUNG, String der der Bezeichnung der Vorlesung entspricht
 */
CREATE PROCEDURE neue_mensch_vorlesung_anlegen(
    iME_NR          INT,
    iSU_BEZEICHNUNG VARCHAR(100),
    iVO_BEZEICHNUNG VARCHAR(500)
  )
    DETERMINISTIC
BEGIN
    DECLARE v_vo_nr INT DEFAULT NULL;
    DECLARE v_su_nr INT DEFAULT NULL;
    DECLARE v_mevo_nr INT DEFAULT NULL;
    
    -- Überprüfung ob Kopf (Studienfach) exisitiert;
    SELECT su_nr
      INTO v_su_nr
      FROM v0_su_studienfach
     WHERE su_bezeichnung = iSU_BEZEICHNUNG;
    
    IF v_su_nr IS NULL THEN
        SELECT neues_studienfach_anlegen(iSU_BEZEICHNUNG)
          INTO v_su_nr;
    END IF;
    
    -- Dubletten-Check;
    SELECT vo_nr
      INTO v_vo_nr
      FROM v0_vo_vorlesung
     WHERE vo_bezeichnung = iVO_BEZEICHNUNG
       AND su_vo_nr = v_su_nr;
       
    IF v_vo_nr IS NULL THEN
        INSERT INTO v0_vo_vorlesung (su_vo_nr, vo_bezeichnung )
                             VALUES (v_su_nr , iVO_BEZEICHNUNG);
        
        SELECT LAST_INSERT_ID()
          INTO v_vo_nr;
    END IF;

    -- Dubletten-Check in der Zuordnungstabelle;
    SELECT me_mevo_nr
      INTO v_mevo_nr
      FROM v0_mensch_vorlesung_zuord
     WHERE me_mevo_nr = iME_NR
       AND vo_mevo_nr = v_vo_nr;
       
    IF v_mevo_nr IS NULL THEN
        INSERT INTO v0_mensch_vorlesung_zuord (me_mevo_nr, vo_mevo_nr)
                                       VALUES ( iME_NR   , v_vo_nr   );
    END IF;
    

END;

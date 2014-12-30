DROP FUNCTION neuen_mensch_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 30.12.2014
 * Thema: Liefert bei erfolgreichem INSERT die ME_NR zurück. Bei Misserfolg
 *        wird NULL zurückgegeben. 
 * 
 * iME_ANREDE, String der der Anrede des Menschen entspricht
 * iME_TITEL, String der dem Titel des Menschen entspricht
 * iME_VORNAME, String der dem Vornamen des Menschen entspricht
 * iME_NACHNAME, String der dem Nachnamen des Menschen entspricht
 * iME_GORT, String der dem Geburtsort des Menschen entspricht
 * iME_GDATUM, Date das dem Datum (1900-12-31) des Menschen entspricht
 * iME_EHEMALIG, String welcher als Flag angibt, ob ehemalig oder nicht
 * iME_BERUF, String der den Beruf des Menschen entspricht
 * iRO_NR, INT welcher auf eine Rolle verweist
 * iFI_BEZEICHNUNG, String der der Firmen Bezeichnung entspricht
 * iMF_ABTEILUNG, String der der Abteilung des Menschen entspricht
 * iUS_NR, INT welcher User legt diesen Menschen (Status) an?
 */
CREATE FUNCTION neuen_mensch_anlegen(
    iME_ANREDE VARCHAR(4), 
    iME_TITEL VARCHAR(10),
    iME_VORNAME VARCHAR(200),
    iME_NACHNAME VARCHAR(200),
    iME_GORT VARCHAR(100),
    iME_GDATUM DATE,
    iME_EHEMALIG VARCHAR(1),
    iME_BERUF VARCHAR(500),
    iRO_NR INT,
    iFI_BEZEICHNUNG VARCHAR(500),
    iMF_ABTEILUNG VARCHAR(200),
    iUS_NR INT
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_ro_nr INT DEFAULT iRO_NR;
    DECLARE v_fi_nr INT DEFAULT NULL;
    DECLARE v_mf_nr INT DEFAULT NULL;
    DECLARE v_me_nr INT DEFAULT NULL;
    
    -- Setze auf Default, wenn NULL;
    IF v_ro_nr IS NULL THEN
        SELECT ro_nr
          INTO v_ro_nr
          FROM v0_ro_rolle
         WHERE ro_bezeichnung = 'Dozent';
    END IF;
    
    -- Dubletten-Check
    SELECT fi_nr
      INTO v_fi_nr
      FROM v0_fi_firma
     WHERE fi_bezeichnung = iFI_BEZEICHNUNG;
    
    -- Es gibt noch keine Firma, wir brauchen eine;
    IF v_fi_nr IS NULL THEN
        INSERT INTO v0_fi_firma (fi_bezeichnung )
                         VALUES (iFI_BEZEICHNUNG);
        SELECT LAST_INSERT_ID()
          INTO v_fi_nr;
    END IF;
    
    -- Dubletten-Check
    SELECT mf_nr
      INTO v_mf_nr
      FROM v0_mensch_firma_zuord
     WHERE mf_abteilung = iMF_ABTEILUNG
       AND fi_mf_nr = v_fi_nr;
    
    IF v_mf_nr IS NULL THEN
    -- Firmen-Zwischentabelle fuellen;
        INSERT INTO v0_mensch_firma_zuord (fi_mf_nr, mf_abteilung )
                                   VALUES (v_fi_nr , iMF_ABTEILUNG);
        SELECT LAST_INSERT_ID()
          INTO v_mf_nr;
    END IF;


    -- Trigger innerhalb des Status Logging ausschalten;
    SET @TRIGGER_DISABLED = 1;

    -- Zuerst brauchen wir unseren Menschen als Datensatz, falls er nicht bereits existiert;
    INSERT INTO v0_me_mensch (me_anrede, 
                              me_titel, 
                              me_vorname, 
                              me_nachname, 
                              me_gort, 
                              me_gdatum, 
                              me_ist_ehmalig_jn, 
                              ro_me_nr, 
                              mf_me_nr, 
                              me_beruf_bezeichnung)
                      VALUES (iME_ANREDE,
                              iME_TITEL,
                              iME_VORNAME,
                              iME_NACHNAME,
                              iME_GORT,
                              iME_GDATUM,
                              iME_EHEMALIG,
                              v_ro_nr,
                              v_mf_nr,
                              iME_BERUF); 
    -- Speichere unseren "Menschen" zwischen;                         
    SELECT LAST_INSERT_ID()
      INTO v_me_nr;
      
    -- Initialen Status setzen;   
    INSERT INTO v0_sl_status_logging (st_sl_nr, me_sl_nr  , us_sl_nr, sl_erstellt_von )
                              VALUES (    1   , v_me_nr   , iUS_NR  , CURRENT_USER()  );
    
    SET @TRIGGER_DISABLED = 0;
    
    RETURN v_me_nr;
    
END;

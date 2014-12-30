DROP PROCEDURE neuen_mensch_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei erfolgreichen Daten NULL zurück. Sollte es den
 *        User bereits geben, wird dessen us_nr zurückgegeben.
 * 
 * iUS_USERNAME, String der dem Usernamen entspricht
 * iUS_PASSWORD, String als md5 Hash der dem Passwort entspricht.
 * iUS_ERSTELLT_VON String der den ersteller des Datensatzes angibt
 */
CREATE PROCEDURE neuen_mensch_anlegen(
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
    iMF_ABTEILUNG VARCHAR(200)
  )
    DETERMINISTIC
BEGIN
    DECLARE v_ro_nr INT DEFAULT iRO_NR;
    DECLARE v_fi_nr INT DEFAULT NULL;
    DECLARE v_mf_nr INT DEFAULT NULL;
    
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
                              
    
END;

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
 * iME_ABSCHLUSS, String der dem Abschluss des Menschen entspricht
 * iME_GORT, String der dem Geburtsort des Menschen entspricht
 * iME_GDATUM, Date das dem Datum (1900-12-31) des Menschen entspricht
 * iME_EHEMALIG, String welcher als Flag angibt, ob ehemalig oder nicht
 * iME_BERUF, String der den Beruf des Menschen entspricht
 * iRO_NR, INT welcher auf eine Rolle verweist
 * iFI_BEZEICHNUNG, String der der Firmen Bezeichnung entspricht
 * iMF_ABTEILUNG, String der der Abteilung des Menschen entspricht
 * iUS_NR, INT welcher User legt diesen Menschen (Status) an
 * iAD_STRASSE_NR, String der der Straße (Wohnort) des Menschen entspricht
 * iAD_PLZ, String der der PLZ (Wohnort) des Menschen entspricht
 * iAD_ORT, String der dem Ort (Wohnort) des Menschen entspricht
 * iKO_TELEFON, String der der (Festnetz-)Telefonnumer des Menschen entspricht
 * iKO_MOBIL, String der der Mobiltelefonnummer des Menschen entspricht
 * iKO_EMAIL, String der der Email-Adresse des Menschen entspricht
 * iKO_WEBSEITE, String der der Webseite des Menschen entspricht
 * iKO_FAX, String der dem Fax-Anschluss des Menschen entspricht
 * iBA_BEZEICHNUNG, String der der Bezeichnung der Bank des Menschen entspricht
 * iBA_BLZ, String Bankleitzahl BLZ der Bank entspricht
 * iBA_BIC, String die BIC (Bank Identifier Code) der Bank entspricht
 * iMB_IBAN, (Optional) String der der IBAN des Menschen entspricht
 * iMB_KONTO_NR, (Optional) String der der Kontonummer des Menschen entspricht
 * iMB_LBV_NR, (Optional) String der der LBV Nummer des Menschen entspricht 
 * iSU_BEZEICHNUNG, String der der Bezeichnung des Studienfaches des Menschen entspricht
 * iPR_LEHRAUFTRAEGE, (Optional) String der den Lehraufträgen des Menschen(Dozenten) entspricht
 * iPR_PRAK_TAETIG, (Optional) String der praktischen Tätigkeit des Menschen (Dozenten) entspricht
 * iPR_WEITERE_INFOS, (Optional) String der weitere Informationen enthält
 * iPR_KOMMENTAR, (Optional) String der ein Kommentar des Menschen entspricht
 */
CREATE FUNCTION neuen_mensch_anlegen(
    iME_ANREDE      VARCHAR(4), 
    iME_TITEL       VARCHAR(10),
    iME_VORNAME     VARCHAR(200),
    iME_NACHNAME    VARCHAR(200),
    iME_ABSCHLUSS   VARCHAR(200),
    iME_GORT        VARCHAR(100),
    iME_GDATUM      DATE,
    iME_EHEMALIG    VARCHAR(1),
    iME_BERUF       VARCHAR(500),
    iRO_NR          INT,
    iFI_BEZEICHNUNG VARCHAR(500),
    iMF_ABTEILUNG   VARCHAR(200),
    iUS_NR          INT,
    iAD_STRASSE_NR  VARCHAR(500),
    iAD_PLZ         VARCHAR(5),
    iAD_ORT         VARCHAR(200),
    iKO_TELEFON     VARCHAR(20),
    iKO_MOBIL       VARCHAR(12),
    iKO_EMAIL       VARCHAR(250),
    iKO_WEBSEITE    VARCHAR(300),
    iKO_FAX         VARCHAR(20),
    iBA_BEZEICHNUNG VARCHAR(500),
    iBA_BLZ         INT(8),
    iBA_BIC         VARCHAR(11),
    iMB_IBAN        VARCHAR(34),
    iMB_KONTO_NR    VARCHAR(10),
    iMB_LBV_NR      VARCHAR(15),
    iSU_BEZEICHNUNG   VARCHAR(100),
    iPR_LEHRAUFTRAEGE VARCHAR(1000),
    iPR_PRAK_TAETIG   VARCHAR(1000),
    iPR_WEITERE_INFOS VARCHAR(4000),
    iPR_KOMMENTAR     VARCHAR(4000)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_ro_nr INT DEFAULT iRO_NR;
    DECLARE v_fi_nr INT DEFAULT NULL;
    DECLARE v_mf_nr INT DEFAULT NULL;
    DECLARE v_me_nr INT DEFAULT NULL;
    DECLARE v_admin INT DEFAULT 0;
    
    SELECT ist_admin_user(null, iUS_NR)
      INTO v_admin;
    
    IF v_admin <> 1 THEN
        -- Wir sind kein Admin;
        RETURN NULL;
    END IF;
    
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
                              me_abschluss,
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
                              iME_ABSCHLUSS,
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
    
    -- Personendaten zuordnen;
    CALL neue_personen_daten_anlegen(v_me_nr,
                                     iAD_STRASSE_NR,
                                     iAD_PLZ,
                                     iAD_ORT,
                                     iKO_TELEFON,
                                     iKO_MOBIL,
                                     iKO_EMAIL,
                                     iKO_WEBSEITE,
                                     iKO_FAX);
    
    -- Bankdaten zuordnen;
    CALL neue_bankdaten_anlegen(v_me_nr,
                                iBA_BEZEICHNUNG,
                                iBA_BLZ,
                                iBA_BIC,
                                iMB_IBAN,
                                iMB_KONTO_NR,
                                iMB_LBV_NR);
                                
    -- Präferenz zuordnen;
    CALL neue_praeferenz_anlegen(v_me_nr,
                                 iSU_BEZEICHNUNG,
                                 iPR_LEHRAUFTRAEGE,
                                 iPR_PRAK_TAETIG,
                                 iPR_WEITERE_INFOS,
                                 iPR_KOMMENTAR);
    
    RETURN v_me_nr;
    
END;

DROP PROCEDURE neue_personen_daten_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Legt einen neuen Kontakt/Adress Datensatz an, falls es noch keinen
 *        bekannten gibt.
 * 
 * iME_NR, INT zu welchem Menschen soll der Datensatz gehören
 * iAD_STRASSE_NR, String der der Straße (Wohnort) des Menschen entspricht
 * iAD_PLZ, String der der PLZ (Wohnort) des Menschen entspricht
 * iAD_ORT, String der dem Ort (Wohnort) des Menschen entspricht
 * iKO_TELEFON, String der der (Festnetz-)Telefonnumer des Menschen entspricht
 * iKO_MOBIL, String der der Mobiltelefonnummer des Menschen entspricht
 * iKO_EMAIL, String der der Email-Adresse des Menschen entspricht
 * iKO_WEBSEITE, String der der Webseite des Menschen entspricht
 * iKO_FAX, String der dem Fax-Anschluss des Menschen entspricht
 */
CREATE PROCEDURE neue_personen_daten_anlegen(
    iME_NR         INT,
    iAD_STRASSE_NR VARCHAR(500),
    iAD_PLZ        VARCHAR(5),
    iAD_ORT        VARCHAR(200),
    iKO_TELEFON    VARCHAR(20),
    iKO_MOBIL      VARCHAR(12),
    iKO_EMAIL      VARCHAR(250),
    iKO_WEBSEITE   VARCHAR(300),
    iKO_FAX        VARCHAR(20)
  )
    DETERMINISTIC
BEGIN
    DECLARE v_ko_nr INT DEFAULT NULL;
    DECLARE v_ad_nr INT DEFAULT NULL;
    DECLARE v_mp_nr INT DEFAULT NULL;
    
    -- Start mit Kontakte;
    SELECT ko_nr
      INTO v_ko_nr
      FROM v0_ko_kontakt
     WHERE ko_email = iKO_EMAIL;
     
     IF v_ko_nr IS NULL THEN
         INSERT INTO v0_ko_kontakt (ko_telefon  , ko_mobil  , ko_email  , ko_webseite  , ko_fax )
                             VALUES (iKO_TELEFON , iKO_MOBIL , iKO_EMAIL , iKO_WEBSEITE , iKO_FAX);
         
         SELECT LAST_INSERT_ID()
           INTO v_ko_nr;                   
     END IF;
    
    -- Nun Adresse;
    SELECT ad_nr
      INTO v_ad_nr
      FROM v0_ad_adresse
     WHERE ad_strasse_nr = iAD_STRASSE_NR
       AND ad_plz        = iAD_PLZ
       AND ad_ort        = iAD_ORT;
    
    IF v_ad_nr IS NULL THEN
        INSERT INTO v0_ad_adresse (ad_strasse_nr  , ad_plz  , ad_ort )
                           VALUES (iAD_STRASSE_NR , iAD_PLZ , iAD_ORT);
                           
        SELECT LAST_INSERT_ID()
          INTO v_ad_nr;
    END IF;
    
    -- Hat dieser Mensch schon eine gleiche Zuordnung?
    SELECT mp_nr
      INTO v_mp_nr
      FROM v0_mensch_persondaten_zuord
     WHERE ad_mp_nr = v_ad_nr
       AND ko_mp_nr = v_ko_nr
       AND me_mp_nr = iME_NR;
    
    IF v_mp_nr IS NULL THEN
        -- Nun die Mensch Zuordnung;
        INSERT INTO v0_mensch_persondaten_zuord (ad_mp_nr, ko_mp_nr, me_mp_nr)
                                         VALUES (v_ad_nr , v_ko_nr , iME_NR  );
    END IF;
END;

DROP PROCEDURE neue_bankdaten_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 04.01.2015
 * Thema: Legt eine neue Mensch-Bank-Zuordnung an und prüft dabei auf eventuell
 *        vorhandene Dubletten.
 * 
 * iME_NR, INT zu welchem Menschen soll der Datensatz gehören
 * iBA_BEZEICHNUNG, String der der Bezeichnung der Bank des Menschen entspricht
 * iBA_BLZ, String Bankleitzahl BLZ der Bank entspricht
 * iBA_BIC, String die BIC (Bank Identifier Code) der Bank entspricht
 * iMB_IBAN, (Optional) String der der IBAN des Menschen entspricht
 * iMB_KONTO_NR, (Optional) String der der Kontonummer des Menschen entspricht
 * iMB_LBV_NR, (Optional) String der der LBV Nummer des Menschen entspricht
 */
CREATE PROCEDURE neue_bankdaten_anlegen(
    iME_NR          INT,
    iBA_BEZEICHNUNG VARCHAR(500),
    iBA_BLZ         INT(8),
    iBA_BIC         VARCHAR(11),
    iMB_IBAN        VARCHAR(34),
    iMB_KONTO_NR    VARCHAR(10),
    iMB_LBV_NR      VARCHAR(15)
  )
    DETERMINISTIC
BEGIN
    DECLARE v_ba_nr INT DEFAULT NULL;
    DECLARE v_mb_nr INT DEFAULT NULL;
    
    -- Start mit den eigentlichen Bank-Daten;
    SELECT ba_nr
      INTO v_ba_nr
      FROM v0_ba_bank
     WHERE ba_bezeichnung = iBA_BEZEICHNUNG;

    IF v_ba_nr IS NULL THEN
        INSERT INTO v0_ba_bank (ba_bezeichnung  , ba_blz  , ba_bic )
                        VALUES (iBA_BEZEICHNUNG , iBA_BLZ , iBA_BIC);
        
        SELECT LAST_INSERT_ID()
          INTO v_ba_nr;
    END IF;

    -- Überprüfung auf Dublette;
    SELECT mb_nr
      INTO v_mb_nr
      FROM v0_mensch_bank_zuord
     WHERE IFNULL(mb_iban, 1) = IFNULL(iMB_IBAN, 1)
       AND IFNULL(mb_konto_nr, 1) = IFNULL(iMB_KONTO_NR, 1)
       AND IFNULL(mb_lbv_nr, 1) = IFNULL(iMB_LBV_NR, 1)
       AND me_mb_nr = iME_NR
       AND ba_mb_nr = v_ba_nr;

    IF v_mb_nr IS NULL THEN
        INSERT INTO v0_mensch_bank_zuord (me_mb_nr, ba_mb_nr, mb_iban  , mb_konto_nr  , mb_lbv_nr )
                                  VALUES ( iME_NR , v_ba_nr , iMB_IBAN , iMB_KONTO_NR , iMB_LBV_NR);
    END IF;

END;

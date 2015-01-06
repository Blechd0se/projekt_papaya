DROP PROCEDURE neue_praeferenz_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 06.01.2015
 * Thema: Legt eine neue Präferenz für einen Menschen an.
 * 
 * iME_NR, INT zu welchem Menschen soll der Datensatz gehören
 * iSU_BEZEICHNUNG, String der der Bezeichnung des Studienfaches des Menschen entspricht
 * iPR_LEHRAUFTRAEGE, (Optional) String der den Lehraufträgen des Menschen(Dozenten) entspricht
 * iPR_PRAK_TAETIG, (Optional) String der praktischen Tätigkeit des Menschen (Dozenten) entspricht
 * iPR_WEITERE_INFOS, (Optional) String der weitere Informationen enthält
 * iPR_KOMMENTAR, (Optional) String der ein Kommentar des Menschen entspricht
 */
CREATE PROCEDURE neue_praeferenz_anlegen(
    iME_NR            INT,
    iSU_BEZEICHNUNG   VARCHAR(100),
    iPR_LEHRAUFTRAEGE VARCHAR(1000),
    iPR_PRAK_TAETIG   VARCHAR(1000),
    iPR_WEITERE_INFOS VARCHAR(4000),
    iPR_KOMMENTAR     VARCHAR(4000)
  )
    DETERMINISTIC
BEGIN
    DECLARE v_pr_nr INT DEFAULT NULL;
    DECLARE v_su_nr INT DEFAULT NULL;
    
    -- Dubletten-Check beim Studienfach;
    SELECT neues_studienfach_anlegen(iSU_BEZEICHNUNG)
      INTO v_su_nr;

    -- Überprüfung auf Dublette(Präferenz);
    SELECT pr_nr
      INTO v_pr_nr
      FROM v0_pr_praeferenz
     WHERE IFNULL(pr_lehrauftraege, 1) = IFNULL(iPR_LEHRAUFTRAEGE, 1)
       AND IFNULL(pr_prak_taetig, 1) = IFNULL(iPR_PRAK_TAETIG, 1)
       AND IFNULL(pr_weitere_infos, 1) = IFNULL(iPR_WEITERE_INFOS, 1)
       AND IFNULL(pr_kommentar, 1) = IFNULL(iPR_KOMMENTAR, 1)
       AND me_pr_nr = iME_NR
       AND su_pr_nr = v_su_nr;

    IF v_pr_nr IS NULL THEN
        INSERT INTO v0_pr_praeferenz (me_pr_nr, su_pr_nr, pr_lehrauftraege  , pr_prak_taetig  , pr_weitere_infos  , pr_kommentar )
                              VALUES ( iME_NR , v_su_nr , iPR_LEHRAUFTRAEGE , iPR_PRAK_TAETIG , iPR_WEITERE_INFOS , iPR_KOMMENTAR);
    END IF;

END;

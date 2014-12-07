/**
 * Autor: Alexander Christ
 * Datum: 07.12.2014
 * Thema: Liefert die Zuordnung von Mensch zu Bankdaten zurück
 */
 
CREATE OR REPLACE VIEW v_mensch_bankdaten
 AS  
 SELECT me_nr,
        mb_iban,
        mb_konto_nr,
        mb_lbv_nr,
        ba_bezeichnung,
        ba_blz,
        ba_bic
   FROM v0_me_mensch,
        v0_mensch_bank_zuord,
        v0_ba_bank
  WHERE me_mb_nr = me_nr
    AND ba_mb_nr = ba_nr;

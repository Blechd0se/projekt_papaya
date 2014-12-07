/**
 * Autor: Alexander Christ
 * Datum: 29.11.2014
 * Thema: Liefert alle bekannten Daten fuer einen Menschen
 */
CREATE OR REPLACE VIEW v_mensch_daten
 AS  
 SELECT me_nr,
        us_username,
        me_anrede,
        me_titel,
        me_vorname,
        me_nachname,
        st_bezeichnung,
        me_ist_ehmalig_jn,
        me_beruf_bezeichnung,
        me_erstellt_von
   FROM v0_me_mensch,
        v0_us_user,
        v0_ro_rolle,
        v0_st_status,
        v0_sl_status_logging
  WHERE ro_me_nr = me_nr
    AND us_me_nr = me_nr
    AND st_sl_nr = st_nr
    AND me_sl_nr = me_nr;
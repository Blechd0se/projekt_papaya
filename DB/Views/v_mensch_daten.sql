/**
 * Autor: Alexander Christ
 * Datum: 29.11.2014
 * Thema: Liefert alle bekannten Daten für einen Menschen
 */
CREATE OR REPLACE VIEW v_mensch_daten
 AS  
 SELECT me_nr,
        us_username,
        us_password,
        me_anrede,
        me_titel,
        me_vorname,
        me_nachname,
        me_ist_ehmalig_jn,
        me_beruf_bezeichnung,
        me_erstellt_von,
        fi_bezeichnung,
        ro_intern_jn,
        ro_bezeichnung
   FROM v0_me_mensch,
        v0_us_user,
        v0_ro_rolle,
        v0_st_status,
        v0_mensch_firma_zuord,
        v0_fi_firma
  WHERE ro_me_nr = ro_nr
    AND st_me_nr = st_nr
    AND mf_me_nr = mf_nr
    AND fi_mf_nr = fi_nr;
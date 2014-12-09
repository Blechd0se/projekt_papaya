/**
 * Autor: Alexander Christ
 * Datum: 05.12.2014
 * Thema: Liefert die Statushistorie für Menschen zurück
 */
CREATE OR REPLACE VIEW v_mensch_status_historie
 AS  
 SELECT me_nr,
        st_nr,
        me_anrede,
        me_titel,
        me_vorname,
        me_nachname,
        st_bezeichnung,
        sl_erstellt_am,
        sl_erstellt_von
   FROM v0_me_mensch,
        v0_sl_status_logging,
        v0_st_status
  WHERE me_sl_nr = me_nr
    AND st_sl_nr = st_nr
  ORDER BY sl_erstellt_am DESC
  ;
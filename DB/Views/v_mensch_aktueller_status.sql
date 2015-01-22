/**
 * Autor: Alexander Christ
 * Datum: 09.12.2014
 * Thema: Liefert den letzten Status für einen Menschen zurück
 */
 
CREATE OR REPLACE VIEW v_mensch_aktueller_status
 AS 
 SELECT me_nr,
        st_nr,
        st_bezeichnung,
        sl_erstellt_von,
        sl_erstellt_am
   FROM v_mensch_status_historie
  ;
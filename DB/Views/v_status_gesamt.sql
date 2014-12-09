/**
 * Autor: Alexander Christ
 * Datum: 09.12.2014
 * Thema: Liefert alle Status zurück
 */
 
CREATE OR REPLACE VIEW v_status_gesamt
 AS 
 SELECT st_nr,
        st_bezeichnung
   FROM v0_st_status
  ORDER BY st_erstellt_am DESC;
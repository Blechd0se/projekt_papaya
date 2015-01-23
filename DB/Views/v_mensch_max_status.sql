/**
 * Autor: Alexander Christ
 * Datum: 23.01.2014
 * Thema: Liefert den maximalen Status für einen Menschen zurück
 */
 
CREATE OR REPLACE VIEW v_mensch_max_status
 AS 
SELECT max(sl_erstellt_am) date, st_bezeichnung
  FROM v_mensch_status_historie
 GROUP BY st_bezeichnung;
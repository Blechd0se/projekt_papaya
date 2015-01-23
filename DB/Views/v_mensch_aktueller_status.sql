/**
 * Autor: Alexander Christ
 * Datum: 09.12.2014
 * Thema: Liefert den letzten Status für einen Menschen zurück
 */
 
CREATE OR REPLACE VIEW v_mensch_aktueller_status
 AS 
SELECT t1.me_nr,
       t1.st_nr,
       t1.st_bezeichnung,
       t1.sl_erstellt_von,
       t1.sl_erstellt_am
  FROM v_mensch_status_historie t1
       INNER JOIN v_mensch_max_status t2 
       ON t1.sl_erstellt_am = t2.date
       AND t1.st_bezeichnung = t2.st_bezeichnung;
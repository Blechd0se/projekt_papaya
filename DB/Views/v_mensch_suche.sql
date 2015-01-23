/**
 * Autor: Alexander Christ
 * Datum: 09.12.2014
 * Thema: Liefert die Einträge für die Suchmaske zurück
 */
 
CREATE OR REPLACE VIEW v_mensch_suche
 AS 
 SELECT mensch.me_nr AS me_nr,
        vo_nr,
        mensch.me_vorname,
        mensch.me_nachname,
        CONCAT(mensch.me_vorname, CONCAT(' ', mensch.me_nachname)) AS mensch_name,
        vo_bezeichnung,
        historie.st_bezeichnung,
        historie.sl_erstellt_von,
        historie.sl_erstellt_am
   FROM v0_me_mensch mensch,
        v_mensch_aktueller_status historie,
        v_mensch_aktueller_status historie_vgl,
        v_vorlesung_studienfach,
        v0_mensch_vorlesung_zuord
  WHERE mensch.me_nr = historie.me_nr
    AND mensch.me_nr = me_mevo_nr
    AND vo_mevo_nr = vo_nr
    AND historie.me_nr = historie_vgl.me_nr
    AND historie.sl_erstellt_am > historie_vgl.sl_erstellt_am;
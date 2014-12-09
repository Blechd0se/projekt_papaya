/**
 * Autor: Alexander Christ
 * Datum: 09.12.2014
 * Thema: Liefert die Einträge für die Suchmaske zurück
 */
 
CREATE OR REPLACE VIEW v_mensch_suche
 AS 
 SELECT mensch.me_nr,
        vo_nr,
        mensch.me_vorname,
        mensch.me_nachname,
        CONCAT(mensch.me_vorname, CONCAT(' ', mensch.me_nachname)) AS mensch_name,
        vo_bezeichnung,
        st_bezeichnung,
        sl_erstellt_von,
        sl_erstellt_am
   FROM v0_me_mensch mensch,
        v_mensch_aktueller_status historie,
        v_vorlesung_studienfach,
        v0_mensch_vorlesung_zuord
  WHERE mensch.me_nr = historie.me_nr
    AND mensch.me_nr = me_mevo_nr
    AND vo_mevo_nr = vo_nr;
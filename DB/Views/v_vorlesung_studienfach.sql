/**
 * Autor: Alexander Christ
 * Datum: 07.12.2014
 * Thema: Liefert die Zuordnung von Studienfach zu Vorlesung zurück
 */
 
CREATE OR REPLACE VIEW v_vorlesung_studienfach
 AS  
 SELECT vo_nr,
        su_nr,
        vo_bezeichnung,
        vo_erstellt_von,
        vo_erstellt_am,
        su_bezeichnung
   FROM v0_vo_vorlesung,
        v0_su_studienfach
  WHERE su_vo_nr = su_nr;
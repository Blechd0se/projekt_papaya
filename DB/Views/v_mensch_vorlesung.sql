/**
 * Autor: Alexander Christ
 * Datum: 07.01.2015
 * Thema: Liefert alle bekannten Vorlesungen für einen Menschen.
 */
CREATE OR REPLACE VIEW v_mensch_vorlesung
 AS  
 SELECT me_nr,
        vo_bezeichnung
   FROM v0_me_mensch,
        v0_mensch_vorlesung_zuord,
        v0_vo_vorlesung
  WHERE vo_mevo_nr = vo_nr
    AND me_mevo_nr = me_nr;
/**
 * Autor: Alexander Christ
 * Datum: 07.01.2015
 * Thema: Liefert alle bekannten Vorlesungen f�r einen Menschen.
 */
CREATE OR REPLACE VIEW v_mensch_vorlesung
 AS  
 SELECT me_nr,
        vo_bezeichnung,
        su_bezeichnung
   FROM v0_me_mensch,
        v0_mensch_vorlesung_zuord,
        v0_vo_vorlesung,
        v0_su_studienfach
  WHERE vo_mevo_nr = vo_nr
    AND me_mevo_nr = me_nr
    AND su_vo_nr = su_nr
  GROUP BY su_bezeichnung;
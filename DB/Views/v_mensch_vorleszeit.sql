/**
 * Autor: Alexander Christ
 * Datum: 07.01.2015
 * Thema: Liefert alle bekannten Vorlesungszeiten für einen Menschen.
 */
CREATE OR REPLACE VIEW v_mensch_vorleszeit
 AS  
 SELECT me_nr,
        vz_bezeichnung
   FROM v0_me_mensch,
        v0_mensch_vorleszeit_zuord,
        v0_vz_vorlesungszeit
  WHERE me_nr = me_mevz_nr
    AND vz_nr = vz_mevz_nr;
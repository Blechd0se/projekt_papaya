/**
 * Autor: Alexander Christ
 * Datum: 07.01.2015
 * Thema: Liefert alle Pr�ferenz-Zuordnung f�r einen Menschen mit dem
 *        bevorzugten Studienfach.
 */
CREATE OR REPLACE VIEW v_mensch_praeferenz
 AS  
SELECT pr_nr, 
       me_pr_nr AS me_nr,
       pr_lehrauftraege,
       pr_weitere_infos,
       su_bezeichnung AS su_bevorzugt,
       pr_kommentar
  FROM v0_pr_praeferenz,
       v0_su_studienfach
 WHERE su_pr_nr = su_nr;
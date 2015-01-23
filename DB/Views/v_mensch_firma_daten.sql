/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert alle bekannten Daten fuer die Firma eines Menschen
 */
CREATE OR REPLACE VIEW v_mensch_firma_daten
 AS  
SELECT me_nr,
       ad_nr,
       ko_nr,
       mf_nr,
       fi_mf_nr,
       mf_abteilung,
       fi_bezeichnung,
       ko_telefon,
       ko_mobil,
       ko_email,
       ko_webseite,
       ko_fax,
       ad_strasse_nr,
       ad_plz,
       ad_ort
  FROM v0_me_mensch
       JOIN v0_mensch_firma_zuord    ON (mf_me_nr = mf_nr)
       JOIN v0_fi_firma              ON (fi_mf_nr = fi_nr)
       LEFT OUTER JOIN v0_ad_adresse ON (ad_fi_nr = ad_nr)
       LEFT OUTER JOIN v0_ko_kontakt ON (ko_fi_nr = ko_nr)
   ;
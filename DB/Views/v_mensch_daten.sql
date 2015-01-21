/**
 * Autor: Alexander Christ
 * Datum: 29.11.2014
 * Thema: Liefert alle bekannten Daten fuer einen Menschen
 */
CREATE OR REPLACE VIEW v_mensch_daten
 AS  
 SELECT me.me_nr AS me_nr,
        me_anrede,
        me_titel,
        me_vorname,
        me_nachname,
        st.st_bezeichnung,
        me_gort,
        me_gdatum,
        me_ist_ehmalig_jn,
        me_beruf_bezeichnung,
        ad_strasse_nr,
        ad_plz,
        ad_ort,
        ko_telefon,
        ko_mobil,
        ko_email,
        ko_webseite,
        ko_fax,
        me_erstellt_von
   FROM v0_me_mensch me,
        v0_ro_rolle,
        v0_mensch_persondaten_zuord,
        v0_ad_adresse,
        v0_ko_kontakt,
        v_mensch_aktueller_status st
  WHERE ro_me_nr = ro_nr
    AND st.me_nr = me.me_nr
    AND me_mp_nr = me.me_nr
    AND ad_mp_nr = ad_nr
    AND ko_mp_nr = ko_nr;  
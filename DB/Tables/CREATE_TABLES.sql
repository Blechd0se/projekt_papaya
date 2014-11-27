-- Generiert von Oracle SQL Developer Data Modeler 4.0.3.853
--   am/um:        2014-11-28 00:18:44 MEZ
--   Site:      Oracle Database 11g
--   Typ:      Oracle Database 11g




DROP TABLE ad_adresse CASCADE CONSTRAINTS ;

DROP TABLE ba_bank CASCADE CONSTRAINTS ;

DROP TABLE fi_firma CASCADE CONSTRAINTS ;

DROP TABLE ko_kontakt CASCADE CONSTRAINTS ;

DROP TABLE me_mensch CASCADE CONSTRAINTS ;

DROP TABLE mensch_bank_zuord CASCADE CONSTRAINTS ;

DROP TABLE mensch_firma_zuord CASCADE CONSTRAINTS ;

DROP TABLE mensch_persondaten_zuord CASCADE CONSTRAINTS ;

DROP TABLE mensch_sprache_zuord CASCADE CONSTRAINTS ;

DROP TABLE mensch_vorlesung_zuord CASCADE CONSTRAINTS ;

DROP TABLE pr_praeferenz CASCADE CONSTRAINTS ;

DROP TABLE praeferenz_vorlesung_zuord CASCADE CONSTRAINTS ;

DROP TABLE praeferenz_vorleszeit_zuord CASCADE CONSTRAINTS ;

DROP TABLE ro_rolle CASCADE CONSTRAINTS ;

DROP TABLE sl_status_logging CASCADE CONSTRAINTS ;

DROP TABLE sp_sprache CASCADE CONSTRAINTS ;

DROP TABLE st_status CASCADE CONSTRAINTS ;

DROP TABLE su_studienfach CASCADE CONSTRAINTS ;

DROP TABLE us_user CASCADE CONSTRAINTS ;

DROP TABLE vo_vorlesung CASCADE CONSTRAINTS ;

DROP TABLE vz_vorlesungszeit CASCADE CONSTRAINTS ;

CREATE TABLE ad_adresse
  (
    ad_nr           NUMBER NOT NULL ,
    ad_strasse_nr   VARCHAR2 (500 CHAR) NOT NULL ,
    ad_plz          VARCHAR2 (5 CHAR) NOT NULL ,
    ad_ort          VARCHAR2 (200 CHAR) NOT NULL ,
    ad_erstellt_von VARCHAR2 (200 CHAR) NOT NULL ,
    ad_kommentar    VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE ad_adresse ADD CONSTRAINT ad_adresse_PK PRIMARY KEY ( ad_nr ) ;

CREATE TABLE ba_bank
  (
    ba_nr           NUMBER NOT NULL ,
    ba_bezeichnung  VARCHAR2 (500 CHAR) NOT NULL ,
    ba_blz          NUMBER (8) NOT NULL ,
    ba_bic          VARCHAR2 (11 CHAR) NOT NULL ,
    ba_erstellt_von VARCHAR2 (200 CHAR) ,
    ba_kommentar    VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE ba_bank ADD CONSTRAINT ba_bank_PK PRIMARY KEY ( ba_nr ) ;

CREATE TABLE fi_firma
  (
    fi_nr          NUMBER NOT NULL ,
    fi_bezeichnung VARCHAR2 (500 CHAR) NOT NULL ,
    fi_kommentar   VARCHAR2 (4000 CHAR) ,
    ad_fi_nr       NUMBER ,
    ko_fi_nr       NUMBER
  ) ;
ALTER TABLE fi_firma ADD CONSTRAINT fi_firma_PK PRIMARY KEY ( fi_nr ) ;

CREATE TABLE ko_kontakt
  (
    ko_nr           NUMBER NOT NULL ,
    ko_telefon      VARCHAR2 (20 CHAR) ,
    ko_mobil        VARCHAR2 (12 CHAR) ,
    ko_email        VARCHAR2 (250 CHAR) NOT NULL ,
    ko_webseite     VARCHAR2 (300 CHAR) ,
    ko_fax          VARCHAR2 (20 CHAR) ,
    ko_erstellt_von VARCHAR2 (200 CHAR) NOT NULL ,
    ko_kommentar    VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE ko_kontakt ADD CONSTRAINT ko_kontakt_PK PRIMARY KEY ( ko_nr ) ;

CREATE TABLE me_mensch
  (
    me_nr                NUMBER NOT NULL ,
    me_anrede            VARCHAR2 (4 CHAR) NOT NULL ,
    me_titel             VARCHAR2 (10 CHAR) NOT NULL ,
    me_vorname           VARCHAR2 (200 CHAR) NOT NULL ,
    me_nachname          VARCHAR2 (200 CHAR) NOT NULL ,
    me_abschluss         VARCHAR2 (200 CHAR) ,
    me_gort              VARCHAR2 (100 CHAR) NOT NULL ,
    me_gdatum            DATE NOT NULL ,
    me_ist_ehmalig_jn    VARCHAR2 (1 CHAR) NOT NULL ,
    ro_me_nr             NUMBER NOT NULL ,
    st_me_nr             NUMBER NOT NULL ,
    mf_me_nr             NUMBER NOT NULL ,
    me_beruf_bezeichnung VARCHAR2 (500 CHAR) NOT NULL ,
    me_erstellt_von      VARCHAR2 (200 CHAR) NOT NULL ,
    me_erstellt_am       DATE DEFAULT SYSDATE NOT NULL ,
    me_geaendert_von     VARCHAR2 (200 CHAR) ,
    me_geandert_am       DATE ,
    me_kommentar         VARCHAR2 (4000 CHAR)
  ) ;
COMMENT ON COLUMN me_mensch.ro_me_nr
IS
  'Definiert, welche der Rolle der Dozent einnimmt (extern/intern).' ;
  ALTER TABLE me_mensch ADD CONSTRAINT Me_Mensch_PK PRIMARY KEY ( me_nr ) ;

CREATE TABLE mensch_bank_zuord
  (
    mb_nr        NUMBER NOT NULL ,
    me_mb_nr     NUMBER NOT NULL ,
    ba_mb_nr     NUMBER NOT NULL ,
    mb_iban      VARCHAR2 (34 CHAR) ,
    mb_konto_nr  VARCHAR2 (10 CHAR) ,
    mb_lbv_nr    VARCHAR2 (15 CHAR) ,
    mb_kommentar VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE mensch_bank_zuord ADD CONSTRAINT mensch_bank_zuord_PK PRIMARY KEY ( mb_nr ) ;

CREATE TABLE mensch_firma_zuord
  (
    mf_nr        NUMBER NOT NULL ,
    fi_mf_nr     NUMBER NOT NULL ,
    mf_abteilung VARCHAR2 (200 CHAR) ,
    mf_kommentar VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE mensch_firma_zuord ADD CONSTRAINT mensch_firma_zuord_PK PRIMARY KEY ( mf_nr ) ;

CREATE TABLE mensch_persondaten_zuord
  (
    mp_nr    NUMBER NOT NULL ,
    ad_mp_nr NUMBER NOT NULL ,
    ko_mp_nr NUMBER NOT NULL ,
    me_mp_nr NUMBER NOT NULL
  ) ;
ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_PK PRIMARY KEY ( mp_nr ) ;

CREATE TABLE mensch_sprache_zuord
  (
    me_mesp_nr NUMBER NOT NULL ,
    sp_mesp_nr NUMBER NOT NULL
  ) ;
ALTER TABLE mensch_sprache_zuord ADD CONSTRAINT mensch_sprache_zuord_PK PRIMARY KEY ( me_mesp_nr, sp_mesp_nr ) ;

CREATE TABLE mensch_vorlesung_zuord
  (
    me_mevo_nr NUMBER NOT NULL ,
    vo_mevo_nr NUMBER NOT NULL
  ) ;
ALTER TABLE mensch_vorlesung_zuord ADD CONSTRAINT Mensch_Vorlesung_Zuord_PK PRIMARY KEY ( me_mevo_nr, vo_mevo_nr ) ;

CREATE TABLE pr_praeferenz
  (
    pr_nr                        NUMBER NOT NULL ,
    me_pr_nr                     NUMBER NOT NULL ,
    su_pr_nr                     NUMBER NOT NULL ,
    pr_lehrauftraege             VARCHAR2 (1000 CHAR) ,
    pr_prak_taetig               VARCHAR2 (1000 CHAR) ,
    pr_weitere_infos             VARCHAR2 (4000 CHAR) ,
    pr_branche_vertief           VARCHAR2 (200 CHAR) ,
    pr_branche_vertief_bank      VARCHAR2 (200 CHAR) ,
    pr_branche_vertief_versicher VARCHAR2 (200 CHAR) ,
    pr_kommentar                 VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE pr_praeferenz ADD CONSTRAINT pr_praeferenz_PK PRIMARY KEY ( pr_nr ) ;

CREATE TABLE praeferenz_vorlesung_zuord
  (
    pr_prvo_nr NUMBER NOT NULL ,
    vo_prvo_nr NUMBER NOT NULL
  ) ;
ALTER TABLE praeferenz_vorlesung_zuord ADD CONSTRAINT praeferenz_vorlesung_zuord_PK PRIMARY KEY ( pr_prvo_nr, vo_prvo_nr ) ;

CREATE TABLE praeferenz_vorleszeit_zuord
  (
    vz_prvz_nr NUMBER NOT NULL ,
    pr_prvz_nr NUMBER NOT NULL
  ) ;
ALTER TABLE praeferenz_vorleszeit_zuord ADD CONSTRAINT praeferenz_vorleszeit_zuord_PK PRIMARY KEY ( pr_prvz_nr, vz_prvz_nr ) ;

CREATE TABLE ro_rolle
  (
    ro_nr            NUMBER NOT NULL ,
    ro_intern_jn     VARCHAR2 (1 CHAR) NOT NULL ,
    ro_bezeichnung   VARCHAR2 (200 CHAR) NOT NULL ,
    ro_erstellt_von  VARCHAR2 (400 CHAR) NOT NULL ,
    ro_erstellt_am   DATE DEFAULT SYSDATE NOT NULL ,
    ro_geaendert_von VARCHAR2 (400 CHAR) ,
    ro_geaendert_am  DATE ,
    ro_kommentar     VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE ro_rolle ADD CONSTRAINT Ro_Rolle_PK PRIMARY KEY ( ro_nr ) ;

CREATE TABLE sl_status_logging
  (
    sl_nr               NUMBER NOT NULL ,
    st_sl_nr            NUMBER NOT NULL ,
    sl_erstellt_von     VARCHAR2 (200 CHAR) NOT NULL ,
    sl_erstellt_am      DATE NOT NULL ,
    sl_sl_vorgaenger_nr NUMBER ,
    me_sl_nr            NUMBER NOT NULL ,
    us_sl_nr            NUMBER NOT NULL ,
    sl_kommentar        VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_PK PRIMARY KEY ( sl_nr ) ;

CREATE TABLE sp_sprache
  (
    sp_nr           NUMBER NOT NULL ,
    sp_bezeichnung  VARCHAR2 (200 CHAR) NOT NULL ,
    sp_kommentar    VARCHAR2 (4000 CHAR) ,
    sp_erstellt_von VARCHAR2 (200 CHAR) NOT NULL
  ) ;
ALTER TABLE sp_sprache ADD CONSTRAINT sp_sprache_PK PRIMARY KEY ( sp_nr ) ;

CREATE TABLE st_status
  (
    st_nr            NUMBER NOT NULL ,
    st_bezeichnung   VARCHAR2 (200 CHAR) NOT NULL ,
    st_erstellt_von  VARCHAR2 (200 CHAR) NOT NULL ,
    st_erstellt_am   DATE NOT NULL ,
    st_geaendert_von VARCHAR2 (200 CHAR) ,
    st_geaendert_am  DATE ,
    st_kommentar     VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE st_status ADD CONSTRAINT Status_PK PRIMARY KEY ( st_nr ) ;

CREATE TABLE su_studienfach
  (
    su_nr           NUMBER NOT NULL ,
    su_bezeichnung  VARCHAR2 (100 CHAR) NOT NULL ,
    su_erstellt_von VARCHAR2 (200 CHAR) NOT NULL ,
    su_kommentar    VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE su_studienfach ADD CONSTRAINT ka_kategorie_PK PRIMARY KEY ( su_nr ) ;

CREATE TABLE us_user
  (
    us_nr            NUMBER NOT NULL ,
    us_username      VARCHAR2 (200 CHAR) NOT NULL ,
    us_password      VARCHAR2 (200 CHAR) NOT NULL ,
    us_me_nr         NUMBER ,
    us_erstellt_von  VARCHAR2 (200 CHAR) NOT NULL ,
    us_erstellt_am   DATE DEFAULT SYSDATE NOT NULL ,
    us_geaendert_von VARCHAR2 (200 CHAR) ,
    us_geaendert_am  DATE ,
    us_kommentar     VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE us_user ADD CONSTRAINT Us_User_PK PRIMARY KEY ( us_nr ) ;
ALTER TABLE us_user ADD CONSTRAINT us_username_UN UNIQUE ( us_username ) ;

CREATE TABLE vo_vorlesung
  (
    vo_nr           NUMBER NOT NULL ,
    vo_bezeichnung  VARCHAR2 (500 CHAR) NOT NULL ,
    vo_erstellt_von VARCHAR2 (200 CHAR) NOT NULL ,
    vo_erstellt_am  DATE DEFAULT SYSDATE NOT NULL ,
    vo_geandert_von VARCHAR2 (200 CHAR) ,
    vo_geaendert_am DATE ,
    vo_kommentar    VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE vo_vorlesung ADD CONSTRAINT Vo_Vorlesung_PK PRIMARY KEY ( vo_nr ) ;

CREATE TABLE vz_vorlesungszeit
  (
    vz_nr           NUMBER NOT NULL ,
    vz_bezeichnung  VARCHAR2 (21 CHAR) NOT NULL ,
    vz_erstellt_von VARCHAR2 (200 CHAR) NOT NULL ,
    vz_kommentar    VARCHAR2 (4000 CHAR)
  ) ;
ALTER TABLE vz_vorlesungszeit ADD CONSTRAINT vz_vorlesungszeit_PK PRIMARY KEY ( vz_nr ) ;

ALTER TABLE me_mensch ADD CONSTRAINT Me_Mensch_Ro_Rolle_FK FOREIGN KEY ( ro_me_nr ) REFERENCES ro_rolle ( ro_nr ) ;

ALTER TABLE me_mensch ADD CONSTRAINT Me_Mensch_St_Status_FK FOREIGN KEY ( st_me_nr ) REFERENCES st_status ( st_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_vorlesung_zuord ADD CONSTRAINT Mensch_Vorlesung_Zuord_Me_Mensch_FK FOREIGN KEY ( me_mevo_nr ) REFERENCES me_mensch ( me_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_vorlesung_zuord ADD CONSTRAINT Mensch_Vorlesung_Zuord_Vo_Vorlesung_FK FOREIGN KEY ( vo_mevo_nr ) REFERENCES vo_vorlesung ( vo_nr ) ;

ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_Me_Mensch_FK FOREIGN KEY ( me_sl_nr ) REFERENCES me_mensch ( me_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_Sl_Status_Logging_FK FOREIGN KEY ( sl_sl_vorgaenger_nr ) REFERENCES sl_status_logging ( sl_nr ) ;

ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_St_Status_FK FOREIGN KEY ( st_sl_nr ) REFERENCES st_status ( st_nr ) ;

ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_Us_User_FK FOREIGN KEY ( us_sl_nr ) REFERENCES us_user ( us_nr ) ;

ALTER TABLE us_user ADD CONSTRAINT Us_User_Me_Mensch_FK FOREIGN KEY ( us_me_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE fi_firma ADD CONSTRAINT fi_firma_ad_adresse_FK FOREIGN KEY ( ad_fi_nr ) REFERENCES ad_adresse ( ad_nr ) ;

ALTER TABLE fi_firma ADD CONSTRAINT fi_firma_ko_kontakt_FK FOREIGN KEY ( ko_fi_nr ) REFERENCES ko_kontakt ( ko_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE me_mensch ADD CONSTRAINT me_mensch_mensch_firma_zuord_FK FOREIGN KEY ( mf_me_nr ) REFERENCES mensch_firma_zuord ( mf_nr ) ;

ALTER TABLE mensch_bank_zuord ADD CONSTRAINT mensch_bank_zuord_ba_bank_FK FOREIGN KEY ( ba_mb_nr ) REFERENCES ba_bank ( ba_nr ) ;

ALTER TABLE mensch_bank_zuord ADD CONSTRAINT mensch_bank_zuord_me_mensch_FK FOREIGN KEY ( me_mb_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE mensch_firma_zuord ADD CONSTRAINT mensch_firma_zuord_fi_firma_FK FOREIGN KEY ( fi_mf_nr ) REFERENCES fi_firma ( fi_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_ad_adresse_FK FOREIGN KEY ( ad_mp_nr ) REFERENCES ad_adresse ( ad_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_ko_kontakt_FK FOREIGN KEY ( ko_mp_nr ) REFERENCES ko_kontakt ( ko_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_me_mensch_FK FOREIGN KEY ( me_mp_nr ) REFERENCES me_mensch ( me_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_sprache_zuord ADD CONSTRAINT mensch_sprache_zuord_me_mensch_FK FOREIGN KEY ( me_mesp_nr ) REFERENCES me_mensch ( me_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE mensch_sprache_zuord ADD CONSTRAINT mensch_sprache_zuord_sp_sprache_FK FOREIGN KEY ( sp_mesp_nr ) REFERENCES sp_sprache ( sp_nr ) ;

ALTER TABLE pr_praeferenz ADD CONSTRAINT pr_praeferenz_me_mensch_FK FOREIGN KEY ( me_pr_nr ) REFERENCES me_mensch ( me_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE pr_praeferenz ADD CONSTRAINT pr_praeferenz_su_studienfach_FK FOREIGN KEY ( su_pr_nr ) REFERENCES su_studienfach ( su_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE praeferenz_vorlesung_zuord ADD CONSTRAINT praeferenz_vorlesung_zuord_pr_praeferenz_FK FOREIGN KEY ( pr_prvo_nr ) REFERENCES pr_praeferenz ( pr_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE praeferenz_vorlesung_zuord ADD CONSTRAINT praeferenz_vorlesung_zuord_vo_vorlesung_FK FOREIGN KEY ( vo_prvo_nr ) REFERENCES vo_vorlesung ( vo_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE praeferenz_vorleszeit_zuord ADD CONSTRAINT praeferenz_vorleszeit_zuord_pr_praeferenz_FK FOREIGN KEY ( pr_prvz_nr ) REFERENCES pr_praeferenz ( pr_nr ) ;

--  ERROR: FK name length exceeds maximum allowed length(30)
ALTER TABLE praeferenz_vorleszeit_zuord ADD CONSTRAINT praeferenz_vorleszeit_zuord_vz_vorlesungszeit_FK FOREIGN KEY ( vz_prvz_nr ) REFERENCES vz_vorlesungszeit ( vz_nr ) ;


-- Zusammenfassungsbericht für Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            21
-- CREATE INDEX                             0
-- ALTER TABLE                             48
-- CREATE VIEW                              0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ERRORS                                  14
-- WARNINGS                                 0


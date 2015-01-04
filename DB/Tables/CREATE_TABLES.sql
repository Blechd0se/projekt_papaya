/**
 * Autor: Alexander Christ
 * Datum: 03.12.2014
 * Thema: Initiales DB-Tabellen Script
 */
 
DROP TABLE ad_adresse CASCADE;

DROP TABLE ba_bank CASCADE;

DROP TABLE bo_branchenorientierung CASCADE;

DROP TABLE br_branche CASCADE;

DROP TABLE brancheorientier_mensch_zuord CASCADE;

DROP TABLE fi_firma CASCADE ;

DROP TABLE ko_kontakt CASCADE;

DROP TABLE me_mensch CASCADE;

DROP TABLE mensch_bank_zuord CASCADE;

DROP TABLE mensch_firma_zuord CASCADE;

DROP TABLE mensch_persondaten_zuord CASCADE;

DROP TABLE mensch_vorlesung_zuord CASCADE ;

DROP TABLE pr_praeferenz CASCADE;

DROP TABLE praeferenz_vorlesung_zuord CASCADE;

DROP TABLE praeferenz_vorleszeit_zuord CASCADE ;

DROP TABLE ro_rolle CASCADE;

DROP TABLE sl_status_logging CASCADE;

DROP TABLE st_status CASCADE;

DROP TABLE su_studienfach CASCADE;

DROP TABLE us_user CASCADE;

DROP TABLE vo_vorlesung CASCADE;

DROP TABLE vz_vorlesungszeit CASCADE;

CREATE TABLE ad_adresse
  (
    ad_nr           INT NOT NULL ,
    ad_strasse_nr   VARCHAR (500) NOT NULL ,
    ad_plz          VARCHAR (5)   NOT NULL ,
    ad_ort          VARCHAR (200) NOT NULL ,
    ad_erstellt_von VARCHAR (200) DEFAULT NULL ,
    ad_kommentar    VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE ad_adresse ADD CONSTRAINT ad_adresse_PK PRIMARY KEY ( ad_nr ) ;
ALTER TABLE ad_adresse CHANGE ad_nr ad_nr INT AUTO_INCREMENT;

CREATE TABLE ba_bank
  (
    ba_nr           INT           NOT NULL ,
    ba_bezeichnung  VARCHAR (500) NOT NULL ,
    ba_blz          INT (8)       NOT NULL ,
    ba_bic          VARCHAR (11)  NOT NULL ,
    ba_erstellt_von VARCHAR (200) ,
    ba_kommentar    VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE ba_bank ADD CONSTRAINT ba_bank_PK PRIMARY KEY ( ba_nr ) ;
ALTER TABLE ba_bank ADD CONSTRAINT ba_bezeichnung_UN UNIQUE ( ba_bezeichnung ) ;
ALTER TABLE ba_bank CHANGE ba_nr ba_nr INT AUTO_INCREMENT;

CREATE TABLE fi_firma
  (
    fi_nr          INT            NOT NULL ,
    fi_bezeichnung VARCHAR (500)  NOT NULL ,
    fi_kommentar   VARCHAR (4000) DEFAULT NULL,
    ad_fi_nr       INT ,
    ko_fi_nr       INT
  ) ;
ALTER TABLE fi_firma ADD CONSTRAINT fi_firma_PK PRIMARY KEY ( fi_nr ) ;
ALTER TABLE fi_firma ADD CONSTRAINT fi_bezeichnung_UN UNIQUE ( fi_bezeichnung ) ;
ALTER TABLE fi_firma CHANGE fi_nr fi_nr INT AUTO_INCREMENT;

CREATE TABLE ko_kontakt
  (
    ko_nr           INT NOT NULL ,
    ko_telefon      VARCHAR (20) ,
    ko_mobil        VARCHAR (12) ,
    ko_email        VARCHAR (250)  NOT NULL ,
    ko_webseite     VARCHAR (300),
    ko_fax          VARCHAR (20) ,
    ko_erstellt_von VARCHAR (200)  DEFAULT NULL ,
    ko_kommentar    VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE ko_kontakt ADD CONSTRAINT ko_kontakt_PK PRIMARY KEY ( ko_nr ) ;
ALTER TABLE ko_kontakt ADD CONSTRAINT ko_email_UN UNIQUE ( ko_email ) ;
ALTER TABLE ko_kontakt CHANGE ko_nr ko_nr INT AUTO_INCREMENT;

CREATE TABLE me_mensch
  (
    me_nr                INT           NOT NULL ,
    ro_me_nr             INT           NOT NULL ,
    mf_me_nr             INT           NOT NULL ,
    me_anrede            VARCHAR (4)   NOT NULL ,
    me_titel             VARCHAR (10)  NOT NULL ,
    me_vorname           VARCHAR (200) NOT NULL ,
    me_nachname          VARCHAR (200) NOT NULL ,
    me_abschluss         VARCHAR (200) ,
    me_gort              VARCHAR (100) NOT NULL ,
    me_gdatum            DATE          NOT NULL ,
    me_ist_ehmalig_jn    VARCHAR (1)   NOT NULL ,
    me_beruf_bezeichnung VARCHAR (500) NOT NULL ,
    me_erstellt_von      VARCHAR (200) DEFAULT NULL ,
    me_erstellt_am       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    me_geaendert_von     VARCHAR (200) ,
    me_geandert_am       DATE ,
    me_kommentar         VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE me_mensch ADD CONSTRAINT Me_Mensch_PK PRIMARY KEY ( me_nr ) ;
ALTER TABLE me_mensch CHANGE me_nr me_nr INT AUTO_INCREMENT;

CREATE TABLE mensch_bank_zuord
  (
    mb_nr        INT NOT NULL ,
    me_mb_nr     INT NOT NULL ,
    ba_mb_nr     INT NOT NULL ,
    mb_iban      VARCHAR (34) ,
    mb_konto_nr  VARCHAR (10) ,
    mb_lbv_nr    VARCHAR (15) ,
    mb_kommentar VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE mensch_bank_zuord ADD CONSTRAINT mensch_bank_zuord_PK PRIMARY KEY ( mb_nr ) ;
ALTER TABLE mensch_bank_zuord CHANGE mb_nr mb_nr INT AUTO_INCREMENT;

CREATE TABLE mensch_firma_zuord
  (
    mf_nr        INT NOT NULL ,
    fi_mf_nr     INT NOT NULL ,
    mf_abteilung VARCHAR (200) ,
    mf_kommentar VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE mensch_firma_zuord ADD CONSTRAINT mensch_firma_zuord_PK PRIMARY KEY ( mf_nr ) ;
ALTER TABLE mensch_firma_zuord CHANGE mf_nr mf_nr INT AUTO_INCREMENT;

CREATE TABLE mensch_persondaten_zuord
  (
    mp_nr    INT NOT NULL ,
    ad_mp_nr INT NOT NULL ,
    ko_mp_nr INT NOT NULL ,
    me_mp_nr INT NOT NULL
  ) ;
ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_PK PRIMARY KEY ( mp_nr ) ;
ALTER TABLE mensch_persondaten_zuord CHANGE mp_nr mp_nr INT AUTO_INCREMENT;

CREATE TABLE mensch_vorlesung_zuord
  (
    me_mevo_nr INT NOT NULL ,
    vo_mevo_nr INT NOT NULL
  ) ;
ALTER TABLE mensch_vorlesung_zuord ADD CONSTRAINT Mensch_Vorlesung_Zuord_PK PRIMARY KEY ( me_mevo_nr, vo_mevo_nr ) ;

CREATE TABLE pr_praeferenz
  (
    pr_nr                        INT NOT NULL ,
    me_pr_nr                     INT NOT NULL ,
    su_pr_nr                     INT NOT NULL ,
    pr_lehrauftraege             VARCHAR (1000) ,
    pr_prak_taetig               VARCHAR (1000) ,
    pr_weitere_infos             VARCHAR (4000) ,
    pr_kommentar                 VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE pr_praeferenz ADD CONSTRAINT pr_praeferenz_PK PRIMARY KEY ( pr_nr ) ;
ALTER TABLE pr_praeferenz CHANGE pr_nr pr_nr INT AUTO_INCREMENT;

CREATE TABLE praeferenz_vorlesung_zuord
  (
    pr_prvo_nr INT NOT NULL ,
    vo_prvo_nr INT NOT NULL
  ) ;
ALTER TABLE praeferenz_vorlesung_zuord ADD CONSTRAINT praeferenz_vorlesung_zuord_PK PRIMARY KEY ( pr_prvo_nr, vo_prvo_nr ) ;

CREATE TABLE praeferenz_vorleszeit_zuord
  (
    vz_prvz_nr INT NOT NULL ,
    pr_prvz_nr INT NOT NULL
  ) ;
ALTER TABLE praeferenz_vorleszeit_zuord ADD CONSTRAINT praeferenz_vorleszeit_zuord_PK PRIMARY KEY ( pr_prvz_nr, vz_prvz_nr ) ;

CREATE TABLE ro_rolle
  (
    ro_nr            INT           NOT NULL ,
    ro_bezeichnung   VARCHAR (200) NOT NULL ,
    ro_erstellt_von  VARCHAR (200) DEFAULT NULL ,
    ro_erstellt_am   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ro_geaendert_von VARCHAR (400) ,
    ro_geaendert_am  TIMESTAMP ,
    ro_kommentar     VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE ro_rolle ADD CONSTRAINT Ro_Rolle_PK PRIMARY KEY ( ro_nr ) ;
ALTER TABLE ro_rolle ADD CONSTRAINT ro_bezeichnung_UN UNIQUE ( ro_bezeichnung ) ;
ALTER TABLE ro_rolle CHANGE ro_nr ro_nr INT AUTO_INCREMENT;

CREATE TABLE sl_status_logging
  (
    sl_nr               INT NOT NULL ,
    st_sl_nr            INT NOT NULL ,
    me_sl_nr            INT NOT NULL ,
    us_sl_nr            INT NOT NULL ,
    sl_erstellt_von     VARCHAR (200) DEFAULT NULL ,
    sl_erstellt_am      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    sl_kommentar        VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_PK PRIMARY KEY ( sl_nr ) ;
ALTER TABLE sl_status_logging CHANGE sl_nr sl_nr INT AUTO_INCREMENT;

CREATE TABLE st_status
  (
    st_nr            INT NOT NULL ,
    st_bezeichnung   VARCHAR (200) NOT NULL ,
    st_erstellt_von  VARCHAR (200) DEFAULT NULL ,
    st_erstellt_am   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    st_geaendert_von VARCHAR (200) ,
    st_geaendert_am  TIMESTAMP ,
    st_kommentar     VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE st_status ADD CONSTRAINT Status_PK PRIMARY KEY ( st_nr ) ;
ALTER TABLE st_status ADD CONSTRAINT st_bezeichnung_UN UNIQUE ( st_bezeichnung ) ;
ALTER TABLE st_status CHANGE st_nr st_nr INT AUTO_INCREMENT;

CREATE TABLE su_studienfach
  (
    su_nr           INT NOT NULL ,
    su_bezeichnung  VARCHAR (100)  NOT NULL ,
    su_erstellt_von VARCHAR (200)  DEFAULT NULL ,
    su_kommentar    VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE su_studienfach ADD CONSTRAINT su_studienfach_PK PRIMARY KEY ( su_nr ) ;
ALTER TABLE su_studienfach ADD CONSTRAINT su_bezeichnung_UN UNIQUE ( su_bezeichnung ) ;
ALTER TABLE su_studienfach CHANGE su_nr su_nr INT AUTO_INCREMENT;

CREATE TABLE us_user
  (
    us_nr            INT NOT NULL ,
    us_username      VARCHAR (200) NOT NULL ,
    us_password      VARCHAR (200) NOT NULL ,
    us_ist_admin_JN  VARCHAR(1) DEFAULT 'N',
    us_me_nr         INT ,
    us_erstellt_von  VARCHAR (200) DEFAULT NULL ,
    us_erstellt_am   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    us_geaendert_von VARCHAR (200) ,
    us_geaendert_am  TIMESTAMP ,
    us_kommentar     VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE us_user ADD CONSTRAINT Us_User_PK PRIMARY KEY ( us_nr ) ;
ALTER TABLE us_user ADD CONSTRAINT us_username_UN UNIQUE ( us_username ) ;
ALTER TABLE us_user CHANGE us_nr us_nr INT AUTO_INCREMENT;

CREATE TABLE vo_vorlesung
  (
    vo_nr           INT NOT NULL ,
    su_vo_nr        INT NOT NULL ,
    vo_bezeichnung  VARCHAR (500) NOT NULL ,
    vo_erstellt_von VARCHAR (200) DEFAULT NULL ,
    vo_erstellt_am  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    vo_geandert_von VARCHAR (200) ,
    vo_geaendert_am TIMESTAMP ,
    vo_kommentar    VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE vo_vorlesung ADD CONSTRAINT Vo_Vorlesung_PK PRIMARY KEY ( vo_nr ) ;
ALTER TABLE vo_vorlesung ADD CONSTRAINT vo_bezeichnung_UN UNIQUE ( vo_bezeichnung ) ;
ALTER TABLE vo_vorlesung CHANGE vo_nr vo_nr INT AUTO_INCREMENT;

CREATE TABLE vz_vorlesungszeit
  (
    vz_nr           INT NOT NULL ,
    vz_bezeichnung  VARCHAR (21) NOT NULL ,
    vz_erstellt_von VARCHAR (200) DEFAULT NULL ,
    vz_kommentar    VARCHAR (4000) DEFAULT NULL
  ) ;
ALTER TABLE vz_vorlesungszeit ADD CONSTRAINT vz_vorlesungszeit_PK PRIMARY KEY ( vz_nr ) ;
ALTER TABLE vz_vorlesungszeit ADD CONSTRAINT vz_bezeichnung_UN UNIQUE ( vz_bezeichnung ) ;
ALTER TABLE vz_vorlesungszeit CHANGE vz_nr vz_nr INT AUTO_INCREMENT;

ALTER TABLE me_mensch ADD CONSTRAINT Me_Mensch_Ro_Rolle_FK FOREIGN KEY ( ro_me_nr ) REFERENCES ro_rolle ( ro_nr ) ;

ALTER TABLE mensch_vorlesung_zuord ADD CONSTRAINT Mensch_Vorlesung_Zuord_Me_Mensch_FK FOREIGN KEY ( me_mevo_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE mensch_vorlesung_zuord ADD CONSTRAINT Mensch_Vorlesung_Zuord_Vo_Vorlesung_FK FOREIGN KEY ( vo_mevo_nr ) REFERENCES vo_vorlesung ( vo_nr ) ;

ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_Me_Mensch_FK FOREIGN KEY ( me_sl_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_St_Status_FK FOREIGN KEY ( st_sl_nr ) REFERENCES st_status ( st_nr ) ;

ALTER TABLE sl_status_logging ADD CONSTRAINT Sl_Status_Logging_Us_User_FK FOREIGN KEY ( us_sl_nr ) REFERENCES us_user ( us_nr ) ;

ALTER TABLE us_user ADD CONSTRAINT Us_User_Me_Mensch_FK FOREIGN KEY ( us_me_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE fi_firma ADD CONSTRAINT fi_firma_ad_adresse_FK FOREIGN KEY ( ad_fi_nr ) REFERENCES ad_adresse ( ad_nr ) ;

ALTER TABLE fi_firma ADD CONSTRAINT fi_firma_ko_kontakt_FK FOREIGN KEY ( ko_fi_nr ) REFERENCES ko_kontakt ( ko_nr ) ;

ALTER TABLE me_mensch ADD CONSTRAINT me_mensch_mensch_firma_zuord_FK FOREIGN KEY ( mf_me_nr ) REFERENCES mensch_firma_zuord ( mf_nr ) ;

ALTER TABLE mensch_bank_zuord ADD CONSTRAINT mensch_bank_zuord_ba_bank_FK FOREIGN KEY ( ba_mb_nr ) REFERENCES ba_bank ( ba_nr ) ;

ALTER TABLE mensch_bank_zuord ADD CONSTRAINT mensch_bank_zuord_me_mensch_FK FOREIGN KEY ( me_mb_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE mensch_firma_zuord ADD CONSTRAINT mensch_firma_zuord_fi_firma_FK FOREIGN KEY ( fi_mf_nr ) REFERENCES fi_firma ( fi_nr ) ;

ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_ad_adresse_FK FOREIGN KEY ( ad_mp_nr ) REFERENCES ad_adresse ( ad_nr ) ;

ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_ko_kontakt_FK FOREIGN KEY ( ko_mp_nr ) REFERENCES ko_kontakt ( ko_nr ) ;

ALTER TABLE mensch_persondaten_zuord ADD CONSTRAINT mensch_persondaten_zuord_me_mensch_FK FOREIGN KEY ( me_mp_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE pr_praeferenz ADD CONSTRAINT pr_praeferenz_me_mensch_FK FOREIGN KEY ( me_pr_nr ) REFERENCES me_mensch ( me_nr ) ;

ALTER TABLE pr_praeferenz ADD CONSTRAINT pr_praeferenz_su_studienfach_FK FOREIGN KEY ( su_pr_nr ) REFERENCES su_studienfach ( su_nr ) ;

ALTER TABLE praeferenz_vorlesung_zuord ADD CONSTRAINT praeferenz_vorlesung_zuord_pr_praeferenz_FK FOREIGN KEY ( pr_prvo_nr ) REFERENCES pr_praeferenz ( pr_nr ) ;

ALTER TABLE praeferenz_vorlesung_zuord ADD CONSTRAINT praeferenz_vorlesung_zuord_vo_vorlesung_FK FOREIGN KEY ( vo_prvo_nr ) REFERENCES vo_vorlesung ( vo_nr ) ;

ALTER TABLE praeferenz_vorleszeit_zuord ADD CONSTRAINT praeferenz_vorleszeit_zuord_pr_praeferenz_FK FOREIGN KEY ( pr_prvz_nr ) REFERENCES pr_praeferenz ( pr_nr ) ;

ALTER TABLE praeferenz_vorleszeit_zuord ADD CONSTRAINT praeferenz_vorleszeit_zuord_vz_vorlesungszeit_FK FOREIGN KEY ( vz_prvz_nr ) REFERENCES vz_vorlesungszeit ( vz_nr ) ;

ALTER TABLE vo_vorlesung ADD CONSTRAINT vo_vorlesung_su_studienfach_FK FOREIGN KEY ( su_vo_nr ) REFERENCES su_studienfach ( su_nr ) ;



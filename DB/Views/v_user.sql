/**
 * Autor: Alexander Christ
 * Datum: 14.12.2014
 * Thema: Liefert alle bekannten User im System
 */
CREATE OR REPLACE VIEW v_user
 AS  
 SELECT us_nr,
       us_username
  FROM v0_us_user;
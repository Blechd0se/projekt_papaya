DROP FUNCTION bearbeite_admin_passwort;

/**
 * Autor: Alexander Christ
 * Datum: 17.01.2015
 * Thema: Ändert das Passwort eines Nutzers auf ein neues (per Admin).
 * 
 * iUS_USERNAME, String der dem Usernamen entspricht
 * iUS_PASSWORD_NEU, String als md5 Hash der dem neuem Passwort entspricht.
 */
CREATE FUNCTION bearbeite_admin_passwort(
    iUS_USERNAME     VARCHAR(200), 
    iUS_PASSWORD_NEU VARCHAR(32)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT -1;

    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE us_username = iUS_USERNAME;

    IF v_us_nr IS NOT NULL THEN
        UPDATE v0_us_user
           SET us_password = iUS_PASSWORD_NEU
         WHERE us_nr = v_us_nr;
         
        RETURN v_us_nr;
    END IF;
       
    RETURN v_us_nr;
END;

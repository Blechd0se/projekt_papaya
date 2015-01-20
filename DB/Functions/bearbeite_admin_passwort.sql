DROP FUNCTION bearbeite_admin_passwort;

/**
 * Autor: Alexander Christ
 * Datum: 17.01.2015
 * Thema: �ndert das Passwort eines Nutzers auf ein neues (per Admin).
 * 
 * iUS_USERNAME, String der dem Usernamen entspricht
 * iUS_PASSWORD_NEU, String als md5 Hash der dem neuem Passwort entspricht.
 */
CREATE FUNCTION bearbeite_admin_passwort(
    iUS_USERNAME     VARCHAR(200), 
    iUS_PASSWORD_NEU VARCHAR(32),
    iUS_ADMIN_USERNAME VARCHAR(200),
    iUS_ADMIN_PASSWORD VARCHAR(32)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT -1;
    DECLARE v_admin INT DEFAULT 0;

    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE us_username = iUS_ADMIN_USERNAME
       AND us_password = iUS_ADMIN_PASSWORD;

    SELECT ist_admin_user(null, v_us_nr)
      INTO v_admin;
    
    IF v_admin <> 1 THEN
        -- Wir sind kein Admin;
        RETURN NULL;
    ELSE
        UPDATE v0_us_user
           SET us_password = iUS_PASSWORD_NEU
         WHERE us_username = iUS_USERNAME; 
        
        SELECT us_nr
          INTO v_us_nr
          FROM v0_us_user
         WHERE us_username = iUS_USERNAME;
        
        RETURN v_us_nr;
    END IF;
       
    RETURN v_us_nr;
END;

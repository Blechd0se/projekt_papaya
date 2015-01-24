DROP FUNCTION reset_admin_passwort;

/**
 * Autor: Alexander Christ
 * Datum: 25.01.2015
 * Thema: Ändert das Passwort des 'admin' Nutzers auf ein neues.
 * 
 * iUS_PASSWORD, String als md5 Hash der dem Passwort entspricht.
 */
CREATE FUNCTION reset_admin_passwort(
    iUS_PASSWORD     VARCHAR(32)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT -1;

    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE UPPER(us_username) = upper('admin');

    IF v_us_nr IS NOT NULL THEN
        UPDATE v0_us_user
           SET us_password = iUS_PASSWORD
         WHERE us_nr = v_us_nr;
         
        RETURN v_us_nr;
    END IF;
       
    RETURN v_us_nr;
END;

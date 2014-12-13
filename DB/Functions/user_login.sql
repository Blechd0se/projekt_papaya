DROP FUNCTION user_login;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei erfolgreichen Daten den us_nr Schlüssel zurück. Liefert
 *        NULL bei Misserfolg zurück.
 * 
 * iUS_USERNAME, String der dem Usernamen entspricht
 * iUS_PASSWORD, String als md5 Hash der dem Passwort entspricht.
 */
CREATE FUNCTION user_login(
    iUS_USERNAME VARCHAR(200), 
    iUS_PASSWORD VARCHAR(32)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT NULL;

    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE us_username = iUS_USERNAME
       AND us_password = iUS_PASSWORD;
       
    RETURN v_us_nr;
END;

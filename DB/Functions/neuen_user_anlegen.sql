DROP FUNCTION neuen_user_anlegen;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei erfolgreichen Daten NULL zurück. Sollte es den
 *        User bereits geben, wird dessen us_nr zurückgegeben.
 * 
 * iUS_USERNAME, String der dem Usernamen entspricht
 * iUS_PASSWORD, String als md5 Hash der dem Passwort entspricht.
 * iUS_ERSTELLT_VON String der den ersteller des Datensatzes angibt
 */
CREATE FUNCTION neuen_user_anlegen(
    iUS_USERNAME VARCHAR(200), 
    iUS_PASSWORD VARCHAR(32),
    iUS_ERSTELLT_VON VARCHAR(200)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT NULL;

    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE us_username = iUS_USERNAME;

    IF v_us_nr IS NULL THEN

        INSERT INTO v0_us_user (us_username  , us_password  , us_erstellt_von  )
                        VALUES (iUS_USERNAME , iUS_PASSWORD , iUS_ERSTELLT_VON );
                    
    END IF;
       
    RETURN v_us_nr;
END;

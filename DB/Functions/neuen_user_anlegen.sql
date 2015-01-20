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
    iUS_USERNAME   VARCHAR(200), 
    iUS_PASSWORD   VARCHAR(32),
    iUS_IST_ADMIN  VARCHAR(1)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT NULL;

    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE us_username = iUS_USERNAME;

    IF v_us_nr IS NULL THEN

        INSERT INTO v0_us_user (us_username  , us_password  , us_ist_admin_JN )
                        VALUES (iUS_USERNAME , iUS_PASSWORD , iUS_IST_ADMIN   );
        
        SELECT LAST_INSERT_ID()
          INTO v_us_nr;
          
        RETURN v_us_nr;
                    
    END IF;
       
    RETURN -1;
END;

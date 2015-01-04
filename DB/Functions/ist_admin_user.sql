DROP FUNCTION ist_admin_user;

/**
 * Autor: Alexander Christ
 * Datum: 13.12.2014
 * Thema: Liefert bei Erfolg 1 zurück, wenn admin User, ansonsten 0
 * 
 * iUS_USERNAME, String der dem Usernamen entspricht
 */
CREATE FUNCTION ist_admin_user(
    iUS_USERNAME VARCHAR(200)
  ) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_us_nr INT DEFAULT NULL;
    
    SELECT us_nr
      INTO v_us_nr
      FROM v0_us_user
     WHERE us_username = iUS_USERNAME
       AND us_ist_admin_JN = 'J';
    
    IF v_us_nr IS NULL THEN
        RETURN 0;      
    END IF;
       
    RETURN 1;
END;

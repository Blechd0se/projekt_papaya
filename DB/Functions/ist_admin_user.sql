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
    IF UPPER(iUS_USERNAME) = UPPER('admin') THEN
        RETURN 1;      
    END IF;
       
    RETURN 0;
END;

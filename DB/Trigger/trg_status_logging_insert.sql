DROP TRIGGER trg_status_logging_insert;

CREATE TRIGGER trg_status_logging_insert
    AFTER INSERT ON me_mensch
    FOR EACH ROW
    BEGIN
       
       -- Damit wir innerhalb einer Function immer noch inserten können;
       IF @TRIGGER_DISABLED = 0 THEN
           -- Initialen Status setzen;   
           INSERT INTO v0_sl_status_logging (st_sl_nr, me_sl_nr  , us_sl_nr, sl_erstellt_von )
                                     VALUES (  (SELECT st_nr
                                                  FROM v0_st_status
                                                 WHERE st_bezeichnung = 'Bewerbung eingegangen'), NEW.me_nr ,    1    , @CURRENT_LOGIN_USER  );
       END IF;
       
    END;

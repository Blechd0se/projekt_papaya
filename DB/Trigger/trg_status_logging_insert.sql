DROP TRIGGER trg_status_logging_insert;

CREATE TRIGGER trg_status_logging_insert
    AFTER INSERT ON me_mensch
    FOR EACH ROW
    BEGIN
    
       -- Initialen Status setzen;   
       INSERT INTO sl_status_logging (st_sl_nr, me_sl_nr  , us_sl_nr, sl_erstellt_von    )
                              VALUES (    1   , NEW.me_nr ,    1    , NEW.me_erstellt_von);
       
    END;
DROP TRIGGER trg_status_logging_update;

CREATE TRIGGER trg_status_logging_update
    BEFORE UPDATE ON me_mensch
    FOR EACH ROW
    BEGIN
       DECLARE v_sl_nr INT;
       
       -- Bei einem Update besitzen wir bereits einen Status;
       SELECT sl_nr
         INTO v_sl_nr
         FROM v0_sl_status_logging,
              v0_st_status,
              v0_me_mensch
        WHERE st_sl_nr = st_nr
          AND st_me_nr = st_nr
          AND me_nr = NEW.me_nr
        ORDER BY sl_erstellt_am ASC
        LIMIT 1;
       
       CALL proc_mensch_status_logging(NEW.me_nr,  -- me_nr
                                       NEW.st_me_nr,  -- st_nr
                                       v_sl_nr); -- sl_vorg_nr
    END;
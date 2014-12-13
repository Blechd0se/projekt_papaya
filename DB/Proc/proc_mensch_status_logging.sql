DROP PROCEDURE proc_mensch_status_logging;

CREATE PROCEDURE proc_mensch_status_logging 
    (IN iME_NR               INT,
     IN iST_NR               INT,
     IN iSL_SL_VORGEANDER_NR INT)
    BEGIN
         DECLARE v_us_nr INT DEFAULT NULL;
         DECLARE v_sl_st_nr INT;
         DECLARE v_sl_vorgaenger_nr INT;
         DECLARE v_rollback BOOL DEFAULT 0;
         DECLARE EXIT HANDLER FOR SQLEXCEPTION SET v_rollback = 1;
         
         -- Suche nach Moeglichkeit einen passenden User
         SELECT us_nr
           INTO v_us_nr
           FROM v0_us_user,
                v0_me_mensch
          WHERE us_me_nr = me_nr
            AND me_nr = iME_NR;
         
         IF v_us_nr IS NULL THEN
             SELECT us_nr
               INTO v_us_nr
               FROM v0_us_user
              WHERE us_username = 'admin';
         END IF;
         -- Fuehre Insert durch;
         INSERT INTO v0_sl_status_logging ( st_sl_nr, sl_erstellt_von, sl_sl_vorgaenger_nr  , me_sl_nr, us_sl_nr)
                                   VALUES ( iST_NR  ,   'SYSTEM'     , iSL_SL_VORGEANDER_NR , iME_NR  , v_us_nr );
          
          IF v_rollback THEN
              ROLLBACK;
          END IF;
                                   
    END;
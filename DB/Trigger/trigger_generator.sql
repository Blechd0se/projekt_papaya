/**
 * Autor: Alexander Christ
 * Datum: 07.12.2014
 * Thema: Generiert Trigger für Tabellen mit _erstellt_von Spalte
 */
 
 SELECT CONCAT(CONCAT(
            CONCAT(
                CONCAT(
                    CONCAT(
                        CONCAT(CONCAT(CONCAT('DROP TRIGGER trg_', CONCAT(table_name, '_insert;\n\n')), 'CREATE TRIGGER trg_'), table_name), 
                    '_insert\n    BEFORE INSERT ON '), 
                table_name), 
            '\n    FOR EACH ROW\n    BEGIN\n\n'),
        CONCAT('       SET NEW.', 
                CONCAT(column_name, ' = CURRENT_USER();\n')
              )
        ), '\n    END;\n'), table_name
   FROM information_schema.COLUMNS
  WHERE column_name LIKE '%_erstellt_von'
    AND TABLE_NAME NOT LIKE 'v0_%'
    AND TABLE_NAME <> 'me_mensch'
  ;

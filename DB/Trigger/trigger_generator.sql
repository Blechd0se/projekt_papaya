/**
 * Autor: Alexander Christ
 * Datum: 03.12.2014
 * Thema: Generiert Trigger für Tabellen mit _erstellt_von Spalte
 */
 
 SELECT CONCAT(CONCAT(CONCAT(
            CONCAT(
                CONCAT(
                    CONCAT(
                        CONCAT(CONCAT(CONCAT('DROP TRIGGER trg_', CONCAT(table_name, '_insert;\n\n')), 'CREATE TRIGGER trg_'), table_name), 
                    '_insert\n    AFTER INSERT ON '), 
                table_name), 
            '\n    FOR EACH ROW\n    BEGIN\n\n'),
        '        UPDATE '),
        CONCAT(
            CONCAT(table_name, ' \n           SET '), 
                CONCAT(column_name, ' = CURRENT_USER()\n')
              )
        ),
        CONCAT('         WHERE '), CONCAT(SUBSTRING(column_name, 1, 3), CONCAT('nr = NEW.', CONCAT(SUBSTRING(column_name, 1, 3), 'nr; \n\n    END;\n'))))
   FROM information_schema.COLUMNS
  WHERE column_name LIKE '%_erstellt_von'
    AND TABLE_NAME NOT LIKE 'v0_%'
    AND TABLE_NAME <> 'me_mensch'
  ;

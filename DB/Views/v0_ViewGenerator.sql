/**
 * Autor: Alexander Christ
 * Datum: 29.11.2014
 * Thema: v0_View Generator
 */

SELECT CONCAT(CONCAT(CONCAT(STATEMENT, '\n   FROM '), table_name), ';')
  FROM (SELECT CONCAT(
                   CONCAT(
                       CONCAT('CREATE OR REPLACE VIEW v0_', table_name),
                       ' AS \n SELECT\n '
                   ),
                group_concat(CONCAT('       ', column_name) separator ',\n ')   
                ) AS STATEMENT, table_name
          FROM information_schema.COLUMNS
         WHERE table_schema = 'db_papaya'
           AND table_name NOT LIKE 'v0_%'
         GROUP BY table_name) sub
 ;
 
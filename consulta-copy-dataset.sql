SELECT
  CONCAT(
    'CREATE TABLE `rj-impatech.dados_mestres_copy.',
    table_name,
    '` COPY `rj-iplanrio.brutos_dados_mestres.',
    table_name,
    '`;'
  ) AS copy_statement
FROM `rj-iplanrio.brutos_dados_mestres.INFORMATION_SCHEMA.TABLES`
WHERE table_type = 'BASE TABLE';

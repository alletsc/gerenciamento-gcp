SELECT
  column_name,
  field_path,
  data_type,
  description
FROM `rj-iplanrio.brutos_bcadastro.INFORMATION_SCHEMA.COLUMN_FIELD_PATHS`
WHERE table_name = 'cpf'
ORDER BY field_path;

-- Extrai o log de todos os jobs BigQuery executados no projeto rj-iplanrio em 10/03/2026, com metadados de autoria, destino, volume processado e resultado.
SELECT          
    project_id,
    job_id,
    job_type,
    statement_type,
    principal_email,
    principal_type,
    is_service_account,
    creation_time,
    end_time,
    TIMESTAMP_DIFF(end_time, creation_time, SECOND) AS duracao_segundos,
    destination_project_id,
    destination_dataset_id,
    destination_table_id,

    -- Bytes processados
    total_bytes_processed,
    total_bytes_billed,
    ROUND(total_bytes_processed / POWER(1024, 4), 4) AS tib_processed,
    ROUND(total_bytes_billed / POWER(1024, 4), 4) AS tib_billed,

    state,
    error_result

  FROM `rj-iplanrio.brutos_gcp.gcp_bigquery_jobs_v2`
  WHERE project_id = 'rj-iplanrio'
    AND DATE(creation_time) = '2026-03-10'
    AND creation_time < '2026-03-10 23:59:59'
  ORDER BY creation_time DESC;

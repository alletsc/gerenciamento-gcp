SELECT                                                                                                                
    project_id,                                                                                                         
    job_id,                                                                                                             
    job_type,                                                                                                           
    statement_type,                                                                                                     
    principal_email,
    principal_type,

    -- Timing
    creation_time,
    end_time,
    TIMESTAMP_DIFF(end_time, creation_time, SECOND) AS duracao_segundos,

    -- Destino
    destination_project_id,
    destination_dataset_id,
    destination_table_id,

    -- Bytes
    total_bytes_processed,
    total_bytes_billed,
    ROUND(total_bytes_processed / POWER(1024, 4), 4) AS tib_processed,
    ROUND(total_bytes_billed / POWER(1024, 4), 4) AS tib_billed,

    state

  FROM `rj-iplanrio.brutos_gcp.gcp_bigquery_jobs_v2`
  WHERE project_id = 'rj-iplanrio'
    AND DATE(creation_time) = '2026-03-10'
    AND (total_bytes_processed > 0 OR total_bytes_billed > 0)  -- Apenas com processamento
  ORDER BY creation_time DESC;

  --investigação por horário de pico (22h):

  SELECT
    job_id,
    job_type,
    principal_email,
    creation_time,
    ROUND(total_bytes_processed / POWER(1024, 4), 4) AS tib_processed,
    ROUND(total_bytes_billed / POWER(1024, 4), 4) AS tib_billed,
    destination_dataset_id,
    destination_table_id

  FROM `rj-iplanrio.brutos_gcp.gcp_bigquery_jobs_v2`
  WHERE project_id = 'rj-iplanrio'
    AND creation_time >= '2026-03-10 21:00:00'
    AND creation_time < '2026-03-10 23:59:59'
    AND (total_bytes_processed > 0 OR total_bytes_billed > 0)
  ORDER BY total_bytes_processed DESC;

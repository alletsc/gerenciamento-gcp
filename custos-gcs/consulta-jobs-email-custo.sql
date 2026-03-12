SELECT                   
      j.project_id,
      j.job_id,                                                                                                         
      j.job_type,
      j.statement_type,                                                                                                 
      j.principal_email,
      j.principal_type,
      j.is_service_account,
      j.creation_time,
      j.end_time,
      TIMESTAMP_DIFF(j.end_time, j.creation_time, SECOND) AS duracao_segundos,
      j.destination_project_id,
      j.destination_dataset_id,
      j.destination_table_id,

      -- Bytes processados
      j.total_bytes_processed,
      j.total_bytes_billed,
      ROUND(j.total_bytes_processed / POWER(1024, 4), 4) AS tib_processed,
      ROUND(j.total_bytes_billed / POWER(1024, 4), 4) AS tib_billed,

      -- CUSTO ALOCADO
      ROUND(c.allocated_cost_job, 2) AS custo_job,
      ROUND(c.bigquery_cost_net, 2) AS custo_projeto_mes,

      j.state,
      j.error_result

  FROM `rj-iplanrio.brutos_gcp.gcp_bigquery_jobs_v2` j
  LEFT JOIN `rj-iplanrio.brutos_gcp.gcp_bigquery_cost_allocated_v1` c
      ON j.project_id = c.project_id
      AND j.job_id = c.job_id
  WHERE j.project_id = 'rj-iplanrio'
      AND j.creation_time >= '2026-03-10 22:00:00'  -- Das 22h
      AND j.creation_time < '2026-03-10 23:00:00'   -- Até antes das 23h
  ORDER BY c.allocated_cost_job DESC;

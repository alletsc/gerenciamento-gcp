 --  Verificar as UNIDADES REAIS do billing (sem conversão)                                                          
  SELECT
    usage_start_time,                                                                                                   
                  
    -- VALORES BRUTOS (SEM CONVERSÃO)
    usage.amount AS amount_bruto,
    usage.amount_in_pricing_units AS amount_pricing_bruto,

    -- Unidades
    usage.unit AS unidade_base,
    usage.pricing_unit AS unidade_preco,

    -- Tentativas de conversão
    ROUND(usage.amount / POWER(1024, 4), 4) AS se_bytes_para_tib,
    ROUND(usage.amount / POWER(1024, 3), 4) AS se_bytes_para_gib,
    ROUND(usage.amount / 1024, 4) AS se_gib_para_tib,
    ROUND(usage.amount_in_pricing_units, 4) AS amount_pricing_direto,

    -- Custo
    cost,

    -- Recurso
    resource.name,
    sku.description

  FROM `rj-iplanrio.brutos_gcp.gcp_billing`
  WHERE project.id = 'rj-iplanrio'
    AND service.description = 'Cloud Storage'
    AND sku.description LIKE '%Network%Data%Transfer%'
    AND usage_start_time >= '2026-03-10 22:00:00'
    AND usage_start_time < '2026-03-10 23:00:00'
    AND cost > 100  -- Apenas os eventos com custo significativo
  ORDER BY cost DESC
  LIMIT 5;

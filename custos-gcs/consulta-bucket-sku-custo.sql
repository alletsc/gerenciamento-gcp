 SELECT
    usage_start_time,                                                                                                   
    usage_end_time,

    -- RECURSO (importante!)
    resource.name AS bucket_ou_recurso,
    resource.global_name,

    -- LOCALIZAÇÃO
    location.location AS localizacao,
    location.country,
    location.region,

    -- TRANSFERÊNCIA
    ROUND(usage.amount / POWER(1024, 4), 4) AS tb_transferidos,
    cost,

    -- SKU detalhado
    sku.description AS sku_tipo,
    sku.id AS sku_id,

    -- Labels expandidos
    labels,
    system_labels,

    -- Unidade de medida
    usage.unit,
    usage.pricing_unit

  FROM `rj-iplanrio.brutos_gcp.gcp_billing`
  WHERE project.id = 'rj-iplanrio'
    AND service.description = 'Cloud Storage'
    AND sku.description LIKE '%Network%Data%Transfer%'
    AND usage_start_time >= '2026-03-10 22:00:00'
    AND usage_start_time < '2026-03-10 23:00:00'
  ORDER BY usage.amount DESC;

CREATE VIEW v_tablero_final AS
SELECT 
    m.*,
    COALESCE(c.cluster, -1) as id_cluster,
    COALESCE(c.tipo_cluster, 'Sin Clasificar') as categoria_riesgo
FROM mv_hechos_con_clima m
LEFT JOIN fact_resultados_clustering c ON m.id_hecho = c.id_hecho;

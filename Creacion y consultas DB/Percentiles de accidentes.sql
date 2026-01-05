WITH conteos_por_punto AS (
    -- Agrupamos por ubicación (lat/lon redondeado a ~10 metros para agrupar)
    SELECT 
        ROUND(latitud::numeric, 4) as lat,
        ROUND(longitud::numeric, 4) as lon,
        COUNT(*) as total_incidentes
    FROM v_pbi_riesgo_mapa
    GROUP BY 1, 2
)
SELECT 
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_incidentes) as mediana_limite_bajo,
    PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY total_incidentes) as pareto_limite_medio,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY total_incidentes) as top_critico_alto,
    MAX(total_incidentes) as maximo_absoluto
FROM conteos_por_punto;
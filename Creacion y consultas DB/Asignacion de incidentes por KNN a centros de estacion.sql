/* VISTA MAESTRA PARA CLUSTERING Y BI 
   -----------------------------------------------------
   Objetivo: Unir Hechos de Tránsito + Clima + Calendario
   Método: Cross Join Lateral (KNN) para lluvia espacial
*/

DROP MATERIALIZED VIEW IF EXISTS mv_hechos_con_clima;

CREATE MATERIALIZED VIEW mv_hechos_con_clima AS
SELECT 
    h.id AS id_hecho,
    h.fecha_evento::DATE AS fecha,
    h.hora_evento,
    h.latitud,
    h.longitud,
    h.tipo_evento,
    h.alcaldia,
    h.colonia,
    
    -- Métricas de Riesgo
    h.score_atlas, 
    h.nivel_riesgo_estatico,
    
    -- Dimensiones Temporales (para filtros rápidos)
    dt.anio,
    dt.mes,
    dt.dia_semana,
    dt.es_fin_semana,
    
    -- DATOS DE LLUVIA CRUZADOS (Spatial Join + Time Join)
    COALESCE(p.precipitacion_mm, 0) as precipitacion_mm,
    COALESCE(p.dist_estacion_m, 99999) as distancia_estacion_m,
    p.nombre_estacion_clima

FROM fact_hechos_transito h
-- 1. Unir con Dimensión Tiempo
JOIN dim_tiempo dt ON h.fecha_evento::DATE = dt.fecha_id

-- 2. Unir con Lluvia (Búsqueda de la estación más cercana en ESE día específico)
LEFT JOIN LATERAL (
    SELECT 
        fp.precipitacion_simulada as precipitacion_mm,
        ST_Distance(h.geometria::geography, fp.geometria::geography) as dist_estacion_m,
        fp.nombre_estacion as nombre_estacion_clima
    FROM fact_pluviales fp
    WHERE fp.fecha = h.fecha_evento::DATE -- Match exacto de fecha
    ORDER BY h.geometria <-> fp.geometria -- Operador KNN (Nearest Neighbor) más rápido que st_distance en el order by
    LIMIT 1
) p ON TRUE

WHERE h.fecha_evento >= '2014-01-01'; -- Filtro opcional si quieres descartar datos muy viejos

-- ÍNDICES PARA RENDIMIENTO (CRÍTICO PARA PYTHON/PANDAS)
CREATE INDEX idx_mv_fecha ON mv_hechos_con_clima(fecha);
CREATE INDEX idx_mv_riesgo ON mv_hechos_con_clima(nivel_riesgo_estatico);
CREATE INDEX idx_mv_lluvia ON mv_hechos_con_clima(precipitacion_mm);
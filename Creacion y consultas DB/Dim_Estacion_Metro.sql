-- 2. POBLAR DIMENSIÓN ESTACIÓN METRO (Extraer únicos)
-- Extraemos las estaciones únicas y sus ubicaciones promedio (por si hay ligeras variaciones)
INSERT INTO dim_estacion_metro (nombre_estacion, linea, geometria)
SELECT DISTINCT ON (nombre_estacion, linea)
    nombre_estacion,
    linea,
    geometria 
FROM fact_afluencia_metro
WHERE geometria IS NOT NULL
ON CONFLICT DO NOTHING;
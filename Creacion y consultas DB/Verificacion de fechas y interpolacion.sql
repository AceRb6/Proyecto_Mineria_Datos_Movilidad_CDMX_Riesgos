-- Verificar cobertura temporal y completitud de claves
SELECT 
    MIN(fecha) as fecha_inicio,
    MAX(fecha) as fecha_fin,
    COUNT(*) as total_registros_diarios,
    COUNT(DISTINCT clave_estacion) as total_estaciones
FROM fact_pluviales;

-- Verificar una estación aleatoria para ver la curva interpolada
SELECT fecha, precipitacion_simulada 
FROM fact_pluviales 
WHERE clave_estacion = (SELECT clave_estacion FROM fact_pluviales LIMIT 1)
AND fecha BETWEEN '2019-06-01' AND '2019-08-01' -- Ver un periodo de lluvia
ORDER BY fecha;

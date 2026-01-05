-- 1. Limpiar INVIALES
DELETE FROM fact_inviales
WHERE latitud = 0 OR longitud = 0 OR latitud IS NULL OR longitud IS NULL
OR latitud < 18.8 OR latitud > 19.8 OR longitud < -99.7 OR longitud > -98.5;

-- 2. Limpiar HECHOS
DELETE FROM fact_hechos_transito
WHERE latitud = 0 OR longitud = 0 OR latitud IS NULL OR longitud IS NULL
OR latitud < 18.8 OR latitud > 19.8 OR longitud < -99.7 OR longitud > -98.5;

-- 3. Limpiar METRO
DELETE FROM fact_afluencia_metro
WHERE latitud = 0 OR longitud = 0 OR latitud IS NULL OR longitud IS NULL
OR latitud < 18.8 OR latitud > 19.8 OR longitud < -99.7 OR longitud > -98.5;
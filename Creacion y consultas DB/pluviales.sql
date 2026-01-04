CREATE TABLE fact_pluviales (
    id SERIAL PRIMARY KEY,
    fecha DATE,                -- Fecha simulada (diaria)
    clave_estacion VARCHAR(40),
    nombre_estacion VARCHAR(150),
    precipitacion_simulada FLOAT, -- Valor interpolado diario
    latitud FLOAT,
    longitud FLOAT,
    geometria GEOMETRY(POINT, 4326),
    fk_tiempo DATE             -- Para relación con Dim_Tiempo
);

CREATE INDEX idx_pluviales_fecha ON fact_pluviales(fecha);
CREATE INDEX idx_pluviales_geom ON fact_pluviales USING GIST(geometria);

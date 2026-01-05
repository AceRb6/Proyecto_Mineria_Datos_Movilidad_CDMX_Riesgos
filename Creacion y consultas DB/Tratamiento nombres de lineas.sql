-- Reconstruye la cadena: Pone 'Linea ' + el número encontrado al final
UPDATE dim_estacion_metro
SET linea = 'Linea ' || SUBSTRING(linea FROM '[0-9]+$')
WHERE linea ~ '[0-9]+$'; -- Solo afecta filas que terminan en número

UPDATE dim_estacion_metro
SET linea = 'Linea ' || SPLIT_PART(linea, ' ', 2)
WHERE linea LIKE 'LÃ%';

UPDATE fact_afluencia_metro
SET linea = 'Linea ' || SUBSTRING(linea FROM '[0-9]+$')
WHERE linea ~ '[0-9]+$'; -- Solo afecta filas que terminan en número

UPDATE fact_afluencia_metro
SET linea = 'Linea ' || SPLIT_PART(linea, ' ', 2)
WHERE linea LIKE 'LÃ%';

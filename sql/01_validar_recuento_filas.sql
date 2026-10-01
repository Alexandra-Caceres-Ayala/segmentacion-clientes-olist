-- Objetivo: comprobar que al subir los CSV a BigQuery no se perdió ninguna fila.
-- Resultado esperado (ordenado por tabla):
--   raw_category_translation        71
--   raw_customers               99.441
--   raw_order_items            112.650
--   raw_order_payments         103.886
--   raw_order_reviews           99.224
--   raw_orders                  99.441
--   raw_products                32.951
--   raw_sellers                  3.095
-- Coste: 0 B. BigQuery guarda el número de filas de cada tabla, así que contar sin filtros es gratis.

SELECT 'raw_orders' AS tabla, COUNT(*) AS filas FROM olist.raw_orders
UNION ALL SELECT 'raw_customers', COUNT(*) FROM olist.raw_customers
UNION ALL SELECT 'raw_order_items', COUNT(*) FROM olist.raw_order_items
UNION ALL SELECT 'raw_order_payments', COUNT(*) FROM olist.raw_order_payments
UNION ALL SELECT 'raw_order_reviews', COUNT(*) FROM olist.raw_order_reviews
UNION ALL SELECT 'raw_products', COUNT(*) FROM olist.raw_products
UNION ALL SELECT 'raw_sellers', COUNT(*) FROM olist.raw_sellers
UNION ALL SELECT 'raw_category_translation', COUNT(*) FROM olist.raw_category_translation
ORDER BY tabla;

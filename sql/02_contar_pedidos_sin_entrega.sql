-- Objetivo: contar los pedidos sin fecha de entrega al cliente (valor NULL).
-- Resultado esperado: 2.965 pedidos.
-- Nota: los NULL se buscan con IS NULL, nunca con = NULL.
-- Coste: menos de 1 MB, porque para filtrar BigQuery tiene que leer la columna.

SELECT COUNT(*) AS pedidos_sin_entrega
FROM olist.raw_orders
WHERE order_delivered_customer_date IS NULL;

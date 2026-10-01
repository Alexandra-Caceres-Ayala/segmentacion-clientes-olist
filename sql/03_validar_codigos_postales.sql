-- Objetivo: comprobar que los códigos postales se guardaron como texto, con sus 5 dígitos.
-- Contexto: la detección automática los convertía en números (INTEGER) y borraba el
-- cero inicial (09790 pasaba a 9790). Por eso raw_customers y raw_sellers se cargan
-- con los esquemas de la carpeta esquemas/.
-- Resultado esperado:
--   tabla           filas    con_5_digitos   empiezan_por_0
--   raw_customers   99.441   99.441          23.995
--   raw_sellers      3.095    3.095           1.027

SELECT
  'raw_customers' AS tabla,
  COUNT(*) AS filas,
  COUNTIF(LENGTH(customer_zip_code_prefix) = 5) AS con_5_digitos,
  COUNTIF(STARTS_WITH(customer_zip_code_prefix, '0')) AS empiezan_por_0
FROM olist.raw_customers
UNION ALL
SELECT
  'raw_sellers',
  COUNT(*),
  COUNTIF(LENGTH(seller_zip_code_prefix) = 5),
  COUNTIF(STARTS_WITH(seller_zip_code_prefix, '0'))
FROM olist.raw_sellers;

# ¿A quién le hablamos? Segmentación de clientes y plan de CRM para un e-commerce

Proyecto de portfolio de análisis de datos con el dataset público de Olist: unos 100.000 pedidos
reales y anonimizados de un e-commerce brasileño, entre 2016 y 2018.

**Pregunta de negocio:** la dirección de marketing ve que casi ningún cliente repite compra y
envía el mismo mensaje a todos. ¿Quiénes son los mejores clientes, a quién estamos perdiendo y
qué campaña merece cada grupo?

**Herramientas:** BigQuery (SQL) · Python · Google Sheets · Power BI

> Proyecto en curso.

## Estructura

| Carpeta o archivo | Contenido |
|---|---|
| `Datos_originales/` | Los 9 CSV descargados de Kaggle, sin modificar |
| `archive.zip` | Copia de seguridad del archivo descargado |
| `sql/` | Consultas SQL, numeradas en el orden en que se ejecutan |
| `esquemas/` | Esquemas definidos a mano para las tablas en las que falla la detección automática |

## Datos

- Fuente: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle).
- Licencia: CC BY-NC-SA 4.0.

## Cómo reconstruir las tablas en BigQuery

Las tablas del sandbox de BigQuery se borran a los 60 días. Para volver a crearlas:

1. Usa el proyecto `portfolio-olist-510017` y el conjunto de datos `olist`, en la multirregión US.
2. Sube cada CSV con **Crear tabla › Subir**, con 0 errores permitidos:

| CSV | Tabla | Esquema | Opciones avanzadas |
|---|---|---|---|
| olist_orders_dataset.csv | raw_orders | Detección automática | — |
| olist_customers_dataset.csv | raw_customers | `esquemas/raw_customers.json` | Omitir 1 fila de encabezado |
| olist_order_items_dataset.csv | raw_order_items | Detección automática | — |
| olist_order_payments_dataset.csv | raw_order_payments | Detección automática | — |
| olist_order_reviews_dataset.csv | raw_order_reviews | Detección automática | Permitir saltos de línea en secciones entrecomilladas |
| olist_products_dataset.csv | raw_products | Detección automática | — |
| olist_sellers_dataset.csv | raw_sellers | `esquemas/raw_sellers.json` | Omitir 1 fila de encabezado |
| product_category_name_translation.csv | raw_category_translation | `esquemas/raw_category_translation.json` | Omitir 1 fila de encabezado |

   `olist_geolocation_dataset.csv` no se carga: para el análisis geográfico basta con el estado
   del cliente.

3. Ejecuta `sql/01_validar_recuento_filas.sql` y `sql/03_validar_codigos_postales.sql` y compara
   el resultado con el que indica cada archivo.

## Decisiones técnicas

- **Tablas `raw_`:** son una copia exacta de los CSV y nunca se modifican. La limpieza crea
  tablas nuevas.
- **Códigos postales como texto (STRING):** la detección automática los convertía en números y
  borraba el cero inicial en 23.995 de las 99.441 filas de clientes, un 24 %. Por ejemplo,
  `09790` pasaba a ser `9790`.
- **Traducción de categorías con esquema manual:** todas sus columnas son texto, así que la
  detección automática no reconoce la fila de títulos.

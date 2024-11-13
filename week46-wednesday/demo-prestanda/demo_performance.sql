/*
  demo2_prestanda
*/

--------------------------------------

-- MySQL har en optimizer som beräknar den bästa "execution plan" för att köra en fråga. Detta innebär att den försöker minimera resursanvändningen för att göra frågan så snabb som möjligt.

-- Dokumentation: https://dev.mysql.com/doc/refman/8.4/en/controlling-optimizer.html

-- Skriv en fråga utan index och kör EXPLAIN för att se execution plan.
-- Kör följande exempel utan att ha ett index på customer_id i order-tabellen:

EXPLAIN SELECT * FROM order WHERE customer_id = 'ALFKI';

-- Förklara vad kolumnerna i resultatet från EXPLAIN betyder, såsom type (om det är en table scan, index scan etc.), possible_keys, och key.

--------------------------------------

CREATE INDEX idx_order_customer_id ON order(customer_id);

/*
  ...följt av:
*/

EXPLAIN SELECT * FROM order WHERE customer_id = 'ALFKI';

---------------------------------------

-- Lista alla indexes för tabell X

SHOW INDEX FROM table_name;

---------------------------------------

-- aktivera profilering
SET profiling = 1;

-- kör "tung" query
SELECT * FROM product;

-- visa profiler för queries
SHOW PROFILES;

-- visa detaljerad info om query X
SHOW PROFILE FOR QUERY 1;

---------------------------------------

SELECT * FROM order WHERE customer_id = 'ALFKI';
SELECT order_id, order_date FROM order WHERE customer_id = 'ALFKI';

SELECT customer_id FROM order;
SELECT DISTINCT customer_id FROM order;

-- kolla profilerna igen
SHOW PROFILES;

---------------------------------------

-- Kontrollera om cachning är aktiverat:

SHOW VARIABLES LIKE 'query_cache_size';
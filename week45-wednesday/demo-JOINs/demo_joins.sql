------------ Exempel 1: INNER JOIN ------------
-- Fråga: Hämta produktnamn och leverantörens företagsnamn för varje produkt.

SELECT product.product_name, supplier.company_name FROM product INNER JOIN supplier ON product.supplier_id = supplier.supplier_id;

-- Förklaring: Denna fråga använder INNER JOIN för att hämta endast de produkter som har en matchande leverantör i tabellen supplier.

------------ Exempel 2: LEFT JOIN ------------
-- Fråga: Hämta alla produkter samt leverantörens namn, inklusive de produkter som saknar en leverantör.

SELECT product.product_name, supplier.company_name FROM product LEFT JOIN supplier ON product.supplier_id = supplier.supplier_id;

-- Förklaring: LEFT JOIN returnerar alla rader från product och matchande rader från supplier. Om en produkt saknar en leverantör, kommer company_name att vara NULL för den raden.

------------ Exempel 3: RIGHT JOIN ------------

-- Fråga: Hämta alla leverantörer och deras produkter, inklusive de leverantörer som inte har några produkter.

SELECT supplier.company_name, product.product_name FROM supplier RIGHT JOIN product ON supplier.supplier_id = product.supplier_id;

-- Förklaring: RIGHT JOIN hämtar alla rader från product och de matchande raderna från supplier. Om en leverantör inte har några produkter kommer product_name att vara NULL för den raden.

------------ Exempel 4: INNER JOIN mellan order, customer, och employee ------------

-- Fråga: Hämta alla ordrar, inklusive kundens namn och anställdas namn som hanterade ordern.

SELECT `order`.order_id, customer.company_name AS customer_name,
       employee.first_name AS employee_first_name, employee.last_name AS employee_last_name
FROM `order`
INNER JOIN customer ON `order`.customer_id = customer.customer_id
INNER JOIN employee ON `order`.employee_id = employee.employee_id;

-- Förklaring: Här använder vi två INNER JOINs för att hämta data från tre tabeller: order, customer, och employee. Resultatet visar varje order med kundens namn och anställdas för- och efternamn som hanterade ordern.

------------ Exempel 5: INNER JOIN mellan order_detail och product ------------

-- Fråga: Hämta detaljer för varje order, inklusive produktnamnet och antalet produkter som beställts.

SELECT order_detail.order_id, product.product_name, order_detail.quantity
FROM order_detail
INNER JOIN product ON order_detail.product_id = product.product_id;

-- Förklaring: Här använder vi INNER JOIN för att kombinera order_detail med product, vilket ger oss information om produktnamnet och kvantiteten för varje orderrad.

------------ Exempel 6: INNER JOIN mellan order, customer, och shipper ------------

-- Fråga: Hämta alla ordrar, kundens namn, och transportföretagets namn (shipper) som levererade ordern.

SELECT order.order_id, customer.company_name AS customer_name, shipper.company_name AS shipper_name
FROM order
INNER JOIN customer ON order.customer_id = customer.customer_id
INNER JOIN shipper ON order.shipper_id = shipper.shipper_id;

-- Förklaring: Denna fråga hämtar alla order tillsammans med kundnamnet och namnet på det transportföretag (shipper) som levererade ordern.

------------ Exempel 6: INNER JOIN mellan product, category, och supplier ------------

-- Fråga: Hämta alla produkter, inklusive deras kategori och leverantörens namn.

SELECT product.product_name, category.category_name, supplier.company_name AS supplier_name
FROM product
INNER JOIN category ON product.category_id = category.category_id
INNER JOIN supplier ON product.supplier_id = supplier.supplier_id;

-- Förklaring: Här används INNER JOIN för att hämta produktens kategori och leverantörens namn. Detta ger en tydlig översikt över varje produkt tillsammans med dess kategori och leverantör.
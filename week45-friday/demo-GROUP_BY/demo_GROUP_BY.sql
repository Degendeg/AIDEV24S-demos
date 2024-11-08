-- Demo av GROUP BY och HAVING i Northwind

-- Totalt orderbelopp för varje kund
-- För att visa totalvärdet på alla ordrar per kund, kan vi använda GROUP BY för att gruppera datan på kundnivå och sedan använda SUM-funktionen på kolumnen unit_price * quantity från order_detail.

SELECT 
    customer.company_name, 
    SUM(order_detail.unit_price * order_detail.quantity) AS total_order_amount
FROM 
    customer
JOIN 
    `order` ON customer.customer_id = `order`.customer_id
JOIN 
    order_detail ON `order`.order_id = order_detail.order_id
GROUP BY 
    customer.customer_id, customer.company_name
ORDER BY 
    total_order_amount DESC;

-- Detta ger en lista på varje kunds namn och den totala summan av deras ordrar, sorterat i fallande ordning efter totalvärde.

----------------------------------------------------------------------------------------------------------------

-- Totalt orderbelopp för varje kund under ett specifikt år (med WHERE och HAVING)
-- Om vi vill filtrera fram det totala orderbeloppet för varje kund under ett specifikt år, till exempel 2015, och samtidigt endast visa de kunder vars totalorder är över ett visst belopp, använder vi både WHERE och HAVING.

SELECT 
    customer.company_name, 
    SUM(order_detail.unit_price * order_detail.quantity) AS total_order_amount
FROM 
    customer
JOIN 
    `order` ON customer.customer_id = `order`.customer_id
JOIN 
    order_detail ON `order`.order_id = order_detail.order_id
WHERE 
    YEAR(`order`.order_date) = 2015
GROUP BY 
    customer.customer_id, customer.company_name
HAVING 
    total_order_amount > 500
ORDER BY 
    customer.company_name;

-- WHERE YEAR(order.order_date) = 2015 filtrerar ordrar till de som är från år 2015.
-- HAVING total_order_amount > 500 ser till att endast kunder med en total orderbelopp över 500 visas.
-- GROUP BY: Grupperar datan på customer.customer_id och customer.customer_name.
-- SUM: Summerar kolumnen unit_price * quantity för varje kund.
-- HAVING: Filtrerar grupperade resultat för att endast inkludera kunder med en total orderbelopp över 500.
-- ORDER BY: Sorterar resultatet efter kundens namn i alfabetisk ordning.
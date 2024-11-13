/*
  demo1_transaktioner
*/

---------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE create_order_with_check()
BEGIN
    -- Börja en ny transaktion
    START TRANSACTION;

    -- Lägg till en ny order
    INSERT INTO `order` (customer_id, employee_id, order_date, ship_country)
    VALUES ('ALFKI', 5, CURDATE(), 'Sweden');

    -- Få order_id för den nya ordern
    SET @new_order_id = LAST_INSERT_ID();

    -- Lägg till produkter till ordern med kontroll av lager
    -- Kontrollera att det finns minst 10 enheter i lager för product_id = 1
    UPDATE product
    SET unit_in_stock = unit_in_stock - 10
    WHERE product_id = 1 AND unit_in_stock >= 10;

    -- Kontrollera om uppdateringen lyckades (lagerantalet var tillräckligt)
    IF ROW_COUNT() = 0 THEN
        -- Om det inte fanns tillräckligt lager, ångra hela transaktionen
        ROLLBACK;
        SELECT 'Lagerantal för lågt, transaktionen har ångrats.' AS resultat;
    ELSE
        -- Annars spara alla ändringar permanent
        COMMIT;
        SELECT 'Order skapad och produkter reserverade' AS resultat;
    END IF;
END //

DELIMITER ;

-- IF...THEN...END IF kan endast användas i lagrade program (som procedurer eller triggers). Sry för demospöke 🫣

---------------------------------------------------------------------------

-- Börja transaktionen
START TRANSACTION;

-- Steg 1: Uppdatera första orderdetaljen
UPDATE order_detail
SET quantity = quantity - 1
WHERE order_id = 10248 AND product_id = 11;

-- Sätt en återställningspunkt
SAVEPOINT step1;

-- Steg 2: Uppdatera nästa orderdetalj
UPDATE order_detail
SET quantity = quantity - 1
WHERE order_id = 10249 AND product_id = 42;

-- Sätt ytterligare en återställningspunkt
SAVEPOINT step2;

-- Anta att vi upptäcker ett problem och vill återgå till step1
ROLLBACK TO SAVEPOINT step1;

-- Fortsätt med andra operationer eller avsluta transaktionen
COMMIT;

---------------------------------------------------------------------------

/*
  START TRANSACTION börjar en ny transaktion.
  COMMIT sparar alla ändringar permanent.
  ROLLBACK ångrar alla ändringar om något går fel innan COMMIT.
  SAVEPOINT skapar återställningspunkter, vilket gör det möjligt att ångra specifika delar av en transaktion.
*/
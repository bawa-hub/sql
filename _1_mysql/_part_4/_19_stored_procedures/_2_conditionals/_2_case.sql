-- syntax
-- CASE case_value
--    WHEN when_value1 THEN statements
--    WHEN when_value2 THEN statements
--    ...
--    [ELSE else-statements]
-- END CASE;\


-- When the ELSE clause does not exist and the CASE cannot find any when_value equal to the case_value, it issues an error:
Case not found for CASE statement


DELIMITER $$

CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping       VARCHAR(50)
)
BEGIN
    DECLARE customerCountry VARCHAR(100);

SELECT 
    country
INTO customerCountry FROM
    customers
WHERE
    customerNumber = pCustomerNUmber;

    CASE customerCountry
		WHEN  'USA' THEN
		   SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN
		   SET pShipping = '3-day Shipping';
		ELSE
		   SET pShipping = '5-day Shipping';
	END CASE;
END$$

DELIMITER ;


CALL GetCustomerShipping(112,@shipping);
SELECT @shipping;
-- +----------------+
-- | @shipping      |
-- +----------------+
-- | 2-day Shipping |
-- +----------------+
-- 1 row in set (0.00 sec)


-- Searched CASE statement
-- CASE
--     WHEN search_condition1 THEN statements
--     WHEN search_condition1 THEN statements
--     ...
--     [ELSE else-statements]
-- END CASE;

DELIMITER $$

CREATE PROCEDURE GetDeliveryStatus(
	IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
)
BEGIN
	DECLARE waitingDay INT DEFAULT 0;
    SELECT 
		DATEDIFF(requiredDate, shippedDate)
	INTO waitingDay
	FROM orders
    WHERE orderNumber = pOrderNumber;
    
    CASE 
		WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN
			SET pDeliveryStatus = 'Very Late';
		ELSE
			SET pDeliveryStatus = 'No Information';
	END CASE;	
END$$
DELIMITER ;


CALL GetDeliveryStatus(10100,@delivery);
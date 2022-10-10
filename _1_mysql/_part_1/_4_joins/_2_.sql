-- returns order number, order status, and total sales from the orders and orderdetails tables using the INNER JOIN clause with the GROUP BYclause:

-- SELECT 
--     t1.orderNumber,
--     t1.status,
--     SUM(quantityOrdered * priceEach) total
-- FROM
--     orders t1
-- INNER JOIN orderdetails t2 
--     ON t1.orderNumber = t2.orderNumber
-- GROUP BY orderNumber;

-- or
SELECT 
    orderNumber,
    status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders
INNER JOIN orderdetails USING (orderNumber)
GROUP BY orderNumber;
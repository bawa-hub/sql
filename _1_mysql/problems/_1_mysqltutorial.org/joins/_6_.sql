-- use the LEFT JOIN clause to find all customers and their orders:

-- SELECT 
--     customers.customerNumber, 
--     customerName, 
--     orderNumber, 
--     status
-- FROM
--     customers
-- LEFT JOIN orders ON 
--     orders.customerNumber = customers.customerNumber;

-- or
SELECT
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber;  

-- or
-- SELECT
-- 	customerNumber,
-- 	customerName,
-- 	orderNumber,
-- 	status
-- FROM
-- 	customers
-- LEFT JOIN orders USING (customerNumber);
    
-- customers is the left table and orders is the right table
-- LEFT JOIN clause returns all customers including the customers who have no order. 
-- If a customer has no order, the values in the column orderNumber and status are NULL


-- If you replace the LEFT JOIN clause by the INNER JOIN clause, you will get the only customers who have at least one order
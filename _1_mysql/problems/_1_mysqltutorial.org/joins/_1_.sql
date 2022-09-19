-- select productCode and productName from the products table and textDescription of product lines from the productlines table

-- SELECT 
--     productCode, 
--     productName, 
--     textDescription
-- FROM
--     products t1
-- INNER JOIN productlines t2 
--     ON t1.productline = t2.productline;


-- shortcut
SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products
INNER JOIN productlines USING (productline);
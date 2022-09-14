-- Use the GROUP BY clause to group rows into subgroups.

SELECT 
    c1, c2,..., cn, aggregate_function(ci)
FROM
    table
WHERE
    where_conditions
GROUP BY c1 , c2,...,cn;

-- It works like the DISTINCT operator 

-- GROUP BY clause is often used with an aggregate function to perform calculations and 
-- return a single value for each subgroup.

-- GROUP BY clause vs. DISTINCT clause


-- Examples

-- A. Simple example
SELECT 
    status
FROM
    orders
GROUP BY status;

-- B. With aggregate function
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status;

SELECT 
    status, 
    SUM(quantityOrdered * priceEach) AS amount
FROM
    orders
INNER JOIN orderdetails 
    USING (orderNumber)
GROUP BY 
    status;

SELECT 
    orderNumber,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY 
    orderNumber;

-- C. With expression

-- D. With having

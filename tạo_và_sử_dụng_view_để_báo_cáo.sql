CREATE VIEW CustomerSales AS
SELECT customer_id,
       SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;

SELECT *
FROM CustomerSales
WHERE total_amount > 1000;

UPDATE CustomerSales
SET total_amount = 2000
WHERE customer_id = 1;
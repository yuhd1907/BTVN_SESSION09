CREATE
CLUSTERED INDEX IX_Products_CategoryId
ON Products (category_id);

CREATE INDEX IX_Products_Price
    ON Products (price);

CREATE INDEX IX_Products_Price
    ON Products (price);

SELECT *
FROM Products
WHERE category_id = X
ORDER BY price;
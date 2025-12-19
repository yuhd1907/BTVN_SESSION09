CREATE INDEX idx_customer_id ON Orders(customer_id);

SELECT * FROM Orders WHERE customer_id = 12345; -- Thay X bằng một ID cụ thể

SELECT * FROM Orders WHERE customer_id = 12345;
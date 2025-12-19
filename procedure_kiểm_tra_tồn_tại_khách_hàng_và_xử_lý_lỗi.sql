CREATE TABLE Customers
(
    customer_id INT PRIMARY KEY,
    name        VARCHAR(100),
    email       VARCHAR(100)
);

CREATE TABLE Orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers (customer_id),
    amount      NUMERIC,
    order_date  DATE DEFAULT CURRENT_DATE
);

CREATE OR REPLACE PROCEDURE add_order(
    p_customer_id INT,
    p_amount NUMERIC
)
    LANGUAGE plpgsql
AS
$$
DECLARE
    v_customer_exists BOOLEAN;
BEGIN
    -- 1. Kiểm tra xem customer_id có tồn tại trong bảng Customers không
    SELECT EXISTS(SELECT 1 FROM Customers WHERE customer_id = p_customer_id)
    INTO v_customer_exists;

    -- 2. Nếu không tồn tại, sử dụng RAISE EXCEPTION để báo lỗi
    IF NOT v_customer_exists THEN
        RAISE EXCEPTION 'Lỗi: Khách hàng có ID % không tồn tại trong hệ thống!', p_customer_id;
    END IF;

    -- 3. Nếu tồn tại, thêm bản ghi mới vào bảng Orders
    INSERT INTO Orders (customer_id, amount, order_date)
    VALUES (p_customer_id, p_amount, CURRENT_DATE);

    RAISE NOTICE 'Thêm đơn hàng thành công cho khách hàng ID %', p_customer_id;
END;
$$;

CALL add_order(1, 150.50); -- Giả sử ID 1 đã có trong bảng Customers

CALL add_order(999, 50.00);
-- Kết quả: ERROR: Lỗi: Khách hàng có ID 999 không tồn tại trong hệ thống!
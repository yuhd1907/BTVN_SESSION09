-- Tạo bảng Khách hàng
CREATE TABLE Customers (
                           customer_id INT PRIMARY KEY,
                           name VARCHAR(100),
                           email VARCHAR(100)
);

-- Tạo bảng Đơn hàng
CREATE TABLE Orders (
                        order_id SERIAL PRIMARY KEY, -- Tự động tăng ID đơn hàng
                        customer_id INT REFERENCES Customers(customer_id),
                        amount NUMERIC,
                        order_date DATE DEFAULT CURRENT_DATE
);

CREATE OR REPLACE PROCEDURE add_order(
    p_customer_id INT,
    p_amount NUMERIC
)
    LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_exists BOOLEAN;
BEGIN
    -- 1. Kiểm tra xem customer_id có tồn tại trong bảng Customers không
    SELECT EXISTS(SELECT 1 FROM Customers WHERE customer_id = p_customer_id)
    INTO v_customer_exists;

    -- 2. Nếu khách hàng không tồn tại, báo lỗi và dừng thực thi
    IF NOT v_customer_exists THEN
        RAISE EXCEPTION 'Khách hàng có ID % không tồn tại!', p_customer_id;
    END IF;

    -- 3. Nếu khách hàng tồn tại, thêm bản ghi mới vào bảng Orders
    INSERT INTO Orders (customer_id, amount, order_date)
    VALUES (p_customer_id, p_amount, CURRENT_DATE);

    -- Thông báo thành công (tùy chọn)
    RAISE NOTICE 'Đã thêm đơn hàng thành công cho khách hàng %', p_customer_id;
END;
$$;

INSERT INTO Customers (customer_id, name, email)
VALUES (1, 'Nguyễn Văn A', 'vana@example.com');

CALL add_order(1, 500000);
-- Kết quả: Đơn hàng sẽ được thêm vào bảng Orders thành công.
CALL add_order(99, 100000);
-- Kết quả: PostgreSQL sẽ báo lỗi "ERROR: Khách hàng có ID 99 không tồn tại!"
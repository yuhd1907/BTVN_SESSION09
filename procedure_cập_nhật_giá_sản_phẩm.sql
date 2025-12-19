CREATE OR REPLACE PROCEDURE update_product_price(
    p_category_id INT,
    p_increase_percent NUMERIC
)
    LANGUAGE plpgsql
AS $$
DECLARE
    r_prod RECORD; -- Biến record để lưu từng dòng sản phẩm
    v_new_price NUMERIC; -- Biến tính giá mới
BEGIN
    -- Sử dụng vòng lặp FOR để duyệt qua từng sản phẩm trong category_id
    FOR r_prod IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
        LOOP
            -- Tính toán giá mới: Giá mới = Giá cũ * (1 + % tăng / 100)
            v_new_price := r_prod.price * (1 + p_increase_percent / 100);

            -- Cập nhật lại giá cho sản phẩm đó
            UPDATE Products
            SET price = v_new_price
            WHERE product_id = r_prod.product_id;

            RAISE NOTICE 'Sản phẩm ID % đã cập nhật giá từ % lên %', r_prod.product_id, r_prod.price, v_new_price;
        END LOOP;
END;
$$;

CALL update_product_price(5, 10);

SELECT * FROM Products WHERE category_id = 5;
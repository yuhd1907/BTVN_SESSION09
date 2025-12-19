CREATE OR REPLACE PROCEDURE calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC
)
    LANGUAGE plpgsql
AS $$
BEGIN
    -- Tính tổng amount trong khoảng thời gian xác định và gán vào biến total
    SELECT COALESCE(SUM(amount), 0)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;

DO $$
    DECLARE
        v_total NUMERIC;
    BEGIN
        -- Gọi procedure với ngày mẫu
        CALL calculate_total_sales('2023-01-01', '2023-12-31', v_total);

        -- Hiển thị kết quả
        RAISE NOTICE 'Tổng doanh thu là: %', v_total;
    END $$;
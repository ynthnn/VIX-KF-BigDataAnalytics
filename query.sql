CREATE TABLE dataset_kimia_farma.kf_analisa3 AS
SELECT 
    ft.transaction_id, 
    ft.date, 
    ft.branch_id, 
    kc.branch_name, 
    kc.kota, 
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name, 
    pr.product_id, 
    pr.product_name,
    ft.price AS actual_price, 
    ft.discount_percentage, 
    ft.rating_customer,
    CASE
        WHEN ft.price <= 50000 THEN 0.1
        WHEN ft.price <= 100000 THEN 0.15
        WHEN ft.price <= 300000 THEN 0.2
        WHEN ft.price <= 500000 THEN 0.25
        ELSE 0.3
    END AS persentase_gross_laba,
    (ft.price - (ft.price * ft.discount_percentage)) AS nett_sales,
    (ft.price * (1 - ft.discount_percentage) * CASE
        WHEN ft.price <= 50000 THEN 0.1
        WHEN ft.price <= 100000 THEN 0.15
        WHEN ft.price <= 300000 THEN 0.2
        WHEN ft.price <= 500000 THEN 0.25
        ELSE 0.3
    END) AS nett_profit,
    kc.rating as rating_transaction


FROM dataset_kimia_farma.kf_final_transaction as ft
LEFT JOIN dataset_kimia_farma.kf_kantor_cabang as kc
  on ft.branch_id = kc.branch_id
RIGHT JOIN dataset_kimia_farma.kf_product as pr
  on ft.product_id = pr.product_id
;



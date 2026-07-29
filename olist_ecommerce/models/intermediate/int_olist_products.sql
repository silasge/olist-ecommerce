SELECT
    sp.product_id,
    LOWER(TRIM(STRIP_ACCENTS(sp.product_category_name))) AS product_category_name,
    sp.product_weight_g,
    sp.product_length_cm,
    sp.product_height_cm,
    sp.product_width_cm
FROM
    {{ ref("stg_olist__products") }} sp

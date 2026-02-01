SELECT
    A.customer_id,
    A.customer_unique_id,
    A.customer_city,
    A.customer_state,
    A.customer_zip_code_prefix,
    B.geolocation_lat,
    B.geolocation_lng
FROM 
    {{ ref("stg_olist__customers") }} A
LEFT JOIN
    {{ ref("stg_olist__geolocation") }} B
    ON A.customer_zip_code_prefix = B.geolocation_zip_code_prefix
SELECT
    sc.customer_id,
    sc.customer_unique_id,
    sc.customer_zip_code_prefix AS zip_code,
    LOWER(TRIM(STRIP_ACCENTS(sc.customer_city))) AS city,
    UPPER(TRIM(sc.customer_state)) AS state,
    sg.geolocation_lat AS lat,
    sg.geolocation_lng AS lng
FROM
    {{ ref("stg_olist__customers") }} sc
LEFT JOIN
    {{ ref("stg_olist__geolocation") }} sg
    ON sc.customer_zip_code_prefix = sg.geolocation_zip_code_prefix

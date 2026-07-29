SELECT
    ss.seller_id,
    ss.seller_zip_code_prefix AS zip_code,
    LOWER(TRIM(STRIP_ACCENTS(ss.seller_city))) AS city,
    UPPER(TRIM(ss.seller_state)) AS state,
    sg.geolocation_lat AS lat,
    sg.geolocation_lng AS lng
FROM
    {{ ref("stg_olist__sellers") }} ss
LEFT JOIN
    {{ ref("stg_olist__geolocation") }} sg
    ON ss.seller_zip_code_prefix = sg.geolocation_zip_code_prefix

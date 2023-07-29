Risiko dilihat dari skenario transaksi


with t_data AS (
    select 
        date_trunc('week', date(substr(mte(create_time,7),1,10))) AS date, 
        po_id, 
        type, 
        principal AS amount
    from (
        select 
            DISTINCT po_id, 
            uid, 
            pay_offs, 
            create_time, 
            principal, 
            type,
            app_type,id
    from hive.risk_analysis.shangqm_order_detail_history
    where status = 100
        and type in (1,2,9,38,32)
        and substr(mte(create_time,7),1,7) >='2021-01'
        and date_parse(create_date, '%Y-%m-%d') >= now() - INTERVAL '90' DAY + INTERVAL '7' HOUR
        and date_parse(create_date, '%Y-%m-%d') < date(now() + INTERVAL '7' HOUR)
    )
), 

t_lose as (
    select * from (
        select 
            cast(json_extract_scalar(external_info, '$.afi_order_id') as bigint) as afi_order_id, 
            type, 
            ROW_NUMBER() over(PARTITION BY asi_order_id ORDER BY complaint_datetime) Rn 
    FROM hive.risk_analysis.sw_ato_data_all_new
    WHERE type in ('1', '2', '9','38', '32')
        and status = 100
    )
    where Rn = 1
)

select 
    a.date, 
    case when a.type = 1 then 'Produk fisik dalam aplikasi'
    when a.type = 2 then 'Produk virtual dalam aplikasi'
    when a.type = 9 then 'Openpay'
    when a.type = 38 then 'barcode alfamart'
    when a.type = 32 then 'Scanpay QRIS' end as type_1, 
    cast(sum(if(c.afi_order_id is not null, amount)) as DOUBLE) as lose_amount, 
    sum(amount) as total_amount
from t_data a

left join t_lose c on a.po_id=c.afi_order_id

group by 1,2
merchant related bank rule

with table_1 as (
    select
    distinct ticket,  
    hasil_investigasi, 
    date_close, 
    c.vendor_id, 
    d.bank_account_no,
    vendorid
from (
    select * 
    from HIVE.RISK_ANALYSIS.ERIC_AF_CREATED_TICKET 
    where hasil_investigasi in ('Fraud Merchant-Cash Out') 
    and substr(date_close,1,7)  >= date_format(now()-INTERVAL '1' month,'%Y-%m')  )b
    
    left join 
        (select 
            case_order_id,
            vendor_id 
        from mysql_risk_cms.riskantifrauddb.r_case_target_vendor_info) c
    on b.ticket = c.case_order_id
    
    left join 
        (select
            vendor_id,
            bank_account_no 
        from hive.risk_analysis.hp_relate_vendor) d
    on cast (c.vendor_id as varchar) = d.vendor_id 

    left join 
        (select 
            vendor_id as vendorid,
            bank_account_no 
        from hive.risk_analysis.hp_relate_vendor) e
    on cast (d.bank_account_no as varchar) = e.bank_account_no ), 
    
table_2 as 
    (select 
        * 
    from hive.dwd.asi_order_info 
    where substring(mte(cast(to_unixtime(order_create_time)*1000 as bigint),7),1,10) >= date_format(now()-INTERVAL'90'day,'%Y-%m-%d')
    and if_pay_success = 1  and if_has_refunding = 0), 

table_3 as (
    select 
        ticket,
        hasil_investigasi, 
        date_close,
        vendor_id as vendor_source, --vendor_id?
        a.bank_account_no,
        vendorid as vendor_network,  --vendorid?
        total_merchant 
    from table_1 a

    left join 
        (select 
            bank_account_no, 
            count (vendorid) as total_merchant  
        from table_1 group by 1 ) b
    on a.bank_account_no = b.bank_account_no 
    where total_merchant >= 2 
),

table_5 as (
    select
        vendor_source,
        count (distinct vendor_network) as total_network 
    from table_3 group by 1 
), 

table_6 as (
    select 
        count (distinct vendor_source) as total_merchant 
    from table_3 \
)

select 
    a.vendor_source, 
    (select 
        count (distinct vendor_source) as total_merchant 
    from table_3) as total_merchant_source, 
    a.vendor_network, total_network, total_order
from table_3  a

left join table_5 b
on a.vendor_source = b.vendor_source

left join (
    select 
        vendor_id,
        count(distinct order_id) as total_order 
    from table_2 group by 1
) bb

on cast( bb.vendor_id as varchar) = a.vendor_network
having a.vendor_network  is not null

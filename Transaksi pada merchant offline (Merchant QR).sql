Transaksi pada merchant offline (Merchant QR)

SELECT 
    date(id_create_day) date,
    count(distinct risk_id) total_order_cnt,
    count(distinct case when strategy_rslt='Á÷³ÌÍ¨¹ý' then risk_id else null end) suc_order_cnt,
    count(distinct afi_uid) total_uid_cnt,
    count(distinct case when strategy_rslt='Á÷³ÌÍ¨¹ý' then afi_uid else null end) suc_uid_cnt,
    round(sum(cast(total_credit as double)/1000000),4) credit_juta,
    round(cast(sum(case when strategy_rslt='Á÷³ÌÍ¨¹ý' then cast(total_credit as double) else 0 end)/1000000 as double),4) suc_credit_juta,
    round(cast(sum(case when strategy_rslt='Á÷³ÌÍ¨¹ý' then cast(total_credit as double) else null end) as double)/sum(cast(total_credit as double)),4) credit_passrt,
    round(cast(count(distinct case when strategy_rslt='Á÷³ÌÍ¨¹ý' then afi_uid else null end) as double)/cast(count(distinct afi_uid) as double),4) uid_passrt,
    round(cast(count(distinct case when strategy_rslt='Á÷³ÌÍ¨¹ý' then risk_id else null end) as double)/cast(count(distinct risk_id) as double),4) order_passrt
FROM (
    select 
        risk_id,
        uid as afi_uid,
        is_pass,
        reject_node,
        keyaccount,
        substr(mte(create_time,7),1,10) as id_create_day,
        case 
            when reject_node in ('RULE|OFAF') then 'ÆÛÕ©¾Ü¾ø'
            when reject_node in ('A01','B01') then 'Ç°ÖÃ&×¼Èë¾Ü¾ø'
            when reject_node in('IX0|challenger') then 'ÐÅÓÃ¾Ü¾ø'
            when reject_node is not null then reject_node 
            else 'Á÷³ÌÍ¨¹ý' 
        end as strategy_rslt,
        open_pay_order_id as open_pay_order_idr,
        total_credit
    from (
        select * from hive.risk_analysis.zxy_offline_large_order_basic_new 
        where flow_id in ('RF374') 
            and substr(mte(create_time,7),1,10) >= date_format(now()-INTERVAL'90'day,'%Y-%m-d%') 
            and is_pass !=-1) a

    left join (
        select 
            store_id as toko_id, 
            merchant_agent_id 
        from mysql_asi_ec_openpay.openpaydb.t_open_pay_merchant_store_apply) b 

    on cast(a.store_id as bigint) = b.toko_id

    left join (
        select 
            merchant_agent_id as merchant_console_id,
            max(case when dict_name ='keyAccount' then value end) as keyaccount 
        from mysql_asi_ec_openpay.openpaydb.t_open_pay_merchant_apply_property 
        group by 1) c 

    on cast(b.merchant_agent_id as bigint) = c.merchant_console_id
)

where keyaccount is not null
GROUP BY 1 ORDER BY 1


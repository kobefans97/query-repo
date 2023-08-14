with my_table_xyz as
(
select
        cast(cast(mte(d.create_time,7) as timestamp) as date) as create_date,
        d.installment_order_id,
        d.uid,
        d.person_uuid,
        d.sup_bill_detail_id,
        d.monthly_installment_payment,
        d.periods,
        d.channel_id,
        fm.first_date,
        fm.first_month,
        fm.t_shouldpay,
        date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'), date(now())) as epd,
        sum(if(date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'),cast(substr(mte(hpaid.create_time,7),1,10) as date))<=10,hpaid.paid_up,0)) paid_up10,
        sum(if(date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'),cast(substr(mte(hpaid.create_time,7),1,10) as date))<=30,hpaid.paid_up,0)) paid_up30,
        sum(if(date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'),cast(substr(mte(hpaid.create_time,7),1,10) as date))<=60,hpaid.paid_up,0)) paid_up60
    from snap.afi_id_loan_t_afi_installment_sup_bill_detail d 

    left join snap.afi_id_loan_t_afi_installment_sup_bill_detail_repayment_record hpaid 
            on d.sup_bill_detail_id = hpaid.sup_bill_detail_id and hpaid.status = 1

    join (
        select 
            installment_order_id,
            min(repayment_date) as repayment_date,
            min(cast(date_parse(CAST(repayment_date AS varchar), '%Y%m%d') AS varchar)) as first_date,
            min(date_format(date_parse(CAST(repayment_date AS varchar), '%Y%m%d'), '%Y-%m')) as first_month,
            sum(monthly_installment_payment) t_shouldpay
        from snap.afi_id_loan_t_afi_installment_sup_bill_detail 
            where status not in (-1,110)
        group by 1
        ) fm 
        
        on d.installment_order_id=fm.installment_order_id and d.repayment_date=fm.repayment_date

    where channel_id = 501
    group by 1,2,3,4,5,6,7,8,9,10,11,12
),

calculated_data AS (
    SELECT 
        substr(cast(create_date as varchar), 1, 7) as order_month,
        t.uid,
        t.installment_order_id,
        t.epd,
        t.paid_up10,
        t.paid_up30,
        t.paid_up60,
        t.monthly_installment_payment,
        CASE WHEN t.epd > 10 AND t.paid_up10 < t.monthly_installment_payment THEN 1 ELSE 0 END AS def_10,
        CASE WHEN t.epd > 30 AND t.paid_up30 < t.monthly_installment_payment THEN 1 ELSE 0 END AS def_30,
        CASE WHEN t.epd > 60 AND t.paid_up60 < t.monthly_installment_payment THEN 1 ELSE 0 END AS def_60
    FROM my_table_xyz t

left join hive.snap_enc.afi_id_user_t_afi_installment_user u 
    on u.uid=t.uid and length(u.channel_uid) = 5 and u.channel_id =501

where substr(cast(create_date as varchar),1,7) >= date_format(now()+INTERVAL '7' HOUR-INTERVAL '1' YEAR, '%Y-%m') 
    and cast(cast(first_date as timestamp) as date) <= current_date - INTERVAL '1' day

)

SELECT
    order_month,
    COUNT(DISTINCT CASE WHEN def_10 = 1 THEN uid END) AS def_uid_10,
    COUNT(DISTINCT CASE WHEN def_30 = 1 THEN uid END) AS def_uid_30,
    COUNT(DISTINCT CASE WHEN def_60 = 1 THEN uid END) AS def_uid_60,
    COUNT(DISTINCT CASE WHEN epd > 10 THEN uid END) AS agr_uid_10,
    COUNT(DISTINCT CASE WHEN epd > 30 THEN uid END) AS agr_uid_30,
    COUNT(DISTINCT CASE WHEN epd > 60 THEN uid END) AS agr_uid_60,
    COUNT(DISTINCT CASE WHEN def_10 = 1 THEN installment_order_id END) AS def_poid_10,
    COUNT(DISTINCT CASE WHEN def_30 = 1 THEN installment_order_id END) AS def_poid_30,
    COUNT(DISTINCT CASE WHEN def_60 = 1 THEN installment_order_id END) AS def_poid_60,
    COUNT(DISTINCT CASE WHEN epd > 10 THEN installment_order_id END) AS agr_poid_10,
    COUNT(DISTINCT CASE WHEN epd > 30 THEN installment_order_id END) AS agr_poid_30,
    COUNT(DISTINCT CASE WHEN epd > 60 THEN installment_order_id END) AS agr_poid_60,
    CAST(SUM(def_10) * 1.0 / NULLIF(COUNT(DISTINCT CASE WHEN epd > 10 THEN uid END), 0) AS double) AS uid10,
    CAST(SUM(def_30) * 1.0 / NULLIF(COUNT(DISTINCT CASE WHEN epd > 30 THEN uid END), 0) AS double) AS uid30,
    CAST(SUM(def_60) * 1.0 / NULLIF(COUNT(DISTINCT CASE WHEN epd > 60 THEN uid END), 0) AS double) AS uid60,
    CAST(SUM(def_10) * 1.0 / NULLIF(COUNT(DISTINCT CASE WHEN epd > 10 THEN installment_order_id END), 0) AS double) AS poid10,
    CAST(SUM(def_30) * 1.0 / NULLIF(COUNT(DISTINCT CASE WHEN epd > 30 THEN installment_order_id END), 0) AS double) AS poid30,
    CAST(SUM(def_60) * 1.0 / NULLIF(COUNT(DISTINCT CASE WHEN epd > 60 THEN installment_order_id END), 0) AS double) AS poid60
FROM calculated_data


GROUP BY order_month
select 
    IF(order_month IS NULL, 'Total', order_month) order_month,
    count(DISTINCT if(t.epd>10 and t.paid_up10<t.monthly_installment_payment,t.uid)) def_uid_10,
    count(DISTINCT if(t.epd>30 and t.paid_up30<t.monthly_installment_payment,t.uid)) def_uid_30,
    count(DISTINCT if(t.epd>60 and t.paid_up60<t.monthly_installment_payment,t.uid)) def_uid_60,
    count(DISTINCT if(t.epd>10,t.uid)) as agr_uid_10,
    count(DISTINCT if(t.epd>30,t.uid)) as agr_uid_30,
    count(DISTINCT if(t.epd>60,t.uid)) as agr_uid_60,
    count(DISTINCT if(t.epd>10 and t.paid_up10<t.monthly_installment_payment,t.installment_order_id)) as def_poid_10,
    count(DISTINCT if(t.epd>30 and t.paid_up30<t.monthly_installment_payment,t.installment_order_id)) as def_poid_30,
    count(DISTINCT if(t.epd>60 and t.paid_up60<t.monthly_installment_payment,t.installment_order_id)) as def_poid_60,
    count(DISTINCT if(t.epd>10,t.installment_order_id)) agr_poid_10,
    count(DISTINCT if(t.epd>30,t.installment_order_id)) agr_poid_30,
    count(DISTINCT if(t.epd>60,t.installment_order_id)) agr_poid_60,
    cast(count(DISTINCT if(t.epd>10 and t.paid_up10<t.monthly_installment_payment,t.uid)) as double) / count(DISTINCT if(t.epd>10,t.uid)) uid10,
    cast(count(DISTINCT if(t.epd>30 and t.paid_up30<t.monthly_installment_payment,t.uid)) as double) / count(DISTINCT if(t.epd>30,t.uid)) uid30,
    cast(count(DISTINCT if(t.epd>60 and t.paid_up60<t.monthly_installment_payment,t.uid)) as double) / count(DISTINCT if(t.epd>60,t.uid)) uid60,
    cast(count(DISTINCT if(t.epd>10 and t.paid_up10<t.monthly_installment_payment,t.installment_order_id)) as double) / count(DISTINCT if(t.epd>10,t.installment_order_id)) poid10,
    cast(count(DISTINCT if(t.epd>30 and t.paid_up30<t.monthly_installment_payment,t.installment_order_id)) as double) / count(DISTINCT if(t.epd>30,t.installment_order_id)) poid30,
    cast(count(DISTINCT if(t.epd>60 and t.paid_up60<t.monthly_installment_payment,t.installment_order_id)) as double) / count(DISTINCT if(t.epd>60,t.installment_order_id)) poid60
from (
    select 
        d.installment_order_id,
        d.uid,
        d.person_uuid,
        d.sup_bill_detail_id,
        d.monthly_installment_payment,
        d.periods,
        fm.first_date,
        fm.first_month,
        fm.t_shouldpay,
        date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'), date(now())) as epd,
        sum(if(date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'),cast(substr(mte(hpaid.create_time,7),1,10) as date))<=10,hpaid.paid_up,0)) paid_up10,
        sum(if(date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'),cast(substr(mte(hpaid.create_time,7),1,10) as date))<=30,hpaid.paid_up,0)) paid_up30,
        sum(if(date_diff('day',date_parse(CAST(d.repayment_date AS varchar), '%Y%m%d'),cast(substr(mte(hpaid.create_time,7),1,10) as date))<=60,hpaid.paid_up,0)) paid_up60
    from snap.afi_id_loan_t_afi_installment_sup_bill_detail d 
   
    left join (
        select 
            o.installment_order_id,
            count(1) 
        from hive.snap.afi_id_loan_t_afi_loan_order l 
   
        left join hive.snap.afi_id_loan_t_afi_installment_order o 
            on o.loan_order_id =l.loan_order_id and o.product_id in (52, 57)
        
        where l."type"=2 and l.product_id in (52, 57)
        group by 1
    ) lo 
        on lo.installment_order_id=d.installment_order_id 
    
    left join snap.afi_id_loan_t_afi_installment_sup_bill_detail_repayment_record hpaid 
        on d.sup_bill_detail_id=hpaid.sup_bill_detail_id and hpaid.status=1
    
    join (
        select 
            installment_order_id,
            min(repayment_date) as repayment_date,
            min(cast(date_parse(CAST(repayment_date AS varchar), '%Y%m%d') AS varchar)) as first_date,
            min(date_format(date_parse(CAST(repayment_date AS varchar), '%Y%m%d'), '%Y-%m')) as first_month,
            sum(monthly_installment_payment) t_shouldpay
        from snap.afi_id_loan_t_afi_installment_sup_bill_detail 
        where product_id in (52, 57)
            and status not in (-1,110)
        group by 1
    ) fm 
    on d.installment_order_id=fm.installment_order_id and d.repayment_date=fm.repayment_date
  
    where d.product_id in (52, 57)
        and d.status not in (-1,110)
        and lo.installment_order_id is null
    group by 1,2,3,4,5,6,7,8,9,10
) t

left join (
    select 
        o.create_date,
        o.po_id,
        o.type,
        substr(o.create_date,1,7) as order_month
    from hive.risk_analysis.shangqm_order_detail_history o
    group by 1,2,3,4
) o 
on o.po_id=t.installment_order_id     

left join hive.snap_enc.afi_id_user_t_afi_installment_user u 
    on u.uid=t.uid and length(u.channel_uid) =5 and u.channel_id =511

where substr(o.create_date,1,7) >= date_format(now()+INTERVAL '7' HOUR-INTERVAL '1' YEAR, '%Y-%m') 
    and first_date <= cast(now() as varchar)
    and o.type in (1,2,111)
    and u.uid is NULL
group by GROUPING SETS((order_month), ()) order by 1
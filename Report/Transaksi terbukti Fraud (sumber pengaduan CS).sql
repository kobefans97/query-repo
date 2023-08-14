select date_parse(order_create_date, '%Y-%m-%d') date_time
,count(distinct if(status = 100, po_id)) poid
,count(distinct if(status = 100 and categoty_chiense='盗号', po_id)) poid_dh --Fraud - ATO
,count(distinct if(status = 100 and categoty_chiense='电诈', po_id)) poid_dz --Fraud - User Shared Password
,count(distinct if(status = 100 and categoty_chiense='伪冒', po_id)) poid_wm --Fraud Aplikasi
,cast(round(sum(if(status = 100, credit,0))/2222,0) as bigint) credit
,cast(round(sum(if(status = 100 and categoty_chiense='盗号', credit,0))/2222,0) as bigint) credit_dh
,cast(round(sum(if(status = 100 and categoty_chiense='电诈', credit,0))/2222,0) as bigint) credit_dz
,cast(round(sum(if(status = 100 and categoty_chiense='伪冒', credit,0))/2222,0) as bigint) credit_wm
from 
(
SELECT *, ROW_NUMBER() over(PARTITION BY asi_order_id ORDER BY complaint_datetime) Rn 
FROM hive.risk_analysis.sw_ato_data_all_new
)
WHERE try(date_parse(order_create_date, '%Y-%m-%d')) >= now() - INTERVAL '90' day + INTERVAL '7' HOUR
AND rn = 1
group by 1


select 
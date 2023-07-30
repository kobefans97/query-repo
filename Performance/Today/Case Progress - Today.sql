select 
    to_char(now()+interval '7' hour,'yyyy-mm-dd') as date,a.operator_name,
    sum(case when a.status in (1,22) and a.case_config_source_id = 1 and a.case_config_reason_id not in (7,10) then 1 else 0 end) as pending_user_case,
    sum(case when a.status in (1,22) and a.case_config_reason_id = 10 then 1 else 0 end) as pending_Release_freeze,
    sum(case when a.status in (1,22) and a.case_config_reason_id = 7 then 1 else 0 end) as pending_Pengkinian_name_nik,
    sum(case when a.status in (1,22) and a.case_config_source_id = 4  then 1 else 0 end) as pending_trigger,
    sum(case when a.status in (1,22) and a.case_config_source_id = 7  then 1 else 0 end) as pending_welcome_call,
    sum(case when a.status in (1,22) and a.case_config_source_id = 2  then 1 else 0 end) as pending_Credit_Analyst,
    sum(case when a.status in (1,22) and a.case_config_source_id not in (1,2,4,7)  then 1 else 0 end) as pending_other,
    sum(case when a.status in (1,22) and case_target = 1  then 1 else 0 end) as pending_Merchant_case,
    sum(case when a.status in (1,22)  then 1 else 0 end) as pending_total_case,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and a.case_config_source_id =1 and a.case_config_reason_id not in (7,10)  then 1 else 0 end) as selesai_user_case,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd')and a.status in(2,23) and a.case_config_reason_id =10  then 1 else 0 end) as selesai_Release_freeze,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and a.case_config_reason_id =7  then 1 else 0 end) as selesai_Pengkinian_name_nik,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and a.case_config_source_id =4  then 1 else 0 end) as selesai_trigger,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and a.case_config_source_id =7  then 1 else 0 end) as selesai_welcome_call,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and a.case_config_source_id =2  then 1 else 0 end) as selesai_Credit_Analyst,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and a.case_config_source_id not in (1,2,4,7)  then 1 else 0 end) as selesai_other,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23) and case_target=1  then 1 else 0 end) as selesai_Merchant_case,
    sum(case when substring(mte(a.close_time,7),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23)  then 1 else 0 end) as total_case,
    sum(case when substring(mte(a.create_time,8),1,10) = to_char(now()+interval '7' hour,'yyyy-mm-dd') then 1 else 0 end) as total_incoming_cases
from (
    select 
        distinct ticket,
        basket_sla,
        date_assign,
        date_create,
        Analyst,
        case_target
    from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET) o

left join (
    select 
        id,
        case_config_source_id,
        case_config_reason_id,
        case_config_clue_id,
        case_config_result_id,
        status, 
        create_time,
        close_time,
        operator_name 
    from mysql_risk_cms.riskantifrauddb.r_case_order
) a 

on o.ticket = a.id

left join (
    select 
        *, 
        row_number()over(partition by case_order_id,operator_uid order by create_time desc) as rn
	from mysql_risk_cms.riskantifrauddb.r_case_order_investigate_report_result 
) b 

on a.id=b.case_order_id and b.rn=1

where a.operator_name not in('qulltest','qtest','') 
    and a.operator_name in (
        select 
            distinct operator_name 
	    from mysql_risk_cms.riskantifrauddb.r_case_order
	    where date_diff('day',cast (substr(mte(update_time ,7),1,10) as date),cast (now() as date)) < = 1
    )
group by 1,2
order by 1,2
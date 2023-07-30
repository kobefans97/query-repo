select 
    to_char(now()+interval '7' hour,'yyyy-mm-dd') as date,
    b.ind_text as Issuer,
    sum(case when a.status in (1,22) then 1 else 0 end) as total_pending_cases,
    sum(case when substring(mte(a.close_time,7),1,10)=to_char(now()+interval '7' hour,'yyyy-mm-dd') and a.status in(2,23)   then 1 else 0 end) as Total_Done_investigation,
    sum(case when substring(mte(c.create_time,7),1,10)=to_char(now()+interval '7' hour,'yyyy-mm-dd') then 1 else 0 end) as total_incoming_cases
from (
    select 
        distinct ticket,
        basket_sla,
        date_assign,
        date_create,
        Analyst 
    from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET
) o

left join (
    select 
        id,
        case_config_source_id,
        case_config_reason_id,
        case_config_clue_id,
        case_config_result_id,
        status,
        create_time,
        close_time
    from mysql_risk_cms.riskantifrauddb.r_case_order
) a 

on o.ticket = a.id

left join mysql_risk_cms.riskantifrauddb.r_case_config_source b
    on a.case_config_source_id = b.id 

left join mysql_risk_cms.riskantifrauddb.r_case_log c
    on a.id=c.case_order_id and c.event_id=2

group by 1,2
order by 1,2
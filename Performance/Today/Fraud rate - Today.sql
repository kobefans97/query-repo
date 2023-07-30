select 
    substring(date_assign,1,10) as date,
    a.operator_name,
    sum(case when a.status=1 then 1 else 0 end) as Case_On_Progress,
    sum(case when a.status=2 then 1 else 0 end) as Case_done_investigation,
    sum(case when a.status=11 then 1 else 0 end) as  Case_QA_On_Progress,
    sum(case when a.status=12 then 1 else 0 end) as Case_QA_done_investigation,
    sum(case when a.status in (2,12,23,32) and coalesce (b.case_config_investigate_result_id,7) not in (7,9,10) then 1 end) as fraud_count,
    sum(case when a.status in (2,12,23,32) and coalesce (b.case_config_investigate_result_id,7)not in (7,9,10) then 1 end)*1.00 / sum(case when a.status in (2,12,23,31) then 1 else 0 end)*1.00 as fraud_rate			
from (
    select 
        distinct ticket,
        basket_sla,
        date_assign, 
        date_create,
        Analyst,
        case_target 
    from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET ) o

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
            operator_name,
            case_target
        from mysql_risk_cms.riskantifrauddb.r_case_order
    ) a 
    
    on o.ticket = a.id

    left join (
        select 
            *,
            row_number() over (partition by case_order_id,operator_uid order by create_time desc) as rn
		from mysql_risk_cms.riskantifrauddb.r_case_order_investigate_report_result 
	) b 
    
    on a.id = b.case_order_id and b.rn = 1

    where substring(date_assign,1,10) = date_format(now(),'%Y-%m-%d')
        and a.operator_name not in('qulltest','qtest') and a.status not in (0,21)--线上线下待分配
        and Analyst not in ('','leviana.sari','rita.fatiha','gilang.yulian','yudha.eka','bayu','sophia.tan')
group by 1,2
order by case_done_investigation desc
select 
    Total_Done_investigation  
from (
    select 
        date_assign,
        sum(case when basket_sla = 'On-Progress'  then 1 else 0 end) as Total_On_Progress_cases,
        sum(case when basket_sla not in ('On-Progress','Pending', '')  then 1 else 0 end) as  Total_Done_investigation,
        sum(case when basket_sla not in ('Pending', '')  then 1 else 0 end) as Total_cases
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
    
    where substring(date_assign,1,10) = date_format(now(),'%Y-%m-%d')
        and Analyst is not null and Analyst not in ('','leviana.sari','rita.fatiha','gilang.yulian','yudha.eka',
                                                        'bayu','sophia.tan')
    group by 1
    order by 1
)
select 
    count (distinct QA) as Total_QA 
from (
    select 
        Total_cases,
        QA 
    from (
        select 
            date_assign,
            QA,
            sum(case when basket_QA_sla = 'On-Progress'  then 1 else 0 end) as Total_On_Progress_cases,
            sum(case when basket_QA_sla not in ('On-Progress','Pending', '')  then 1 else 0 end) as  Total_Done_investigation,
            sum(case when basket_QA_sla not in ('Pending', '')  then 1 else 0 end) as Total_cases
        from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET o
        
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
            from mysql_risk_cms.riskantifrauddb.r_case_order) a 
        
        on o.ticket = a.id
        
        where substring(date_qa,1,10) = date_format(now(),'%Y-%m-%d')
            and Analyst is not null
        group by 1, 2 
        order by 1 ,2
    )
    where Total_cases <> 0 and QA not in ('','leviana.sari','rita.fatiha','gilang.yulian','yudha.eka','bayu','sophia.tan')
)
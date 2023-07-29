select 
    count (distinct Analyst) + count (distinct QA) as Total_Analyst
from (
    select 
        distinct ticket,
        basket_sla,
        date_assign, 
        date_create,
        Analyst,
        qa,
        case_target 
    from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET 
) a
where basket_sla in ('On-Progress')
and Analyst not in ('','leviana.sari','rita.fatiha','gilang.yulian','yudha.eka','bayu','sophia.tan','nining',
                        'suyudi','sapriyanti')
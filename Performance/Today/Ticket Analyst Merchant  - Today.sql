select 
    date_assign, 
    Analyst,
    sum(case when basket_sla = 'On-Progress'  then 1 else 0 end) as Total_OnProgress_cases,
    sum(case when basket_sla not in ('On-Progress','Pending', '')  then 1 else 0 end) as  Total_Done_investigation,
    sum(case when basket_sla not in ('Pending', '')  then 1 else 0 end) as Total_cases
from (
    select 
        distinct ticket, 
        basket_sla,
        date_assign,
        Analyst from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET
    ) o

left join (
    select 
        distinct id, 
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
    and Analyst is not null 
    and Analyst not in ('','leviana.sari','rita.fatiha','gilang.yulian','yudha.eka','bayu','sophia.tan')
    and Analyst in ('mery.yalestri', 'rhomantino.rizal','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana',
                    'achmad.ardi','yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah')
group by 1,2
order by 1,2
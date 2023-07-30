SELECT  
    date_create, 
    source_issue,
    nama_Case,
    Assigment, 
    count(distinct ticket) as total_ticket
from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET 
where substring(date_create,1,10) = date_format(now(),'%Y-%m-%d') --and CASE_target = 0
    and Basket_SLA = 'On-Progress'
group by 1,2,3,4
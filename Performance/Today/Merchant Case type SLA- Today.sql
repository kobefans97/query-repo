select 
    distinct ticket,
    source_issue,
    Assigment,
    nama_case,
    analyst,
    date_assign,
    cast(SLA as bigint) as SLA,
    Case_Group from HIVE.RISK_ANALYSIS.ERIC_AF_CREATED_TICKET 
where date_assign = date_format(now(),'%Y-%m-%d')
    and Analyst in ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana',
                        'achmad.ardi','yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')
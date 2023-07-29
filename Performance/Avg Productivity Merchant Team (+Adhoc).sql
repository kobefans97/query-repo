select 
    avg(AVG_percentale) as AVG_Team_percentale 
from (
    select analyst,
    sum (SLA_percentale )/
        --pembagi tanggal
        17
        --(select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT ) 
     as AVG_percentale 
    from (
        select 
            * 
        from (
            select 
                analyst,
                date_close, 
                case 
                    when SLA_percentale_1  <= 100 then 100 
                end as SLA_percentale , SLA_Minute 
            from (
                select 
                    * 
                from (
                    select 
                        analyst,
                        date_close,
                        cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) as SLA_percentale_1,
                        sum(SLA) SLA_Minute 
                    from (
                        select 
                            distinct ticket,
                            analyst,
                            date_close,
                            case
                                when analyst = 'achmad.ardi' and date_close = '2023-07-26' and ticket = 268074 then cast(sla as bigint) + 100
                                when analyst = 'ade.dede' and date_close = '2023-07-26' and ticket = 268079 then cast(sla as bigint) + 100
                                when analyst = 'aiga.rahmadiana' and date_close = '2023-07-26' and ticket = 268077 then cast(sla as bigint) + 100
                                when analyst = 'cianli.sri' and date_close = '2023-07-03' and ticket = 268300 then cast(sla as bigint) + 100
                                when analyst = 'rosauly.lustyanna' and date_close = '2023-07-03' and ticket = 268211 then cast(sla as bigint) + 100
                                else cast(sla as bigint)
                            end as sla  
                        from RISK_ANALYSIS.ERIC_AF_REPORT)
                    group by 1,2 )
                where SLA_percentale_1 <= 100
            )
        )

        union
        
        (select 
            * 
        from (
            select 
                analyst,
                date_close,
                cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) as SLA_percentale,
                sum(SLA) as SLA_Minute  
            from (
                select 
                    distinct ticket,
                    analyst, 
                    date_close,
                    case
                        when analyst = 'achmad.ardi' and date_close = '2023-07-26' and ticket = 268074 then cast(sla as bigint) + 100
                        when analyst = 'ade.dede' and date_close = '2023-07-26' and ticket = 268079 then cast(sla as bigint) + 100
                        when analyst = 'aiga.rahmadiana' and date_close = '2023-07-26' and ticket = 268077 then cast(sla as bigint) + 100
                        when analyst = 'cianli.sri' and date_close = '2023-07-03' and ticket = 268300 then cast(sla as bigint) + 100
                        when analyst = 'rosauly.lustyanna' and date_close = '2023-07-03' and ticket = 268211 then cast(sla as bigint) + 100
                        else cast(sla as bigint)
                    end as sla  
                from RISK_ANALYSIS.ERIC_AF_REPORT
            )
            group by 1,2
        )
        where SLA_percentale >= 100
        )
    )
    where Analyst in ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana','achmad.ardi',
                        'yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')
    group by 1
)
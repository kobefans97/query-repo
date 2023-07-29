--Summary KPI Merchant Analyst 2
select 
    distinct aa.analyst,
    total_absensi,
    AVG_SLA,
    total_is_suspect,
    case 
        when aa.analyst in ('kondisi peng exclude') then 0.00
    else COALESCE(total_finding_value, 0.00) - COALESCE(is_wrong_qa +  Appeal , 0.00) end as total_finding_value
from (
    select 
        a.analyst,
        total_absensi,
        total_day,
        c.AVG_percentale,
        a.sla as AVG_SLA, 
        date_close,
        SLA_Minute,
        SLA_percentale 
    from (
        select 
            analyst,
            (select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT) as total_day, 
            sum(SLA)/
                --pembagi tanggal
                17
                --(select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT ) 
                as SLA, 
            count(distinct date_close) as total_absensi 
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
        group by 1) a

    left join (
        select 
            * 
        from (
            select 
                analyst,
                date_close, 
                case 
                    when SLA_percentale_1  <= 100 then 100 
                end as SLA_percentale, 
                SLA_Minute 
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
                group by 1,2 
                )
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
            group by 1,2)
        where SLA_percentale >= 100)
--
        ) b

    on a.analyst = b.analyst

    left join (
        select 
            analyst, 
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
                    end as SLA_percentale, 
                    SLA_Minute 
                from (
                    select 
                        * 
                    from (
                        select 
                            analyst,
                            date_close, 
                            cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) as SLA_percentale_1,
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
                            from RISK_ANALYSIS.ERIC_AF_REPORT)
                        group by 1,2
                    )
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
        group by 1
    ) c

    on a.analyst = c.analyst) aa

    left join (
        select 
            analyst,
            sum(is_suspect) + sum(Is_Suspect_add) as total_is_suspect 
        from (
            select 
                analyst,
                case 
                    when lower(is_suspect_1) in ('n' ,'NO','no','','-') or is_suspect_1  is null  then 0 
                    else 1 
                end as is_suspect, Is_Suspect_add 
            from (
                select 
                    distinct ticket,
                    analyst,
                    Is_Suspect_add,
                    trim(substring(is_suspect, 17)) as is_suspect_1 
                from RISK_ANALYSIS.ERIC_AF_REPORT
                where is_suspect is not null or Is_Suspect_add = 1
            )
        )
        group by 1 
    ) b

    on aa.analyst = b.analyst 


    left join (
        select 
            analyst,
            sum(finding_value) as total_finding_value,
            sum(wrong_qa) as is_wrong_qa, 
            sum(Appeal) as Appeal 
        from(
            select 
                distinct ticket,
                analyst,
                MAX(case 
                        when finding_action = 1 then 1 
                        when result_finding_qa = 1 then 1
                        when cashout_indication_finding_qa = 1 then 0.25
                        when evidence_correct_finding_qa = 1 then 0.25
                        when user_suspect_fraudster_finding_qa = 1 then 0.25
                        when content_finding_qa = 1 then 0.25
                        when qa_analyst_finding = 1 then 0.25
                        when finding_add_A= 1 then 1
                        when finding_add_B= 1 then 0.25 else 0
                end) as finding_value,
                MAX(case 
                        when is_wrong_qa = 1 and  finding_action = 1  then 1
                        when is_wrong_qa = 1  and result_finding_qa = 1 then 1
                        when is_wrong_qa = 1  and cashout_indication_finding_qa = 1 then 0.25
                        when is_wrong_qa = 1  and evidence_correct_finding_qa = 1 then 0.25
                        when is_wrong_qa = 1  and user_suspect_fraudster_finding_qa = 1 then 0.25
                        when is_wrong_qa = 1  and content_finding_qa = 1 then 0.25
                        when is_wrong_qa = 1  and  qa_analyst_finding = 1 then 0.25
                        when is_wrong_qa = 1  and finding_add_A= 1 then 1
                        when is_wrong_qa = 1  and finding_add_B= 1 then 0.25 else 0
                end) as wrong_qa,
                MAX(case 
                        when  Appeal = 1 and  finding_action = 1  then 1
                        when  Appeal = 1 and result_finding_qa = 1 then 1
                        when  Appeal = 1 and cashout_indication_finding_qa = 1 then 0.25
                        when  Appeal = 1 and evidence_correct_finding_qa = 1 then 0.25
                        when  Appeal = 1 and user_suspect_fraudster_finding_qa = 1 then 0.25
                        when  Appeal = 1 and content_finding_qa = 1 then 0.25
                        when  Appeal = 1 and  qa_analyst_finding = 1 then 0.25
                        when  Appeal = 1 and finding_add_A= 1 then 1
                        when  Appeal = 1 and finding_add_B= 1 then 0.25 else 0
                end) as Appeal 
            from RISK_ANALYSIS.ERIC_AF_REPORT_QA
            where finding_add_A = 1 or finding_add_B= 1 or any_finding_qa = 1 and revision = 0 and qa not in ('sapriyanti' , 'suyudi', 'antonius' , 'nining')
                or Is_Wrong_QA = 1 or Appeal = 1 group by 1,2
        )
        group by 1
    ) c
    
    on aa.analyst = c.analyst 

where aa.analyst in ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana','achmad.ardi',
                    'yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')

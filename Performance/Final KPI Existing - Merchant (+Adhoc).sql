--Final KPI Merchant (Existing)

with z as (
    select 
        avg(AVG_percentale) as AVG_percentale 
    from (
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
                    from RISK_ANALYSIS.ERIC_AF_REPORT)
                group by 1,2
            )
            
            where SLA_percentale >= 100)
        )

    where Analyst in ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana',
                        'achmad.ardi','yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')
    group by 1)
),

cnt_analyst as (
    select 
        count (distinct analyst) as cnt_analyst  
    from RISK_ANALYSIS.ERIC_AF_REPORT 
    where Analyst in ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana',
                        'achmad.ardi','yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')
)


select 
    * , 
    case 
        when total_KPI >= 100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES'  then 'LEVEL 3'
        when total_KPI >=95 and total_KPI < 100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team= 'YES' then 'LEVEL 2'
        when total_KPI >=90 and total_KPI < 95  and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES' then 'LEVEL 1' else '-' end as Level ,
    case 
        when total_KPI >= 100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES'  then 'Rp.1.200.000'
        when total_KPI >=95 and total_KPI <100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES' then 'Rp.800.000'
        when total_KPI >= 90 and total_KPI < 95 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES' then 'Rp.400.000' else 'Rp.0' end as Insentive 
from (
    select 
        Analyst,
        Total_hari_kerja,
        Produktifitas_percentage,
        Kualitas_percentage,
        Pendalaman,
        Sikap,
        Absensi,
        total_KPI,
    case 
        when AVG_Produktivitas > Produktifitas_team  then 'YES' else 'NO' 
    end as Produktifitas_Avg_team ,
    case 
        when AVG_kualitas < Kualitas_avg_team or AVG_kualitas  is null then 'YES' else 'NO' 
    end as Kualitas_Avg_team
    from (
        select 
            Analyst,
            Total_hari_kerja,
            Produktifitas_percentage,
            Kualitas_percentage,
            Pendalaman,
            Sikap,
            Absensi,
            AVG(Produktifitas) as AVG_Produktivitas,
            AVG(total_finding_value) as AVG_kualitas,
            Produktifitas_percentage+Kualitas_percentage+Pendalaman+Sikap+Absensi as total_KPI,
            (select 
                (sum 
                    (case 
                        when analyst in ('kondisi peng exclude')  then 0.00
                        else COALESCE(finding_value, 0.00) - COALESCE(wrong_qa + Appeal, 0.00) end 
                    )
                ) / (select * from cnt_analyst ) as AVG_team_finding 
            from (
                select 
                    distinct ticket,
                    analyst, 
                    MAX (case 
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
                    MAX (case 
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
                            when  Appeal = 1 and qa_analyst_finding = 1 then 0.25
                            when  Appeal = 1 and finding_add_A= 1 then 1
                            when  Appeal = 1 and finding_add_B= 1 then 0.25 else 0
                        end) as Appeal 
                from RISK_ANALYSIS.ERIC_AF_REPORT_QA
                where any_finding_qa = 1 and revision = 0 and qa not in ('sapriyanti' , 'suyudi', 'antonius' , 'nining') or Is_Wrong_QA = 1 or Appeal = 1 group by 1,2
            )
            where Analyst in ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana','achmad.ardi',
                                'yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')
            ) as Kualitas_avg_team, 
            (select AVG_percentale from z) as Produktifitas_team
        from (
            select 
                Analyst,
                Total_hari_kerja, 
                case 
                    when (Produktiifitas*40)/100 >= 40 then 40
                    when (Produktiifitas*40)/100 < 40 and (Produktiifitas*35)/100 > 0 then (Produktiifitas*40)/100
                    else 0 
                end as Produktifitas_percentage,
                case 
                    when (Kualitas*45)/100 >= 45 then 45
                    when (Kualitas*45)/100 < 45 and (Kualitas*45)/100 > 0 then (Kualitas*45)/100
                    else 0 
                end as Kualitas_percentage,
                Pendalaman, 
                Sikap,
                Absensi,
                Produktiifitas as Produktifitas, 
                total_finding_value 
            from (
                select 
                    analyst as Analyst,
                    total_absensi as Total_hari_kerja,
                    AVG_percentale as Produktiifitas,
                    case 
                        when total_finding_value <= 0  or total_finding_value  is null or total_finding_value  = 0 then 100 
                        when total_finding_value > 0 and total_finding_value <= 1 then 95
                        when total_finding_value > 1 and total_finding_value <= 2 then 90
                        when total_finding_value > 2 and total_finding_value <= 5 then 80
                        when total_finding_value > 5 and total_finding_value <= 10 then 70
                        when total_finding_value > 10 and total_finding_value <= 15 then 60
                        when total_finding_value > 15 then 0 
                    end as Kualitas,
                    case 
                        when total_is_suspect <= 2 or total_is_suspect  is null then 0.00
                        when total_is_suspect > 2 and total_is_suspect <= 5 then 0.70
                        when total_is_suspect > 5 and total_is_suspect <= 8 then 1.40
                        when total_is_suspect > 8 and total_is_suspect <= 11 then 2.10
                        when total_is_suspect > 11 and total_is_suspect <= 14 then 2.80
                        when total_is_suspect > 14 and total_is_suspect <= 17 then 3.50
                        when total_is_suspect > 17 and total_is_suspect <= 20 then 4.20
                        when total_is_suspect > 20 then 5.00 
                    end as Pendalaman,
                    case 
                        when analyst in ('') then 0.00
                        else 5 
                    end as Sikap,
                    case 
                        when analyst in ('rhomantino.rizal','naufal.riskiansyah') then 4.41
                        when analyst in ('nurul.afianti') then 4.71
                        else 5 
                    end as Absensi,
                    total_finding_value
                from (
                    select 
                        distinct aa.analyst,
                        total_absensi,
                        AVG_percentale,
                        total_is_suspect,
                        case 
                            when aa.analyst in ('kondisi peng exclude') then 0.00
                            else COALESCE(total_finding_value, 0.00) - COALESCE(is_wrong_qa, 0.00) 
                        end as total_finding_value,
                        AVG_SLA 
                    from (
                        select 
                            a.analyst,
                            total_absensi,
                            total_day,
                            c.AVG_percentale,
                            a.sla as AVG_SLA,
                            date_close, --DISINI DITAMBAHIN ADD HOCNYA
                                        /*
                                        case
                                                when a.analyst = 'achmad.ardi' and date_close = '2023-07-03' then SLA_Minute + 100
                                                when a.analyst = 'naufal.riskiansyah' and date_close = '2023-07-03' then SLA_Minute + 150    
                                                else SLA_Minute
                                            end as SLA_Minute,
                                        */
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
                                from RISK_ANALYSIS.ERIC_AF_REPORT
                            )
                        group by 1
                        ) a

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
                        ) b
                        on a.analyst = b.analyst

                        left join ( 
                            select 
                                analyst , 
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
                                    end as is_suspect, 
                                    Is_Suspect_add 
                                from (
                                    select 
                                        distinct ticket,
                                        analyst,
                                        Is_Suspect_add,
                                        trim(substring(is_suspect, 17)) as is_suspect_1 
                                    from RISK_ANALYSIS.ERIC_AF_REPORT
                                    where is_suspect is not null 
                                        or Is_Suspect_add = 1 
                                )
                            )
                            group by 1 
                        ) b
                        
                        on aa.analyst = b.analyst 

                        left join (
                            select 
                                analyst,
                                sum (finding_value) as total_finding_value,
                                sum (wrong_qa) as is_wrong_qa 
                            from ( 
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
                                            when finding_add_B= 1 then 0.25
                                        end) as finding_value,
                                    MAX(case 
                                            when  Appeal = 1 and  finding_action = 1  then 1
                                            when is_wrong_qa = 1 and  finding_action = 1  then 1
                                            when is_wrong_qa = 1 and result_finding_qa = 1 then 1
                                            when is_wrong_qa = 1 and cashout_indication_finding_qa = 1 then 0.25
                                            when is_wrong_qa = 1 and evidence_correct_finding_qa = 1 then 0.25
                                            when is_wrong_qa = 1 and user_suspect_fraudster_finding_qa = 1 then 0.25
                                            when is_wrong_qa = 1 and content_finding_qa = 1 then 0.25
                                            when is_wrong_qa = 1 and qa_analyst_finding = 1 then 0.25
                                            when is_wrong_qa = 1 and finding_add_A= 1 then 1
                                            when is_wrong_qa = 1 and finding_add_B= 1 then 0.25
                                        end) as wrong_qa 
                                from RISK_ANALYSIS.ERIC_AF_REPORT_QA
                                where finding_add_A = 1 
                                    or finding_add_B= 1 
                                    or any_finding_qa = 1 
                                    and revision = 0 
                                    and qa not in ('sapriyanti' , 'suyudi', 'antonius' , 'nining')
                                    or Is_Wrong_QA = 1 or Appeal = 1 group by 1,2
                            )
                            group by 1
                        ) c


                        on aa.analyst = c.analyst 

                    where aa.Analyst in  ('mery.yalestri','m.affandi','nurul.afianti','ade.dede','luthfi.dwiki','aiga.rahmadiana','achmad.ardi',
                                            'yogge.andreade','rosauly.lustyanna','cianli.sri','naufal.riskiansyah','rhomantino.rizal')
                )
            )
        )
        group by 1,2,3,4,5,6,7
    )
)

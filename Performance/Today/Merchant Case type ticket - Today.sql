
with A as (select 
    a.*,
    case 
            when cast (b.vendor_id as varchar ) = a.channel_uid then 'YES'
            when cast (e.userid as varchar ) = a.channel_uid then 'YES' 
        end Is_Parent , 
        c.cashout_indication_finding_QA ,
        c.evidence_correct_finding_QA ,
        c.user_suspect_fraudster_finding_QA ,
        c.content_finding_QA ,
        c.QA_Analyst_Finding ,
        c.result_finding_QA ,
        c.any_finding_QA ,
        c.Revision,
        backgroud_case 
    from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET a

    left join (
        select 
            case_order_id as case_1, 
            vendor_id
        from mysql_risk_cms.riskantifrauddb.r_case_target_vendor_info
    ) b
    
    on a.ticket = b.case_1

    left join (
        select 
            case_order_id as case_2, 
            channel_uid as userid 
        from mysql_risk_cms.riskantifrauddb.r_case_target_user_info
    ) e
    
    on a.ticket = e.case_2

    left join (
        select 
            r.case_order_id, 
            r.channel_uid, 
            r1.operator_name as oline_operator, 
            qa, 
            date_qa, 
            max (
                distinct case when r.channel_uid = r1.channel_uid 
                and r.is_get_cash <> r1.is_get_cash then 1 else 0 end
            ) as cashout_indication_finding_QA, 
            max (
                distinct case when r.channel_uid = r1.channel_uid 
                and r.is_evidence_correct <> r1.is_evidence_correct then 1 else 0 end
            ) as evidence_correct_finding_QA, 
            max (
                distinct case when r.channel_uid = r1.channel_uid 
                and r.is_cheat <> r1.is_cheat then 1 else 0 end
            ) as user_suspect_fraudster_finding_QA, 
            max (
                distinct case when j.operator_name <> j1.name_qa then 1 else 0 end
            ) as content_finding_QA, 
            max (
                distinct case when x.Is_finding = '1' then 1 else 0 end
            ) as QA_Analyst_Finding, 
            max (
                distinct case when category_finding in (
                    'Freeze', 'Blacklist', 'Freeze & Blacklist'
                ) then 1 else 0 end
            ) as Finding_Action, 
            max (
                distinct case when r.channel_uid = r1.channel_uid 
                and r.case_config_investigate_result_id <> r1.case_config_investigate_result_id then 1 else 0 end
                ) as result_finding_QA, 
            max (
                distinct case when r.channel_uid = r1.channel_uid 
                and (
                    r.is_get_cash <> r1.is_get_cash 
                    or r.is_evidence_correct <> r1.is_evidence_correct 
                    or r.is_cheat <> r1.is_cheat 
                    or j.operator_name <> j1.name_qa 
                    or x.Is_finding = '1' 
                    or x.Is_finding = '2' 
                    or r.case_config_investigate_result_id <> r1.case_config_investigate_result_id 
                    or category_finding in (
                    'Freeze', 'Blacklist', 'Freeze & Blacklist'
                    )
                ) then 1 else 0 end
            ) as any_finding_qa, 
            max (
                distinct case when x.Is_finding = '2' then 1 else 0 end
            ) as Revision 
        from (
            select 
                distinct ticket,
                basket_sla,
                date_assign, 
                date_create,
                Analyst,
                qa,
                date_qa,
                category_finding
            from RISK_ANALYSIS.ERIC_AF_CREATED_TICKET 
        ) a
     
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
        ) o 
        
        on a.ticket = o.id
        
        join mysql_risk_cms.riskantifrauddb.r_case_order_investigate_report_result r 
        on r.case_order_id = o.id and r.case_type = 3 
    
        join mysql_risk_cms.riskantifrauddb.r_case_order_investigate_report_result r1 
            on r1.case_order_id = o.id and r1.case_type = 1 
        
        left join (
            select 
                distinct case_order_id, 
                operator_name 
            from 
                mysql_risk_cms.riskantifrauddb.r_case_order_investigate_report_step 
            where 
                case_type = 1
        ) j 
        
        on a.ticket = j.case_order_id 
        
        left join (
            select 
                distinct case_order_id, 
                operator_name as name_qa 
            from 
                mysql_risk_cms.riskantifrauddb.r_case_order_investigate_report_step 
            where 
                case_type = 3
        ) j1 
        
        on a.ticket = j1.case_order_id 
        
        left join (
            select 
                case_order_id, 
                regexp_extract(remark_text, '^(\d+)') as Is_finding 
            from 
                mysql_risk_cms.riskantifrauddb.r_case_order_remark_info 
            where 
                case_type = 3 
                and remark_type = 0
        ) x 
        
        on a.ticket = x.case_order_id 
        
        where status = 12 
            and cast (substr(mte(r.UPDATE_time, 7), 1, 10) as VARCHAR) = date_format(now(), '%Y-%m-%d') 
        group by 1, 2, 3, 4, 5 
        
        HAVING max(
            distinct case 
                when r.channel_uid = r1.channel_uid and (r.is_get_cash <> r1.is_get_cash 
                                                            or r.is_evidence_correct <> r1.is_evidence_correct 
                                                            or r.is_cheat <> r1.is_cheat 
                                                            or j.operator_name <> j1.name_qa 
                                                            or x.Is_finding = '1' 
                                                            or x.Is_finding = '2' 
                                                            or r.case_config_investigate_result_id <> r1.case_config_investigate_result_id 
                                                            or category_finding in ('Freeze', 'Blacklist', 'Freeze & Blacklist')
                                                        ) then 1 
                else 0 end
            ) = 1 


        order by 3
    ) c
    
    on a.ticket = c.case_order_id
    
    left join (
        select 
            case_order_id,
            remark_text as backgroud_case 
        from mysql_risk_cms.riskantifrauddb.r_case_order_remark_info 
        where case_type = 0 and remark_type = 0
    ) d
    
    on a.ticket = d.case_order_id 
    
    where a.date_assign = date_format(now(),'%Y-%m-%d')
    
    order by ticket asc 
)



select DISTINCT ticket , source_issue ,Assigment, nama_case ,analyst , date_assign, SLA ,Case_Group from A where Analyst in ('mery.yalestri',
'm.affandi',
'nurul.afianti',
'ade.dede',
'luthfi.dwiki',
'aiga.rahmadiana',
'achmad.ardi',
'yogge.andreade',
'rosauly.lustyanna',
'cianli.sri',
'naufal.riskiansyah',
'rhomantino.rizal')
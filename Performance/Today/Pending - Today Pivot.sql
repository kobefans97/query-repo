select 
    Case_source as source_issue, 
    config_reason as Assigment, 
    config_clue as nama_Case,
    date (date_create) as date, 
    count (distinct ticket) as total_Pending 
from  (
    select 
        * 
    from (
        select 
            ticket,	
            Issuer_tiket,
            analyst_3 as analyst,
            QA,
            SPV,
            date_create,
            date_assign,
            date_assign_2,
            date_close,
            date_QA,
            create_time,
            assign_time,
            assign_time_2,
            close_time,
            QA_time,
            SLA_second,
            SLA_QA_second,
            basket_SLA,
            basket_QA_SLA,
            vendor_id
        from (
            select 
                * 
            from (
                select 
                    *,
                    analyst_2 as analyst_3  
                from (
                    select 
                        *, 
                        case
                            when SLA_second >= 0 and SLA_second <= 86399 then '<24 hours'
                            when SLA_second >= 86399 and SLA_second <= 	172800 then '24-48 hours'
                            when SLA_second >= 172801 and SLA_second <= 259200 then '48-72 hours'
                            when SLA_second >= 259201 then 'Over_SLA'
                            when date_assign is null then 'Pending'
                            when date_assign >= ('2021-12-31') and SLA_second is null then 'On-Progress'
                            else 'ticket_not_found' end basket_SLA ,
                            case when SLA_QA_second >= 0 and SLA_QA_second <= 86399 then '<24 hours'
                            when SLA_QA_second >= 86399 and SLA_QA_second <= 	172800 then '24-48 hours'
                            when SLA_QA_second >= 172801 and SLA_QA_second <= 259200 then '48-72 hours'
                            when SLA_QA_second >= 259201 then 'Over_SLA'
                            when date_assign is null then 'Pending'
                            when date_assign >= ('2021-12-31') and SLA_QA_second is null then 'On-Progress'
                            else 'ticket_not_found' 
                        end basket_QA_SLA 
                    from (
                        select 
                            distinct id as ticket,
                            Issuer_tiket,
                            Analyst,
                            Analyst_2,
                            QA,
                            SPV,
                            substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10) as date_create,
                            substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,10) as date_assign,
                            substring(mte(cast(to_unixtime(assign_time_2)*1000 as bigint),7),1,10) as date_assign_2,
                            substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,10) as date_close,
                            substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,10) as date_QA, 
                            substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,20) as create_time,
                            substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,20) as assign_time, 
                            substring(mte(cast(to_unixtime(assign_time_2)*1000 as bigint),7),1,20) as assign_time_2,
                            substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,20) as close_time, 
                            substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,20) as QA_time, 
                            (cast(to_unixtime(close_time)*1000 as bigint) - cast(to_unixtime(assign_time)*1000 as bigint))/1000 as SLA_second,
                            (cast(to_unixtime(QA_time)*1000 as bigint) - cast(to_unixtime(close_time)*1000 as bigint))/1000 as SLA_QA_second
                        from (
                            select 
                                id,
                                deleted, 
                                creator as Issuer_tiket,
                                FROM_UNIXTIME(create_time/1000) AS create_time  
                            from mysql_risk_cms.riskantifrauddb.r_case_order 
                            where deleted = 0  
                                and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23')
                            ) a
                            
                        left join (
                            select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                operator_name as SPV,
                                FROM_UNIXTIME(update_time/1000) AS assign_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 2 
                        )  b 
                        
                        on a.id = b.case_order_id
                        
                        left join (
                            select 
                                case_order_id,
                                FROM_UNIXTIME(update_time/1000) AS close_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 8 
                        )  c 
                        
                        on a.id = c.case_order_id
                        
                        left join (
                            select 
                                case_order_id,
                                operator_name as QA,
                                FROM_UNIXTIME(update_time/1000) AS QA_time  
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 10 
                        )  d 
                        
                        on a.id = d.case_order_id 
                        
                        left join (
                            select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 4
                        )  e
                        
                        on a.id = e.case_order_id
                    )
                where analyst_2 is not null
                )

                union 

                select 
                    * ,
                    analyst as analyst_3 
                from (
                    select 
                        *, 
                        case
                            when SLA_second >= 0 and SLA_second <= 86399 then '<24 hours'
                            when SLA_second >= 86399 and SLA_second <= 	172800 then '24-48 hours'
                            when SLA_second >= 172801 and SLA_second <= 259200 then '48-72 hours'
                            when SLA_second >= 259201 then 'Over_SLA'
                            when date_assign is null then 'Pending'
                            when date_assign >= ('2021-12-31') and SLA_second is null then 'On-Progress'
                            else 'ticket_not_found' end basket_SLA ,
                            case when SLA_QA_second >= 0 and SLA_QA_second <= 86399 then '<24 hours'
                            when SLA_QA_second >= 86399 and SLA_QA_second <= 	172800 then '24-48 hours'
                            when SLA_QA_second >= 172801 and SLA_QA_second <= 259200 then '48-72 hours'
                            when SLA_QA_second >= 259201 then 'Over_SLA'
                            when date_assign is null then 'Pending'
                            when date_assign >= ('2021-12-31') and SLA_QA_second is null then 'On-Progress'
                            else 'ticket_not_found' 
                        end as basket_QA_SLA 
                    from (
                        select 
                            distinct id as ticket,
                            Issuer_tiket,
                            Analyst,
                            Analyst_2,
                            QA,
                            SPV,
                            substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10) as date_create,
                            substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,10) as date_assign,
                            substring(mte(cast(to_unixtime(assign_time_2)*1000 as bigint),7),1,10) as date_assign_2,
                            substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,10) as date_close ,
                            substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,10) as date_QA , 
                            substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,20) as create_time,
                            substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,20) as assign_time, 
                            substring(mte(cast(to_unixtime(assign_time_2)*1000 as bigint),7),1,20) as assign_time_2,
                            substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,20) as close_time, 
                            substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,20) as QA_time, 
                            (cast(to_unixtime(close_time)*1000 as bigint) - cast(to_unixtime(assign_time)*1000 as bigint))/1000 as SLA_second ,
                            (cast(to_unixtime(QA_time)*1000 as bigint) - cast(to_unixtime(close_time)*1000 as bigint))/1000 as SLA_QA_second
                        from (
                            select 
                                id ,
                                deleted, 
                                creator as Issuer_tiket,
                                FROM_UNIXTIME(create_time/1000) AS create_time  
                            from mysql_risk_cms.riskantifrauddb.r_case_order 
                            where deleted = 0  
                                and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23')
                            ) a
                            
                        left join (
                            select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                operator_name as SPV,
                                FROM_UNIXTIME(update_time/1000) AS assign_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 2
                        )  b 
                        
                        on a.id = b.case_order_id
                        
                        left join (
                            select 
                                case_order_id,
                                FROM_UNIXTIME(update_time/1000) AS close_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 8
                        )  c 
                        
                        on a.id = c.case_order_id
                        
                        left join (
                            select 
                                case_order_id, 
                                operator_name as QA,
                                FROM_UNIXTIME(update_time/1000) AS QA_time  
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 10
                        )  d 
                        
                        on a.id = d.case_order_id 
                        
                        left join (
                            select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 4
                        )  e
                        
                        on a.id = e.case_order_id
                    )
                    
                    where analyst_2 is null
                )
                        
                order by analyst_3
                
            )
            
            where substring(date_create,1,7) = date_format(now(),'%Y-%m')
        
        ) aa
        
        left join (
            select 
                case_order_id,
                vendor_id 
            from mysql_risk_cms.riskantifrauddb.r_case_target_vendor_info
        ) bb
        
        on aa.ticket = bb.case_order_id 
        
        where basket_SLA in ('Pending') 
            and substring(date_create,1,10) = date_format(now(),'%Y-%m-%d')
    )
) a

left join (
    select 
        id,
        case_type,
        case_config_source_id,
        case_config_reason_id, 
        case_config_clue_id, 
        case_config_result_id, 
        case_target  
    from  mysql_risk_cms.riskantifrauddb.r_case_order
) b

on a.ticket = b.id 

left join (
    select 
        id as code_source, 
        ind_text as Case_source 
    from mysql_risk_cms.riskantifrauddb.r_case_config_source
) f

on b.case_config_source_id = f.code_source 

left join (
    select 
        id as code_config_reason, 
        en_text as config_reason 
    from mysql_risk_cms.riskantifrauddb.r_case_config_reason
) g

on b.case_config_reason_id = g.code_config_reason

left join (
    select 
        id as code_config_clue, 
        ind_text as config_clue 
    from mysql_risk_cms.riskantifrauddb.r_case_config_clue
) h

on b.case_config_clue_id = h.code_config_clue
group by 1,2,3,4
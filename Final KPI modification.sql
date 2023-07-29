with cte_1 as (
select 
    *
from RISK_ANALYSIS.ERIC_AF_REPORT
),

cte_2 as (
select 
    analyst,
    date_close,
    cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) as SLA_percentale_1,
    sum(SLA) as SLA_Minute 
from 
    (select 
        distinct ticket,
        analyst, 
        date_close,
        cast(sla as bigint) as sla 
    from RISK_ANALYSIS.ERIC_AF_REPORT where sla != 'NULL')
group by 1,2
),

total_day as (
select 
    analyst, 
    count(distinct date_close) as total_absensi
from cte_1
group by 1
),

div_day as (
select max(div_days)
from 
    (select 
        analyst,
        count(distinct date_close) as div_days 
    from RISK_ANALYSIS.ERIC_AF_REPORT
    where analyst not in ('adityaboas.convergence.al','ellaa.convergence.al','monica.convergence.al') group by 1)
),

avg_sla as (
select a.*, b.date_close, b.SLA_percentale, b.SLA_Minute 
from (
    select 
        analyst,
        (select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT) as total_day,
        sum(sla)/(select * from div_day) as SLA,
        count(distinct date_close) as total_absensi 
    from 
       (select 
            distinct ticket,
            analyst, 
            date_close,
            cast(sla as bigint) as sla 
        from RISK_ANALYSIS.ERIC_AF_REPORT where sla != 'NULL') group by 1,2) a
    
    join 
    
    (
    select 
        * 
    from
        (select 
            analyst,
            date_close, 
            case 
                when SLA_percentale_1  <= 100 then 100 end as SLA_percentale,
            SLA_Minute 
        from 
            (select 
                * 
            from cte_2
            where SLA_percentale_1 <= 100)
        )
        
        union
        -- SLA_percentale >=100      
        (select 
                * 
        from cte_2
        where SLA_percentale_1 >= 100) )b
    
on a.analyst = b.analyst

),



is_suspect as (

select 
    analyst, 
    sum (is_suspect) + sum (Is_Suspect_add) as total_is_suspect 
from
    (select 
        analyst, 
        case when lower(is_suspect_1) in ('n' ,'NO','no','','o','-','r:','er:',' :',': ',':','r :','er :',' :',': ',':','r :','er :') or is_suspect_1  is null  then 0 else 1 end as is_suspect, 
        Is_Suspect_add 
    from
        (select 
            distinct ticket,
            analyst, 
            Is_Suspect_add,
            trim(substring(is_suspect, 17)) as is_suspect_1 
        from RISK_ANALYSIS.ERIC_AF_REPORT
    where is_suspect is not null or Is_Suspect_add = 1 ))
group by 1
),


finding_val as (
select 
    analyst,
    sum (finding_value) as total_finding_value, 
    sum (wrong_qa) as is_wrong_qa, 
    sum (Appeal) as Appeal 
from
    (select 
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
                when finding_add_B= 1 then 0.25 
                else 0 
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
                when is_wrong_qa = 1  and finding_add_B= 1 then 0.25 
                else 0
            end) as wrong_qa ,
        MAX (case 
                when  Appeal = 1 and  finding_action = 1  then 1 
                when  Appeal = 1 and result_finding_qa = 1 then 1
                when  Appeal = 1 and cashout_indication_finding_qa = 1 then 0.25
                when  Appeal = 1 and evidence_correct_finding_qa = 1 then 0.25
                when  Appeal = 1 and user_suspect_fraudster_finding_qa = 1 then 0.25
                when  Appeal = 1 and content_finding_qa = 1 then 0.25
                when  Appeal = 1 and  qa_analyst_finding = 1 then 0.25
                when  Appeal = 1 and finding_add_A= 1 then 1
                when  Appeal = 1 and finding_add_B= 1 then 0.25 
                else 0
            end) as Appeal 
    from RISK_ANALYSIS.ERIC_AF_REPORT_QA
    where finding_add_A = 1 
        or finding_add_B= 1 
        or any_finding_qa = 1 
        and revision = 0 
        and qa not in ('sapriyanti' , 'suyudi', 'antonius' , 'nining')
        or Is_Wrong_QA = 1 or Appeal = 1 group by 1,2)
group by 1
),

produktifitas as (
select 
    analyst, 
    sum(sla_percentale) / (select * from div_day) as produktifitas 
from avg_sla 
where analyst in ('allan.solichin',
        'agustin.putri',
        'Irma suryani nasution',
        'faizzain.muhammad',
        'saifullah.saputra',
        'arief',
        'adi.tri',
        'mauren.olivia',
        'Nur.ismail',
        'achmad',
        'dyonisia.anggita',
        'alisa',
        'achmad.rivai',
        'dessy.astarini',
        'hadi.putra',
        'lutfi.fanani')
group by 1
),

finding as (
select 
        distinct analyst,
        total_absensi,
        produktifitas,
        total_is_suspect,
        case 
            when analyst in ('')  then 0.00
            else COALESCE(total_finding_value, 0.00) - COALESCE(is_wrong_qa + Appeal, 0.00) 
        end as total_finding_value
    from(
        select 
            distinct td.*, 
            pd.produktifitas, 
            ip.total_is_suspect, 
            fv.total_finding_value, 
            fv.is_wrong_qa, 
            fv.appeal 
        from total_day td
        
        left join avg_sla av 
            on td.analyst = av.analyst
        
        left join produktifitas pd 
            on td.analyst = pd.analyst
        
        left join is_suspect ip 
            on td.analyst = ip.analyst
        
        left join finding_val fv 
            on td.analyst = fv.analyst
        )
),

kualitas as (
select 
    analyst,
    total_absensi,
    Produktifitas, 
    case 
        when total_finding_value <= 0  or total_finding_value  is null or total_finding_value  = 0 then 100 
        when total_finding_value > 0 and total_finding_value <= 1 then 95
        when total_finding_value > 1 and total_finding_value <= 2 then 90
        when total_finding_value >2 and total_finding_value <= 5 then 80
        when total_finding_value >5 and total_finding_value <= 10 then 70
        when total_finding_value > 10 and total_finding_value <= 15 then 60
        when total_finding_value >15 then 0 
    end as Kualitas,
    case 
        when total_is_suspect = 0 then 0
        when total_is_suspect = 1 then 1
        when total_is_suspect = 2 then 2
        when total_is_suspect = 3 then 3
        when total_is_suspect = 4 then 4
        when total_is_suspect = 5 then 5
        when total_is_suspect = 6 then 6
        when total_is_suspect = 7 then 7
        when total_is_suspect = 8 then 8
        when total_is_suspect = 9 then 9
        when total_is_suspect >= 10 then 10
    end as Pendalaman 
from finding),

sikap as (
    select 
        analyst,
        case 
            when analyst = 'allan.solichin' then 5
            when analyst = 'agustin.putri' then 5
            when analyst = 'Irma suryani nasution' then 5
            when analyst = 'faizzain.muhammad' then 5
            when analyst = 'saifullah.saputra' then 5
            when analyst =  'arief' then 5
            when analyst =  'adi.tri' then 5
            when analyst =  'mauren.olivia' then 5
            when analyst =  'Nur.ismail' then 5
            when analyst =  'achmad' then 5
            when analyst =  'dyonisia.anggita' then 5
            when analyst =  'alisa' then 5
            when analyst =  'achmad.rivai' then 4.71
            when analyst =  'dessy.astarini' then 5
            when analyst =  'hadi.putra' then 5
            when analyst =  'lutfi.fanani' then 5
        end as sikap,
        case 
            when analyst = 'allan.solichin' then 5
            when analyst = 'agustin.putri' then 5
            when analyst = 'Irma suryani nasution' then 5
            when analyst = 'faizzain.muhammad' then 5
            when analyst = 'saifullah.saputra' then 4.71
            when analyst =  'arief' then 5
            when analyst =  'adi.tri' then 5
            when analyst =  'mauren.olivia' then 4.71
            when analyst =  'Nur.ismail' then 4.71
            when analyst =  'achmad' then 5
            when analyst =  'dyonisia.anggita' then 4.71
            when analyst =  'alisa' then 5
            when analyst =  'achmad.rivai' then 5
            when analyst =  'dessy.astarini' then 5
            when analyst =  'hadi.putra' then 4.42
            when analyst =  'lutfi.fanani' then 4.71
        end as absensi
    from kualitas
),

percentage_score as (
    select 
        analyst,
        total_absensi,
        produktifitas,
        kualitas,
        case 
            when (Produktifitas*35)/100 >= 35 then 35
            when (Produktifitas*35)/100 < 35 and (Produktifitas*35)/100 > 0 then (Produktifitas*35)/100
            else 0 
        end as Produktifitas_percentage,
        case 
            when (Kualitas*45)/100 >= 45 then 45
            when (Kualitas*45)/100 < 45 and (Kualitas*45)/100 > 0 then (Kualitas*45)/100
            else 0 
        end as Kualitas_percentage, 
        Pendalaman
    from kualitas
),

total_kpi as (
select 
    ps.*,
    sp.sikap, 
    sp.absensi,
    ps.Produktifitas_percentage + ps.Kualitas_percentage + ps.Pendalaman + sp.sikap + sp.absensi as total_KPI,
    case 
        when ps.produktifitas >= (select avg(produktifitas) from produktifitas) then 'YES' else 'NO'
    end as prod_over_avg
    --case 
        --when ps.kualitas <= (select avg(kualitas) from kualitas) then 'YES' else 'NO'
    --end as qual_over_avg
from percentage_score ps

join sikap sp
    on ps.analyst = sp.analyst
)

select * from total_kpi
where analyst in ('allan.solichin',
        'agustin.putri',
        'Irma suryani nasution',
        'faizzain.muhammad',
        'saifullah.saputra',
        'arief',
        'adi.tri',
        'mauren.olivia',
        'Nur.ismail',
        'achmad',
        'dyonisia.anggita',
        'alisa',
        'achmad.rivai',
        'dessy.astarini',
        'hadi.putra',
        'lutfi.fanani')

/*
avg_qual as (
select 
    analyst,
    avg_qual,
    case
        when Kualitas > avg_qual or Kualitas is null then 'YES'
        else 'NO'
    end as qual_above_average
from (
    select
        analyst,
        kualitas,
        (select avg(Kualitas) from kualitas) as avg_qual
    from kualitas
    group by 1,2
    )
)

avg_prod as (
select 
    analyst,
    avg_prod,
    case
        when produktifitas >= avg_prod then 'YES'
        else 'NO'
    end as prod_above_average
from (
    select 
        analyst,
        produktifitas,
        (select avg(produktifitas) from produktifitas) as avg_prod
    from produktifitas 
    group by 1,2
    )
)
*/
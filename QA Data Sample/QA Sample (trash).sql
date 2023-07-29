QA Sample

with raw_qa_uc as (
    select 
        ticket,
        analyst, 
        nama_case, 
        case_group, 
        25 as sla_qa_uc, 
        qa, 
        date_assign
    from risk_analysis.eric_af_created_ticket
    where 
        if (
            (select MAX(date(date_assign)) from risk_analysis.eric_af_created_ticket) = current_date 
                and 
                (select * from risk_analysis.eric_af_created_ticket where date(date_assign) - 1 = ) ,
                date(date_assign) = current_date - interval '1' day,
                date(date_assign) = current_date - interval '3' day
                    )
        
        and case_target = 0
        and case_group = 'User Case Non HR - 45'
        and qa is null
),


ranked_data as (
    select 
        *, 
        row_number() over (partition by analyst,date_assign order by ticket desc) as rn
    from raw_qa_uc
),

data_qa as (
    select 
        row_number() OVER () as no,
        *
    from ranked_data
    where rn <= (
                select 
                    round(MAX(cast(rn as double))/2) 
                from ranked_data as sub 
                where sub.analyst = ranked_data.analyst)
),

qa_sample as (
select 
    *, 
    if ( no <= (select 
                floor(max(cast(no as double))/2)
                from data_qa),'Radhitya','yudi.irawan'
        ) 
    as qa_name
from data_qa
order by 1, qa_name asc
),


final_qa_sample as (
    select * from qa_sample
    where no <= (select MAX(no) from qa_sample) - (select MAX(no) from qa_sample) % 2
    order by no
),

summary_sla as (
    select 
        qa_name, 
        sum (sla_qa_uc) as total_sla_qa
    from final_qa_sample
    group by 1 
)

select * from final_qa_sample
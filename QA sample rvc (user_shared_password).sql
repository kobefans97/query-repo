--QA sample rvc (user_shared_password)

with raw_qa_rvc as (
    select 
        ticket,
        analyst, 
        nama_case, 
        case_group, 
        qa, 
        date_assign
    from risk_analysis.eric_af_created_ticket
    where 
         if (
            (select MAX(date(date_assign)) from risk_analysis.eric_af_created_ticket) = current_date,
                date(date_assign) = current_date - interval '1' day,
                date(date_assign) = current_date - interval '3' day
                    )
        and case_group = 'User Share Password - 10'
        and qa is null
),

ranked_data as (
    select 
        *, 
        row_number() over (partition by analyst,date_assign order by ticket desc) as rn
    from raw_qa_rvc
    where analyst in ('ellaa.convergence.al','adityaboas.convergence.al','monica.convergence.al')
),

data_qa as (
    select 
        row_number() OVER () as no,
        *
    from ranked_data
    where rn <= (
                select 
                    round(MAX(cast(rn as double))*0.30) 
                from ranked_data as sub 
                where sub.analyst = ranked_data.analyst)
),

final_qa_sample as (
    select 
        *,
        case ((no - 1) % 4)
            when 0 then 'Radhitya'
            when 1 then 'yudi.irawan'
            when 2 then 'yogi.rahmadi'
            when 3 then 'ekaputra'
        end as qa_name
    from data_qa
    where no <= (select MAX(no) from data_qa) - (select MAX(no) from data_qa) % 4
    order by no
)


select * from final_qa_sample
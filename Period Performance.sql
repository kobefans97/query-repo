Period Performance

select 
    date(create_time_1) as create_time, 
    case 
        when periods =  1 then '1 Month' 
        when periods =  2 then '2 Month' 
        when periods =  3 then '3 Month' 
        when periods =  6 then '6 Month' 
        when periods =  9 then '9 Month' 
        when periods =  12 then '12 Month' 
        when periods =  15 then '15 Days' 
        when periods =  22 then '22 Days' 
        when periods =  15 then '15 Days' 
        when periods =  30 then '30 Days' 
        when periods =  45 then '45 Days' 
        else null  
    end as periods, 
    count (DISTINCT iou_id ) as total_order
from (
    select 
        * ,
        substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10) as create_time_1 
    from (
        select 
            iou_id,
            uid,
            bank_name,
            bank_card_name, 
            account_no,
            account_name,
            principal,
            interest, 
            service_fee,
            paid_amt,
            disburse_amt monthly_debt,
            loan_type, 
            periods, 
            FROM_UNIXTIME(create_time/1000) as create_time, 
            FROM_UNIXTIME(update_time /1000) as update_time , 
            FROM_UNIXTIME(payoff_time/1000) as payoff_time 
        from hive.dwd.pid_loan_iou 
        ) 
    where substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10) >= date_format(now()-INTERVAL'90'day,'%Y-%m-%d'))
group by 1,2
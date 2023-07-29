Tingkat keberhasilan parameter pengajuan limit


SELECT 
    date(date_time) date , 
    1-front_cnt*1.0000/apply_uid as front_rate, 
    1-access_cnt*1.0000/(apply_uid-front_cnt) as access_rate, 
    1-fraud_cnt*1.0000/(apply_uid-front_cnt-access_cnt) as fraud_rate, 
    1-credit_cnt*1.0000/(apply_uid-front_cnt-access_cnt-fraud_cnt) as credit_rate
FROM (
    select 
        substr(mte(create_time,7),1,10) as date_time, 
        count(distinct afi_uid) as apply_uid, 
        count(distinct if(credit_result = 1, afi_uid)) as pass_uid,
        count(distinct if(reject_type = 17, afi_uid)) as front_cnt,
        count(distinct if(reject_type in (18,1), afi_uid)) as access_cnt,
        count(distinct if(reject_type in (2,3), afi_uid)) as fraud_cnt,
        count(distinct if(reject_type in (6,4,33), afi_uid)) as credit_cnt
    from hive.dwd_enc.afi_apv_application a 
    where substr(mte(CREATE_TIME,7),1,10) >= date_format(now()+INTERVAL '7' HOUR-INTERVAL '90' DAY, '%Y-%m-%d')
    and substr(mte(CREATE_TIME,7),1,10) < date_format(now()+INTERVAL '7' HOUR, '%Y-%m-%d')
    and a.CHANNEL_ID = 511
    GROUP BY 1)
ORDER BY 1 DESC
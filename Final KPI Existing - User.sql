Final KPI Existing

with z as (select avg(AVG_percentale) as AVG_percentale from
( select analyst , sum (SLA_percentale )/


--pembagi tanggal
17
 --(select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT ) 
 as AVG_percentale  

from
( select * from(select analyst ,date_close, case when SLA_percentale_1  <= 100 then 100 end as SLA_percentale , SLA_Minute from (
select * from(select analyst ,date_close,cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) SLA_percentale_1 ,sum(SLA) SLA_Minute  from 
(select distinct ticket,analyst, date_close,cast(sla as bigint) sla 
from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1,2 )
where SLA_percentale_1 <= 100))
union
(select * from (select analyst ,date_close,cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) SLA_percentale ,sum(SLA) SLA_Minute  from 
(select distinct ticket,analyst, date_close,cast(sla as bigint) sla 
from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1,2)
where SLA_percentale >= 100))
where Analyst in ('allan.solichin',
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
group by 1)) ,

cnt_analyst as (select count (distinct analyst) cnt_analyst  from RISK_ANALYSIS.ERIC_AF_REPORT 
where Analyst in ('allan.solichin',
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
'lutfi.fanani'))





select * , case when total_KPI >= 100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES'  then 'LEVEL 3'
when total_KPI >=95 and total_KPI < 100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team= 'YES' then 'LEVEL 2'
when total_KPI >=90 and total_KPI < 95  and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES' then 'LEVEL 1' else '-' end as Level ,
case when total_KPI = 100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES'  then 'Rp.1.200.000'
when total_KPI >=95 and total_KPI <100 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES' then 'Rp.800.000'
when total_KPI >= 90 and total_KPI < 95 and Produktifitas_Avg_team = 'YES' and Kualitas_Avg_team = 'YES' then 'Rp.400.000' else 'Rp.0' end as Insentive 
from
(select Analyst,Total_hari_kerja,Produktifitas_percentage,Kualitas_percentage,Pendalaman,Sikap,Absensi,total_KPI,
case when AVG_Produktivitas > Produktifitas_team  then 'YES' else 'NO' end as Produktifitas_Avg_team ,
case when AVG_kualitas < Kualitas_avg_team or AVG_kualitas  is null then 'YES' else 'NO' end as Kualitas_Avg_team
from
(select 
    Analyst,
    Total_hari_kerja,
    Produktifitas_percentage,
    Kualitas_percentage,
    Pendalaman,
    Sikap,
    Absensi,
    AVG(Produktifitas) as AVG_Produktivitas ,
    AVG(total_finding_value) as AVG_kualitas,
 Produktifitas_percentage+Kualitas_percentage+Pendalaman+Sikap+Absensi as total_KPI,
(

select (sum (
-- inject Analyst
case when analyst in ('')  then 0.00
else 
COALESCE(finding_value, 0.00) - COALESCE(wrong_qa + Appeal, 0.00) end )) /(select * from cnt_analyst ) as AVG_team_finding


from
( select distinct ticket,analyst ,  MAX(case 
when Finding_Action = 1 then 1 
when result_finding_qa = 1 then 1
when cashout_indication_finding_qa = 1 then 0.25
when evidence_correct_finding_qa = 1 then 0.25
when user_suspect_fraudster_finding_qa = 1 then 0.25
when content_finding_qa = 1 then 0.25
when qa_analyst_finding = 1 then 0.25
when finding_add_A= 1 then 1
when finding_add_B= 1 then 0.25 
else 0
 end )as finding_value ,
MAX(case 
when is_wrong_qa = 1 and  Finding_Action = 1 then 1
when is_wrong_qa = 1  and result_finding_qa = 1 then 1
when is_wrong_qa = 1  and cashout_indication_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and evidence_correct_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and user_suspect_fraudster_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and content_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and  qa_analyst_finding = 1 then 0.25
when is_wrong_qa = 1  and finding_add_A= 1 then 1
when is_wrong_qa = 1  and finding_add_B= 1 then 0.25 
 else 0
 end )as wrong_qa ,
MAX(case 
when  Appeal = 1 and  Finding_Action = 1 then 1
when  Appeal = 1 and result_finding_qa = 1 then 1
when  Appeal = 1 and cashout_indication_finding_qa = 1 then 0.25
when  Appeal = 1 and evidence_correct_finding_qa = 1 then 0.25
when  Appeal = 1 and user_suspect_fraudster_finding_qa = 1 then 0.25
when  Appeal = 1 and content_finding_qa = 1 then 0.25
when  Appeal = 1 and  qa_analyst_finding = 1 then 0.25
when  Appeal = 1 and finding_add_A= 1 then 1
when  Appeal = 1 and finding_add_B= 1 then 0.25 
 else 0
 end )as Appeal 

from RISK_ANALYSIS.ERIC_AF_REPORT_QA
where any_finding_qa = 1 and revision = 0 and qa not in ('sapriyanti' , 'suyudi', 'antonius' , 'nining')group by 1,2)where Analyst in ('allan.solichin',
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
'lutfi.fanani')) as Kualitas_avg_team , (select AVG_percentale from z) Produktifitas_team


 from
(
    select 
        Analyst,
        Total_hari_kerja, 
        case 
            when (Produktiifitas*35)/100 >= 35 then 35
            when (Produktiifitas*35)/100 < 35 and (Produktiifitas*35)/100 > 0 then (Produktiifitas*35)/100
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
from
(select analyst as Analyst,total_absensi as Total_hari_kerja,AVG_percentale as Produktiifitas, case when total_finding_value <= 0  or total_finding_value  is null or total_finding_value  = 0 then 100 when total_finding_value > 0 and total_finding_value <= 1 then 95
when total_finding_value > 1 and total_finding_value <= 2 then 90
when total_finding_value >2 and total_finding_value <= 5 then 80
when total_finding_value >5 and total_finding_value <= 10 then 70
when total_finding_value > 10 and total_finding_value <= 15 then 60
when total_finding_value >15 then 0 end as Kualitas ,
case when total_is_suspect = 0 or  total_is_suspect is null then 0
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
 end as Pendalaman ,
case 
when analyst in ('achmad.rivai') then 4.71
else 5 end as Sikap ,

case  when analyst in ('hadi.putra') then 4.42
when analyst in ('saifullah.saputra','dyonisia.anggita', 'mauren.olivia', 'lutfi.fanani' , 'Nur.ismail', 'saifullah.saputra' ) then 4.71 
 else 5 end as Absensi ,


total_finding_value
from (
select DISTINCT aa.analyst,total_absensi,AVG_percentale,total_is_suspect,COALESCE(total_finding_value, 0) - COALESCE(is_wrong_qa, 0.00)  as total_finding_value,AVG_SLA from (select a.analyst ,total_absensi,total_day,c.AVG_percentale,a.sla as AVG_SLA, date_close , SLA_Minute  ,SLA_percentale from 
(select analyst ,(select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT) as total_day, 

--pembagi tanggal
17
--(select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT ) 
 as SLA 


, count(distinct date_close) total_absensi 
from (select distinct ticket,analyst, date_close, cast(sla as bigint) sla from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1) a

left join ( select * from(select analyst ,date_close, case when SLA_percentale_1  <= 100 then 100 end as SLA_percentale , SLA_Minute from (
select * from(select analyst ,date_close,cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) SLA_percentale_1 ,sum(SLA) SLA_Minute  from 
(select distinct ticket,analyst, date_close,cast(sla as bigint) sla 
from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1,2 )
where SLA_percentale_1 <= 100))
union
(select * from (select analyst ,date_close,cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) SLA_percentale ,sum(SLA) SLA_Minute  from 
(select distinct ticket,analyst, date_close,cast(sla as bigint) sla 
from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1,2)
where SLA_percentale >= 100)
) b
on a.analyst = b.analyst

left join ( select analyst , sum (SLA_percentale )/

--pembagi tanggal
17
 --(select count(distinct date_close) from RISK_ANALYSIS.ERIC_AF_REPORT ) 
 as AVG_percentale 



from
( select * from(select analyst ,date_close, case when SLA_percentale_1  <= 100 then 100 end as SLA_percentale , SLA_Minute from (
select * from(select analyst ,date_close,cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) SLA_percentale_1 ,sum(SLA) SLA_Minute  from 
(select distinct ticket,analyst, date_close,cast(sla as bigint) sla 
from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1,2 )
where SLA_percentale_1 <= 100))
union
(select * from (select analyst ,date_close,cast((sum(SLA)*100)/480 AS DECIMAL(20,1)) SLA_percentale ,sum(SLA) SLA_Minute  from 
(select distinct ticket,analyst, date_close,cast(sla as bigint) sla 
from RISK_ANALYSIS.ERIC_AF_REPORT)
group by 1,2)
where SLA_percentale >= 100))
group by 1) c
on a.analyst = c.analyst) aa

left join 


--(select b.analyst as analyst_1 ,total_is_suspect , COALESCE(total_finding_value, 0.00) AS total_finding_value, COALESCE(is_wrong_qa, 0.00) AS is_wrong_qa from 
(select analyst , sum (is_suspect )+sum(Is_Suspect_add) as total_is_suspect from(select analyst , case when lower(is_suspect_1) in 
('n' ,'NO','no','','o','-','r:','er:',' :',': ',':','r :','er :',' :',': ',':','r :','er :')
 or is_suspect_1  is null  then 0 else 1 end as is_suspect, Is_Suspect_add from
(select distinct ticket , analyst , Is_Suspect_add ,trim(substring(is_suspect, 17)) is_suspect_1 from RISK_ANALYSIS.ERIC_AF_REPORT
where is_suspect is not null or Is_Suspect_add = 1 ))
group by 1 ) b

on aa.analyst = b.analyst 

left join 
(select analyst , sum (finding_value)total_finding_value , sum (wrong_qa) is_wrong_qa from
( select distinct ticket,analyst ,  MAX(case
when Finding_Action = 1 then 1 
when result_finding_qa = 1 then 1
when cashout_indication_finding_qa = 1 then 0.25
when evidence_correct_finding_qa = 1 then 0.25
when user_suspect_fraudster_finding_qa = 1 then 0.25
when content_finding_qa = 1 then 0.25
when qa_analyst_finding = 1 then 0.25
when finding_add_A= 1 then 1
when finding_add_B= 1 then 0.25 
 else 0
 end )as finding_value ,
MAX(case 
when is_wrong_qa = 1 and  Finding_Action = 1 then 1
when is_wrong_qa = 1  and result_finding_qa = 1 then 1
when is_wrong_qa = 1  and cashout_indication_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and evidence_correct_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and user_suspect_fraudster_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and content_finding_qa = 1 then 0.25
when is_wrong_qa = 1  and  qa_analyst_finding = 1 then 0.25
when is_wrong_qa = 1  and finding_add_A= 1 then 1
when is_wrong_qa = 1  and finding_add_B= 1 then 0.25 
 else 0
 end )as wrong_qa ,
MAX(case 
when  Appeal = 1 and  Finding_Action = 1 then 1
when  Appeal = 1 and result_finding_qa = 1 then 1
when  Appeal = 1 and cashout_indication_finding_qa = 1 then 0.25
when  Appeal = 1 and evidence_correct_finding_qa = 1 then 0.25
when  Appeal = 1 and user_suspect_fraudster_finding_qa = 1 then 0.25
when  Appeal = 1 and content_finding_qa = 1 then 0.25
when  Appeal = 1 and  qa_analyst_finding = 1 then 0.25
when  Appeal = 1 and finding_add_A= 1 then 1
when  Appeal = 1 and finding_add_B= 1 then 0.25 
 else 0
 end )as Appeal 



from RISK_ANALYSIS.ERIC_AF_REPORT_QA
where finding_add_A = 1 or finding_add_B= 1 or any_finding_qa = 1 and revision = 0 and qa not in ('sapriyanti' , 'suyudi', 'antonius' , 'nining')
or Is_Wrong_QA = 1 or Appeal = 1 group by 1,2)
group by 1 )c


on aa.analyst = c.analyst 

where aa.Analyst in ('allan.solichin',
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
'lutfi.fanani'))))
group by 1,2,3,4,5,6,7))






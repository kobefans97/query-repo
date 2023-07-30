select 
    distinct ticket,
    source_issue,
    Assigment, 
    nama_case,
    analyst,
    date_assign, 
    cast(SLA as bigint) as SLA,
    Case_Group 
from HIVE.RISK_ANALYSIS.ERIC_AF_CREATED_TICKET 
where date_assign = date_format(now(),'%Y-%m-%d')
    and Analyst in ('allan.solichin','agustin.putri','Irma suryani nasution','faizzain.muhammad','saifullah.saputra',
                'arief','adi.tri','mauren.olivia','Nur.ismail','achmad','dyonisia.anggita','alisa',
                'achmad.rivai','dessy.astarini','hadi.putra', 'lutfi.fanani')
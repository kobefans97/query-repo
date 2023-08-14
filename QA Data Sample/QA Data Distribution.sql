with ticket_qa as (
    select 
        ticket,
        analyst,
        date_qa,
        date_trunc('month', date(date_qa)) as date_in_month
    from risk_analysis.eric_af_created_ticket 
    where date_trunc('month', date(date_qa)) = date_trunc ('month', current_date)
        and date_qa is not null
)

select 
    analyst, 
    count (ticket) as sampling_qa
from ticket_qa

where --Agent Analyst
    analyst in ('adityaboas.convergence.al', 'ellaa.convergence.al', 'monica.convergence.al')

--where --merchant
    --analyst in ('achmad.ardi', 'ade.dede', 'aiga.rahmadiana', 'cianli.sri', 'luthfi.dwiki', 'm.affandi', 'naufal.riskiansyah', 
    --'nurul.afianti', 'rhomantino.rizal', 'rosauly.lustyanna', 'yogge.andreade')

--where --user
    --analyst in ('Irma suryani nasution', 'saifullah.saputra', 'mauren.olivia', 'lutfi.fanani', 'alisa', 'arief', 'allan.solichin', 
    --'faizzain.muhammad', 'dessy.astarini', 'achmad.rivai', 'hadi.putra', 'adi.tri', 'dyonisia.anggita','Nur.ismail')
group by 1 
order by lower(analyst) asc
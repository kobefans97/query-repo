select date('2023-03-01') as Reporting_Period, Merchant
, count(M.Order_Coll_1) Total_Order_Coll_1
, sum(M.OS_Coll_1) Total_OS_Coll_1
, count(M.Order_Coll_1) Total_Order_Coll_2
, sum(M.OS_Coll_1) Total_OS_Coll_2
, count(M.Order_Coll_1) Total_Order_Coll_3
, sum(M.OS_Coll_1) Total_OS_Coll_3
, count(M.Order_Coll_1) Total_Order_Coll_4
, sum(M.OS_Coll_1) Total_OS_Coll_4
, count(M.Order_Coll_1) Total_Order_Coll_5
, sum(M.OS_Coll_1) Total_OS_Coll_5
from
(
select 
case when Y.category='offline' then 'OFFLINE'
	 when Y.category='' then 'ONLINE / CARLOAN'
	 else Y.merchant
end as merchant			
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then 1 end as Order_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then 1 end as Order_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then 1 end as Order_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then 1 end as Order_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then 1 end as Order_Coll_5
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_5


from 
(
	select X.*
	, case when X.nomor_kontrak like '%AFI%' then 'PRODUKTIF' when C.channel_name is null then 'AKULAKU' else upper(trim(C.channel_name)) end merchant
	, case when C.business_scene=4 then 'offline' else 'online' end category
	from sqlserver_datamart_ojk.dbo.AR_By_Merchant_Mar2023 X
	left join (select installment_order_id, channel_id 
			   from snap.afi_id_loan_t_afi_installment_order) IO
		on substring(X.nomor_kontrak,8,18)=cast(IO.installment_order_id as varchar)
	left join (select sub_third_channel_id, channel_name, business_scene 
			   from snap.afi_id_loan_t_afi_installment_channel_id_dictionary) C
		on cast(IO.channel_id as bigint) = cast(C.sub_third_channel_id as bigint)
) y

) M

group by 1,2

union

select date('2023-04-01') as Reporting_Period, Merchant
, count(M.Order_Coll_1) Total_Order_Coll_1
, sum(M.OS_Coll_1) Total_OS_Coll_1
, count(M.Order_Coll_1) Total_Order_Coll_2
, sum(M.OS_Coll_1) Total_OS_Coll_2
, count(M.Order_Coll_1) Total_Order_Coll_3
, sum(M.OS_Coll_1) Total_OS_Coll_3
, count(M.Order_Coll_1) Total_Order_Coll_4
, sum(M.OS_Coll_1) Total_OS_Coll_4
, count(M.Order_Coll_1) Total_Order_Coll_5
, sum(M.OS_Coll_1) Total_OS_Coll_5
from
(
select 
case when Y.category='offline' then 'OFFLINE'
	 when Y.category='' then 'ONLINE / CARLOAN'
	 else Y.merchant
end as merchant			
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then 1 end as Order_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then 1 end as Order_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then 1 end as Order_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then 1 end as Order_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then 1 end as Order_Coll_5
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_5


from 
(
	select X.*
	, case when X.nomor_kontrak like '%AFI%' then 'PRODUKTIF' when C.channel_name is null then 'AKULAKU' else upper(trim(C.channel_name)) end merchant
	, case when C.business_scene=4 then 'offline' else 'online' end category
	from sqlserver_datamart_ojk.dbo.AR_By_Merchant_Apr2023 X
	left join (select installment_order_id, channel_id 
			   from snap.afi_id_loan_t_afi_installment_order) IO
		on substring(X.nomor_kontrak,8,18)=cast(IO.installment_order_id as varchar)
	left join (select sub_third_channel_id, channel_name, business_scene 
			   from snap.afi_id_loan_t_afi_installment_channel_id_dictionary) C
		on cast(IO.channel_id as bigint) = cast(C.sub_third_channel_id as bigint)
) y

) M

group by 1,2

union

select date('2023-05-01') as Reporting_Period, Merchant
, count(M.Order_Coll_1) Total_Order_Coll_1
, sum(M.OS_Coll_1) Total_OS_Coll_1
, count(M.Order_Coll_1) Total_Order_Coll_2
, sum(M.OS_Coll_1) Total_OS_Coll_2
, count(M.Order_Coll_1) Total_Order_Coll_3
, sum(M.OS_Coll_1) Total_OS_Coll_3
, count(M.Order_Coll_1) Total_Order_Coll_4
, sum(M.OS_Coll_1) Total_OS_Coll_4
, count(M.Order_Coll_1) Total_Order_Coll_5
, sum(M.OS_Coll_1) Total_OS_Coll_5
from
(
select 
case when Y.category='offline' then 'OFFLINE'
	 when Y.category='' then 'ONLINE / CARLOAN'
	 else Y.merchant
end as merchant			
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then 1 end as Order_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then 1 end as Order_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then 1 end as Order_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then 1 end as Order_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then 1 end as Order_Coll_5
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_5


from 
(
	select X.*
	, case when X.nomor_kontrak like '%AFI%' then 'PRODUKTIF' when C.channel_name is null then 'AKULAKU' else upper(trim(C.channel_name)) end merchant
	, case when C.business_scene=4 then 'offline' else 'online' end category
	from sqlserver_datamart_ojk.dbo.AR_By_Merchant_May2023 X
	left join (select installment_order_id, channel_id 
			   from snap.afi_id_loan_t_afi_installment_order) IO
		on substring(X.nomor_kontrak,8,18)=cast(IO.installment_order_id as varchar)
	left join (select sub_third_channel_id, channel_name, business_scene 
			   from snap.afi_id_loan_t_afi_installment_channel_id_dictionary) C
		on cast(IO.channel_id as bigint) = cast(C.sub_third_channel_id as bigint)
) y

) M

group by 1,2

union

select date('2023-06-01') as Reporting_Period, Merchant
, count(M.Order_Coll_1) Total_Order_Coll_1
, sum(M.OS_Coll_1) Total_OS_Coll_1
, count(M.Order_Coll_1) Total_Order_Coll_2
, sum(M.OS_Coll_1) Total_OS_Coll_2
, count(M.Order_Coll_1) Total_Order_Coll_3
, sum(M.OS_Coll_1) Total_OS_Coll_3
, count(M.Order_Coll_1) Total_Order_Coll_4
, sum(M.OS_Coll_1) Total_OS_Coll_4
, count(M.Order_Coll_1) Total_Order_Coll_5
, sum(M.OS_Coll_1) Total_OS_Coll_5
from
(
select 
case when Y.category='offline' then 'OFFLINE'
	 when Y.category='' then 'ONLINE / CARLOAN'
	 else Y.merchant
end as merchant			
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then 1 end as Order_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 0 and 10 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_1
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then 1 end as Order_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 11 and 90 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_2
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then 1 end as Order_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 91 and 120 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_3
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then 1 end as Order_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) between 121 and 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_4
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then 1 end as Order_Coll_5
, case when cast(Y.jumlah_hari_tunggakan as integer) > 180 then cast(Y.tagihan_piutang_pembiayaan_bruto as decimal(18,0)) end as OS_Coll_5


from 
(
	select X.*
	, case when X.nomor_kontrak like '%AFI%' then 'PRODUKTIF' when C.channel_name is null then 'AKULAKU' else upper(trim(C.channel_name)) end merchant
	, case when C.business_scene=4 then 'offline' else 'online' end category
	from sqlserver_datamart_ojk.dbo.AR_By_Merchant_Jun2023 X
	left join (select installment_order_id, channel_id 
			   from snap.afi_id_loan_t_afi_installment_order) IO
		on substring(X.nomor_kontrak,8,18)=cast(IO.installment_order_id as varchar)
	left join (select sub_third_channel_id, channel_name, business_scene 
			   from snap.afi_id_loan_t_afi_installment_channel_id_dictionary) C
		on cast(IO.channel_id as bigint) = cast(C.sub_third_channel_id as bigint)
) y

) M

group by 1,2
Tingkat keberhasilan pesanan menggunakan limit

/* 涉及库表
- hive.risk_analysis.shangqm_order_detail_history
*/
select date(create_date) date, 
    try(count(distinct if((is_pass=1 or status=100), po_id)) *1.0000 / count(distinct po_id))"订单通过率", --semua pesanan
    try(count(distinct if((is_pass=1 or status=100) and type = 1, po_id)) *1.0000 / count(distinct if(type=1, po_id))) "站内实体通过率", --produk fisik aplikasi 
    try(count(distinct if((is_pass=1 or status=100) and type = 2, po_id)) *1.0000 / count(distinct if(type=2, po_id))) "站内虚拟通过率", --produk virtual pada aplikasi
    try(count(distinct if((is_pass=1 or status=100) and type = 9, po_id)) *1.0000 / count(distinct if(type=9, po_id))) "openpay通过率" --openpay
from hive.risk_analysis.shangqm_order_detail_history 
where substr(create_date,1,10) >= date_format(now()+INTERVAL '7' HOUR-INTERVAL '90' DAY, '%Y-%m-%d')
group by 1 order by 1
create table RISK_ANALYSIS.ERIC_AF_CREATED_TICKET AS

select 
  *, 
  CASE
    WHEN nama_case in ('Cash Out Merchant') Then '120'
    WHEN nama_case in ('Pengiriman Pribadi') Then '120'
    WHEN nama_case in ('Pengiriman Cepat') Then '120'
    WHEN nama_case in ('1 Device Banyak UID') Then '45'
    WHEN nama_case in ('Akun Openpay berkaitan dengan banyak UID') Then '90'
    WHEN nama_case in ('WC-Anti Fraud') Then '40'
    WHEN nama_case in ('WC-Anti Fraud Highrisk') Then '40'
    WHEN nama_case in ('Suspect Face ID') And case_target in (0) Then '40'
    WHEN nama_case in ('Suspect Face ID') And case_target in (1) Then '120'
    WHEN nama_case in ('double nomor resi') Then '120'
    WHEN nama_case in ('Transaksi tatap muka') Then '120'
    WHEN nama_case in ('Proporsi barang virtual yang tinggi') Then '10'
    WHEN nama_case in ('Risiko 3 kali lipat dari pasar') Then '120'
    WHEN nama_case in ('WC-Banyak Transaksi TL') Then '40'
    WHEN nama_case in ('Pembekuan mandiri pada aplikasi') Then '40'
    WHEN nama_case in ('GPS Abnormal') Then '10'
    WHEN nama_case in ('double nomor resi ') Then '120'
    WHEN nama_case in ('Barang cepat terjual') Then  '120'
    WHEN source_issue in ('CS') And  Assigment  in  ('Release Freeze') Then '15'
    WHEN source_issue in ('CS') And  Assigment not in  ('Release Freeze' , 'telecom fraud','Penipuan VA') Then '45'
    WHEN source_issue in ('CS') And  Assigment  in  ('telecom fraud') Then '10'
    WHEN source_issue in ('CS') And  Assigment  in  ('Urgent Case Ojk & Media') Then '45'
    WHEN source_issue in ('CS') And  Assigment in  ('Penipuan VA') Then '15'
    WHEN source_issue in ('Risk Control') And Assigment  in ('Produk Merchant Offline') And nama_case  in  ('Aplikasi Risk') Then '30'
    WHEN source_issue in ('Risk Control')  And Assigment in ('trigger') And nama_case in ('Lainnya') Then '40'
    WHEN source_issue in ('Trigger') And Assigment in ('Trigger') And nama_case in ('Suspect Face Id') And case_type in (0) Then '30'
    WHEN source_issue in ('Trigger') And Assigment in ('Trigger') And nama_case in ('Suspect Face Id') And case_type in (1) Then '120'
    WHEN source_issue in ('Trigger') And Assigment in ('Trigger') And nama_case in ('Akun Openpay berkaitan dengan banyak UID') Then '90'
    WHEN source_issue in ('Trigger') And  Assigment  in  ('trigger') And  nama_case  in  ('double nomor resi ') Then  '120'
    WHEN source_issue in ('tin_Collection') And  Assigment  in  ('All') Then '40'
    WHEN source_issue in ('tin_Collection') And Assigment  in  ('ATO') Then '40'
    WHEN source_issue in ('tin_Collection') And Assigment  in  ('fake identity') Then '40'
    WHEN source_issue in ('tin_Collection') And Assigment  in  ('telecom fraud') And nama_case  in  ('others') Then '40'
    WHEN source_issue in ('tin_Collection') And Assigment  in  ('telecom fraud') Then '40'
    WHEN source_issue in ('tin_Collection')  And Assigment in ('crime gang') And nama_case in ('Lainnya') Then '40'
    WHEN source_issue in ('tin_Collection')  And Assigment in ('others') And nama_case in ('Lainnya') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('telecom fraud') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Documents not valid') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Account Take Over') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('fake identity') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Lainya') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And nama_case in ('Lainnya') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Pemakaian limit tinggi') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('WC-Voice Press 2') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('WC-Face ID Risk') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And nama_case in ('WC-Face ID Risk') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Merchant Name not match') Then '5'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And  nama_case  in  ('Pemakaian limit tinggi') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And  nama_case  in  ('WC-Scan Limit Tinggi') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And  nama_case  in  ('WC-Voice Press 2') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Documents not valid') And  nama_case  in  ('Pemakaian limit tinggi') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Documents not valid') And  nama_case  in  ('WC-Scan Limit Tinggi') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Documents not valid') And  nama_case  in  ('WC-Voice Press 2') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('fake identity') And  nama_case  in  ('Pemakaian limit tinggi') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('telecom fraud') And  nama_case  in  ('Pemakaian limit tinggi') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('telecom fraud') And  nama_case  in  ('WC-Scan Limit Tinggi') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('telecom fraud') And  nama_case  in  ('WC-Edukasi QR') Then '10'
    WHEN source_issue in ('Risk Verification Call') and Assigment in ('ATO') And  nama_case  in  ('WC-Edukasi QR') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('Extra cost') And  nama_case  in  ('WC-Scan Limit Tinggi') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Lainnya') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('WC-Scan Limit Tinggi') Then '40'    
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Sebelum ada Order') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Setelah ada Order') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') and nama_case  in  ('Melepaskan Kaitan') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('fake identity') and nama_case  in  ('Melepaskan Kaitan') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('telecom fraud') and nama_case  in  ('Melepaskan Kaitan') Then '10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') and nama_case  in  ('Lainnya') Then '40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And nama_case in ('Setelah ada Order') Then '40'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') and nama_case in ('Proporsi barang virtual yang tinggi') Then '10'    
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Lainnya') and issuer_tiket not in ('suyudi') Then '20'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Lainnya') and issuer_tiket in ('suyudi') Then '15'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Merchant dengan nama pemilik sama') Then '10'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('ATO') And nama_case in ('Lainnya') Then '45'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('cash out') And nama_case in ('') Then '120'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Lainnya') Then '120'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('cash out') And nama_case in ('Grup Cash Out') Then '120'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('fake identity') And nama_case in ('Lainnya') Then '45'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('ATO') And nama_case in ('others') Then '0'
    WHEN source_issue in ('OJK & Media') And Assigment in ('ATO') And nama_case in ('akun dicuri karena alasan non-pribadi') Then '45'
    WHEN source_issue in ('OJK & Media') And Assigment in ('ATO') And nama_case in ('ditipu oleh pihak yang mengatasnamakan Akulaku') Then '40'
    WHEN source_issue in ('OJK & Media') And Assigment in ('ATO') And nama_case in ('akun dicuri karena alasan non-pribadi') Then '40'
    WHEN source_issue in ('OJK & Media') And Assigment in ('Urgent Case Ojk & Media') And nama_case in ('akun dicuri karena alasan non-pribadi') Then '40'
    WHEN source_issue in ('OJK & Media') And Assigment in ('ATO') And nama_case in ('tidak pernah mendaftar akun') Then '40'
    WHEN source_issue in ('OJK & Media') And Assigment in ('fake identity') And nama_case in ('akun dicuri karena alasan non-pribadi') Then '40'
    WHEN source_issue in ('OJK & Media') And Assigment in ('telecom fraud') And nama_case in ('membagikan kode verifikasi') Then '40'
    ELSE null 
  END AS SLA, 
  
  CASE
    WHEN nama_case in ('Cash Out Merchant') Then 'Merchant Case (Integer/CashOut Merchant) - 120'
    WHEN nama_case in ('Pengiriman Pribadi') Then 'private logistics - 120'
    WHEN nama_case in ('Pengiriman Cepat') Then 'Fast Receipt - 120'
    WHEN nama_case in ('1 Device Banyak UID') Then'Adhoc- 1 Device Banyak UID - 45'
    WHEN nama_case in ('Akun Openpay berkaitan dengan banyak UID') Then 'Trigger Case- Multi User - 90'
    WHEN nama_case in ('WC-Anti Fraud') Then 'Data WC-Analisa Lengkap - 40'
    WHEN nama_case in ('WC-Anti Fraud Highrisk') Then 'Data WC-Analisa Lengkap - 40'
    WHEN nama_case in ('Suspect Face ID') And case_target in (0) Then 'Trigger Case- Suspect Face Id - 40'
    WHEN nama_case in ('Suspect Face ID') And case_target in (1) Then 'Trigger Case- Suspect Face Id - 120'
    WHEN nama_case in ('double nomor resi') Then 'Duplicate tracking number (Double Resi) - 120'
    WHEN nama_case in ('Transaksi tatap muka') Then 'face to face transaction - 120'
    WHEN nama_case in ('Proporsi barang virtual yang tinggi') Then 'High proportion of virtual goods - 10'
    WHEN nama_case in ('Risiko 3 kali lipat dari pasar') Then 'The Risk is 3 times that of the broader market (Risiko 3 kali lipat pasar) - 20'
    WHEN nama_case in ('WC-Banyak Transaksi TL') Then 'Data WC-Analisa Lengkap - 40'
    WHEN nama_case in ('Pembekuan mandiri pada aplikasi') Then 'Data WC-Analisa Lengkap - 40'
    WHEN nama_case in ('GPS Abnormal') Then 'GPS Abnormal - 10'
    WHEN nama_case in ('Aplikasi Risk') Then 'Adhoc -Aplikasi Risk - 35'
    WHEN nama_case in ('double nomor resi ') Then 'Duplicate tracking number (Double Resi) - 120'
    WHEN nama_case in ('Barang cepat terjual') Then  'Fast Sold - 120'
    WHEN source_issue in ('CS') And Assigment in  ('Urgent Case Ojk & Media') Then 'User Case Non HR - 45'
    WHEN source_issue in ('CS') And Assigment in  ('Release Freeze') Then 'Release Freeze - 15'
    WHEN source_issue in ('CS') And Assigment not in  ('Release Freeze' , 'telecom fraud','Penipuan VA') Then 'User Case Non HR - 45'
    WHEN source_issue in ('CS') And Assigment in ('telecom fraud') Then 'User Share Password - 10'
    WHEN source_issue in ('CS') And  Assigment in  ('Penipuan VA') Then 'Penipuan VA - 15'
    WHEN source_issue in ('Risk Control') And Assigment in ('trigger') And nama_case in ('Lainnya') Then 'Adhoc Anti Fraud Merchant - 40'
    WHEN source_issue in ('Risk Control') And Assigment in  ('Produk Merchant Offline') And  nama_case  in  ('Aplikasi Risk') Then 'Adhoc -Aplikasi Risk - 30'
    WHEN source_issue in ('Trigger') And Assigment in ('Trigger') And nama_case in ('Suspect Face Id') And case_target in (0) Then 'Trigger Case- Suspect Face Id - 30'
    WHEN source_issue in ('Trigger') And Assigment in ('Trigger') And nama_case in ('Suspect Face Id') And case_target in (1) Then 'Trigger Case - Suspect Face Id - 120'
    WHEN source_issue in ('Trigger') And Assigment in ('Trigger') And nama_case in ('Akun Openpay berkaitan dengan banyak UID') Then 'Trigger Case- Multi User - 90'
    WHEN source_issue in ('Trigger') And Assigment in ('trigger') And nama_case in ('double nomor resi ') Then 'Duplicate tracking number (Double Resi) - 120'
    WHEN source_issue in ('tin_Collection') And Assigment in ('ATO') Then 'User Case_Coll - 40'
    WHEN source_issue in ('tin_Collection') And Assigment in ('fake identity') Then 'User Case_Coll - 40'
    WHEN source_issue in ('tin_Collection') And Assigment in ('telecom fraud') And  nama_case  in  ('others') Then 'User Case_Coll - 40'
    WHEN source_issue in ('tin_Collection') And Assigment in ('telecom fraud') Then 'User Case_Coll - 40'
    WHEN source_issue in ('tin_Collection') And Assigment in ('All') Then 'User Case_Coll - 40'
    WHEN source_issue in ('tin_Collection') And Assigment in ('crime gang') And nama_case in ('Lainnya') Then 'User Case_Coll - 40'
    WHEN source_issue in ('tin_Collection') And Assigment in ('others') And nama_case in ('Lainnya') Then 'User Case_Coll - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('telecom fraud') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Documents not valid') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Account Take Over') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('fake identity') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Lainya') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('ATO') And  nama_case  in  ('Pemakaian limit tinggi') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('ATO') And  nama_case  in  ('WC-Scan Limit Tinggi') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('ATO') And  nama_case  in  ('WC-Voice Press 2') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Documents not valid') And  nama_case  in  ('Pemakaian limit tinggi') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Documents not valid') And  nama_case  in  ('WC-Scan Limit Tinggi') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Documents not valid') And  nama_case  in  ('WC-Voice Press 2') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('fake identity') And  nama_case  in  ('Pemakaian limit tinggi') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('telecom fraud') And  nama_case  in  ('Pemakaian limit tinggi') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('telecom fraud') And  nama_case  in  ('WC-Scan Limit Tinggi') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('telecom fraud') And  nama_case  in  ('WC-Edukasi QR') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') and Assigment  in  ('ATO') And  nama_case  in  ('WC-Edukasi QR') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Extra cost') And  nama_case  in  ('WC-Scan Limit Tinggi') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And  Assigment  in  ('Merchant Name not match') Then 'Data WC- Nama Merchant tidak sesuai - 5'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And nama_case in ('Lainnya') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Pemakaian limit tinggi') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('WC-Voice Press 2') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('WC-Face ID Risk') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And nama_case in ('WC-Face ID Risk') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Lainnya') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('WC-Scan Limit Tinggi') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Sebelum ada Order') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('others') And nama_case in ('Setelah ada Order') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') And nama_case in ('Setelah ada Order') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') and nama_case  in  ('Melepaskan Kaitan') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('fake identity') and nama_case  in  ('Melepaskan Kaitan') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('telecom fraud') and nama_case  in  ('Melepaskan Kaitan') Then 'Data WC-BlacklistFreeze - 10'
    WHEN source_issue in ('Risk Verification Call') And Assigment in ('ATO') and nama_case in ('Lainnya') Then 'Data WC-Analisa Lengkap - 40'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Lainnya') and issuer_tiket not in ('suyudi') Then 'Adhoc Verifikasi Merchant - 20'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Merchant dengan nama pemilik sama') Then 'Merchant dengan nama pemilik sama - 10'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Lainnya') and issuer_tiket in ('suyudi') Then 'Adhoc Verifikasi Merchant - 15'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('ATO') And nama_case in ('Lainnya') Then 'Adhoc Verifikasi Merchant - 45'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('cash out') And nama_case in ('') Then 'Merchant Case (Integer/CashOut Merchant) - 120'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('others') And nama_case in ('Lainnya') Then 'Merchant Case (Integer/CashOut Merchant) - 120'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('cash out') And nama_case in ('Grup Cash Out') Then 'Merchant Case (Integer/CashOut Merchant) - 120'
    WHEN source_issue in ('Anti Fraud') And Assigment in ('fake identity') And nama_case in ('Lainnya') Then 'User Case Non HR - 45'
    WHEN source_issue in  ('Anti Fraud') And Assigment in ('others') and nama_case in ('Proporsi barang virtual yang tinggi') Then 'High proportion of virtual goods - 10'
    WHEN source_issue in  ('Anti Fraud') And Assigment in ('ATO') And nama_case in ('others') Then 'Special Case User - 0'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('ATO') And nama_case in ('ditipu oleh pihak yang mengatasnamakan Akulaku') Then 'User Case Non HR - 45'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('ATO') And nama_case in ('akun dicuri karena alasan non-pribadi') Then 'User Case Non HR - 45'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('telecom fraud') And nama_case in ('membagikan kode verifikasi') Then 'User Case Non HR - 45'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('Urgent Case Ojk & Media') And nama_case in ('akun dicuri karena alasan non-pribadi') Then 'User Case Non HR - 45'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('ATO') And nama_case in ('tidak pernah mendaftar akun') Then 'User Case Non HR - 45'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('fake identity') And nama_case in ('akun dicuri karena alasan non-pribadi') Then 'User Case Non HR - 45'
    WHEN source_issue in ('OJK & Media')  And Assigment in ('ATO') And nama_case in ('akun dicuri karena alasan non-pribadi') Then 'User Case Non HR - 45'
    ELSE null 
  END AS Case_Group, 

  CASE --when assign_time is null  then 'ticket_not_found'
    when SLA_second >= 0 and SLA_second <= 86399 then '<24 hours'
    when SLA_second >= 86399 and SLA_second <= 	172800 then '24-48 hours'
    when SLA_second >= 172801 and SLA_second <= 259200 then '48-72 hours'
    when SLA_second >= 259201 then 'Over_SLA'
    when date_assign is null then 'Pending'
    when date_assign >= ('2021-12-31') and SLA_second is null then 'On-Progress'
    else 'ticket_not_found' 
  END AS basket_SLA,

  CASE 
    when SLA_QA_second = 0 then ''
    when SLA_QA_second >= 1 and SLA_QA_second <= 86399 then '<24 hours'
    when SLA_QA_second >= 86399 and SLA_QA_second <= 	172800 then '24-48 hours'
    when SLA_QA_second >= 172801 and SLA_QA_second <= 259200 then '48-72 hours'
    when SLA_QA_second >= 259201 then 'Over_SLA'
    when SLA_second is not null then 'Pending'
    when date_assign >= ('2021-12-31') and SLA_QA_second is null then 'On-Progress'
    else 'ticket_not_found'
  END AS basket_QA_SLA

from (
  select 
    config_clue as Nama_Case,
    ticket, 
    config_reason as Assigment,	
    Case_source as Source_Issue,
    issuer_tiket,	
    analyst,
    qa, 
    SPV, 
    case_type,
    case_target,	
    cast (channel_uid as varchar) as channel_uid, 
    name, 
    case 
      when ticket in (213894) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-01','2023-02-28') 
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-02-22') 
      when ticket in (217721) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-03-01')
      when ticket in (218071) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-02-23')
      when ticket in (219959) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (219972) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (224970) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-31','2023-03-14')
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-03-17')
      when ticket in (235297) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-05-02','2023-03-20')
      else substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10) 
    end as date_create,
    
    case 
      when ticket in (213894)  then replace (substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,10),'2023-03-01','2023-02-28') 
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-02-22') 
      when ticket in (217721) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-03-01')
      when ticket in (218071) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-02-23')
      when ticket in (219959) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (219972) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (224970) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-31','2023-03-14')
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-03-17')
      when ticket in (235297) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-05-02','2023-03-20')
      else substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,10) 
    end as date_assign,
    
    case 
      when ticket in (213894) then replace (substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,10),'2023-03-01','2023-02-28') 
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-02-22') 
      when ticket in (217721) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-03-01')
      when ticket in (218071) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-02-23')
      when ticket in (219959) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (219972) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (224970) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-31','2023-03-14')
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-03-17')
      when ticket in (235297) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-05-02','2023-03-20')
      else substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,10) 
    end as date_close,

    case 
      when ticket in (213894) then replace (substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,10),'2023-03-01','2023-02-28') 
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-02-22') 
      when ticket in (217721) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-03-01')
      when ticket in (218071) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-10','2023-02-23')
      when ticket in (219959) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (219972) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-16','2023-02-28')
      when ticket in (224970) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-31','2023-03-14')
      when ticket in (216906) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-03-07','2023-03-17')
      when ticket in (235297) then replace (substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,10),'2023-05-02','2023-03-20')
      else substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,10) 
    end as date_QA,
    
    substring(mte(cast(to_unixtime(create_time)*1000 as bigint),7),1,20) as create_time,
    substring(mte(cast(to_unixtime(assign_time)*1000 as bigint),7),1,20) as assign_time, 
    substring(mte(cast(to_unixtime(close_time)*1000 as bigint),7),1,20) as close_time, 
    substring(mte(cast(to_unixtime(QA_time)*1000 as bigint),7),1,20) as QA_time, 
    (cast(to_unixtime(close_time)*1000 as bigint) - cast(to_unixtime(assign_time)*1000 as bigint))/1000 as SLA_second,
    (cast(to_unixtime(QA_time)*1000 as bigint) - cast(to_unixtime(close_time)*1000 as bigint))/1000 as SLA_QA_second,
    cast((close_time- assign_time) as varchar ) as SLA_second_time,
    cast((QA_time - close_time)  as varchar )as SLA_qa_time,

    case 
      WHEN case_config_result_id = 1 THEN 'Account Take Over'
      WHEN case_config_result_id = 2 THEN 'FAP-Fraud Aplikasi-Data digunakan oleh orang lain'
      WHEN case_config_result_id = 3 THEN 'FAP-Fraud Aplikasi-Data Palsu'
      WHEN case_config_result_id = 4 THEN 'Cash Out'
      WHEN case_config_result_id = 5 THEN 'Pencucian Uang'
      WHEN case_config_result_id = 6 THEN 'ATO-user share password'
      WHEN case_config_result_id = 7 THEN 'No Fraud'
      WHEN case_config_result_id = 8 THEN 'white horse'
      WHEN case_config_result_id = 9 THEN 'Release Freeze-Approved'
      WHEN case_config_result_id = 10 THEN 'Release Freeze-Rejected'
      WHEN case_config_result_id = 11 THEN 'ATO-Tagihan tanggung jawab user'
      WHEN case_config_result_id = 12 THEN 'ATO-Tidak ada financial loss'
      WHEN case_config_result_id = 13 THEN 'ATO-Pengajuan Hapus Tagih'
      WHEN case_config_result_id = 14 THEN 'FAP - DATA DI GUNAKAN ORANG LAIN-Tagihan tanggung jawab user'
      WHEN case_config_result_id = 15 THEN 'FAP - DATA DI GUNAKAN ORANG LAIN-Tidak ada financial loss'
      WHEN case_config_result_id = 16 THEN 'FAP - DATA DI GUNAKAN ORANG LAIN-Pengajuan Hapus Tagih'
      WHEN case_config_result_id = 17 THEN 'FAP - DATA PALSU-Tagihan tanggung jawab user'
      WHEN case_config_result_id = 18 THEN 'FAP - DATA PALSU-Tidak ada financial loss'
      WHEN case_config_result_id = 19 THEN 'FAP - DATA PALSU-Pengajuan Hapus Tagih'
      WHEN case_config_result_id = 20 THEN 'Release Freeze-Akun sudah aktif'
      WHEN case_config_result_id = 21 THEN 'Release Freeze-Nama sudah diubah'
      WHEN case_config_result_id = 22 THEN 'Release Freeze Reject-Uncontacted 3x'
      WHEN case_config_result_id = 23 THEN 'Release Freeze Reject-KTP tidak jelas'
      WHEN case_config_result_id = 24 THEN 'Release Freeze Reject-Dokumen tidak sesuai'
      WHEN case_config_result_id = 25 THEN 'Release Freeze Reject-Tidak lolos verifikasi'
      WHEN case_config_result_id = 26 THEN 'Release Freeze Reject-User belum ubah password'
      WHEN case_config_result_id = 27 THEN 'Release Freeze Reject-User menolak verifikasi'
      WHEN case_config_result_id = 28 THEN 'User share password -Tagihan tanggung jawab user'
      WHEN case_config_result_id = 29 THEN 'User share password -Tidak ada financial loss'
      WHEN case_config_result_id = 30 THEN 'Release Freeze Approve-Akun tidak dalam keadaan freeze ataupun blacklist'
      WHEN case_config_result_id = 31 THEN 'Release Freeze Reject-Tidak bisa di unfreeze selamanya'
      WHEN case_config_result_id = 32 THEN 'SCAM-online scam'
      WHEN case_config_result_id = 33 THEN 'SCAM-Tidak ada financial loss'
      WHEN case_config_result_id = 34 THEN 'SCAM-Tagihan tanggung jawab user'
      WHEN case_config_result_id = 35 THEN 'Fraud Merchant'
      WHEN case_config_result_id = 36 THEN 'Fraud Merchant-Penipuan Merchant'
      WHEN case_config_result_id = 37 THEN 'Fraud Merchant-Memungut Biaya'
      WHEN case_config_result_id = 38 THEN 'Fraud Merchant-Barang yang dikirim tidak sesuai'
      WHEN case_config_result_id = 39 THEN 'Fraud Merchant-Menjual Produk yang dilarang'
      WHEN case_config_result_id = 40 THEN 'Fraud Merchant-Merchant Fiktif'
      WHEN case_config_result_id = 41 THEN 'Fraud Merchant-Cash Out'
      WHEN case_config_result_id = 42 THEN 'Fraud Merchant -Merchant tidak mengirimkan barang'
      WHEN case_config_result_id = 43 THEN 'Fraud Merchant -Berhasil menjual produk virtual'
      WHEN case_config_result_id = 44 THEN 'Fraud Merchant-Unggah produk virtual'
      WHEN case_config_result_id = 45 THEN 'APM-Nomor sudah diubah'
      WHEN case_config_result_id = 46 THEN 'Fraud Merchant-Tindakan pelanggaran merchant'
      WHEN case_config_result_id = 47 THEN 'Fraud Merchant- Tindakan pelanggaran merchant'
      WHEN case_config_result_id = 48 THEN 'Fraud Merchant-Merchant Fraud - Cashout by Fast Receipt and Same Address'
      WHEN case_config_result_id = 49 THEN 'Fraud Merchant-Merchant Fraud - Cashout by Fast Receipt'
      WHEN case_config_result_id = 50 THEN 'APM-Izinkan untuk update foto KTP'
      WHEN case_config_result_id = 51 THEN 'Extra cost-Meminta biaya tambahan'
      WHEN case_config_result_id = 52 THEN 'No Fraud - No Fraud'
      WHEN case_config_result_id = 53 THEN 'Acquintance crime -Dilakukan Orang Terdekat'
      WHEN case_config_result_id = 54 THEN 'Merchant Offline'
      WHEN case_config_result_id = 55 THEN 'Merchant Offline'
      WHEN case_config_result_id = 56 THEN 'Meminta biaya tambahan'
      WHEN case_config_result_id = 57 THEN 'Nama Merchant tidak sesuai'
      ELSE null 
    END AS hasil_investigasi, 
    
    cast(Action as varchar) as action,
    
    CASE WHEN ticket in 
        (206610, 
        206993, 207759, 207764, 207768, 
        208145, 208155, 208157, 209427, 209443, 
        209444, 209621, 209628, 209631, 209862, 
        209865, 210626, 210629, 210640, 211103, 
        211108, 211951, 212395, 212413, 212667, 
        213402, 213602, 213606, 213607, 213619, 
        213988, 214013, 214626, 215295, 215307, 
        215524, 215966, 215969, 216216, 216247, 
        216280, 216423, 216425, 216607, 216615, 
        216630, 216786, 216805, 216865, 216918, 
        217192, 217301, 214001, 216455, 216792, 217193,
        217203, 219341, 219729, 219903,
        220198, 220534, 220545, 221804,
        222158, 222176, 222429, 222440,
        222441, 222716, 222719, 222725,
        223033, 223042, 223043, 223312,
        223321)  
        THEN null else IS_Suspect 
    END as IS_Suspect,
    
    Remark_text,
    Is_finding, 
    
    case 
      when Category_finding like ('%is_finding_action_1%') then 'Freeze'
      when Category_finding like ('%is_finding_action_2%') then 'Blacklist'
      when Category_finding like ('%is_finding_action_1&2%') then 'Freeze & Blacklist'
      else null 
    end as Category_finding,
    remark_QA ,

    --temporary
    create_time as  create_time_temp,
    assign_time as assign_time_temp, 
    close_time as close_time_temp , 
    QA_time as QA_time_temp  

  from 
    (select 
      *, 
      credit_user_nm as NAME 
    from 
      (select 
        * 
      from 


        --table 1
        (select 
          * 
        from
          (select 
            ticket,	
            Issuer_tiket, 
            analyst,
            QA,	
            SPV,
            create_time,
            assign_time_3 as assign_time,	
            close_time,	
            QA_time 
          from
            (select 
              ticket,	
              Issuer_tiket,	
              analyst_3 as analyst,
              QA,
              SPV,
              create_time,
              assign_time_2 as assign_time_3,	
              close_time,	
              QA_time
            from 
              (select 
                * 
              from 
                (select 
                  *, 
                  analyst_2 as analyst_3  
                from 
                  (select 
                    *
                  from (
                    select distinct id as ticket,
                      *
                    from 
                      (select 
                        id, 
                        deleted,
                        creator as Issuer_tiket,
                        FROM_UNIXTIME(create_time/1000) AS create_time  
                      from mysql_risk_cms.riskantifrauddb.r_case_order 
                      where deleted = 0) a
                          --and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
                      
                      left join 
                        (select 
                          a.case_order_id, 
                          Analyst, 
                          a.assign_time,
                          SPV 
                        from (
                          select 
                            case_order_id, 
                            max (assign_time) as assign_time 
                          from (
                            select 
                              * 
                            from (
                              select 
                                case_order_id, 
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                operator_name as SPV ,FROM_UNIXTIME(update_time/1000) AS assign_time 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 2) 

                              union 

                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2 ))
                          group by 1) a

                          left join (
                            select * from (
                              select 
                                case_order_id, 
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                operator_name as SPV,
                                FROM_UNIXTIME(update_time/1000) AS assign_time 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 2) 
          
                              union 
                              
                              select * from (
                                select case_order_id, 
                                CAST(json_extract(content,'$.operator_name') AS varchar) as Analyst,
                                operator_name as SPV,
                                FROM_UNIXTIME(update_time/1000) AS assign_time 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 2)
                              ) b 
        
                          on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id 
        
                      where analyst is not null) b


                  on a.id = b.case_order_id


                  left join (
                    select 
                      case_order_id,
                      FROM_UNIXTIME(update_time/1000) AS close_time  
                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                    where event_id = 8 )  c 
                  
                  on a.id = c.case_order_id
                  
                  
                  left join (
                    select 
                      case_order_id, 
                      operator_name as QA,
                      FROM_UNIXTIME(update_time/1000) AS QA_time  
                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                    where event_id = 10 )  d 
                  
                  on a.id = d.case_order_id 
                  
                  
                  left join (
                    select 
                      a.case_order_id, 
                      Analyst_2, 
                      a.assign_time_2  
                    from (
                      select 
                        case_order_id, 
                        max (assign_time_2) as assign_time_2  
                      from (
                        select 
                          case_order_id, 
                          CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                          FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                        from  mysql_risk_cms.riskantifrauddb.r_case_log 
                        where event_id = 4 
                          and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                        )
                      group by 1) a
                  
                    left join (
                      select 
                        case_order_id, 
                        CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                        FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                      from  mysql_risk_cms.riskantifrauddb.r_case_log 
                      where event_id = 4 
                        and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                    ) b
                    
                    on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id )  e
                  
                  on a.id = e.case_order_id)

                where analyst_2 is not null)

              union 
        
              select 
                *, 
                analyst as analyst_3 
              from (
                select 
                  * 
                from (
                  select distinct id as ticket , *
                  from (
                    select 
                      id,
                      deleted, 
                      creator as Issuer_tiket,
                      FROM_UNIXTIME(create_time/1000) AS create_time  
                    from mysql_risk_cms.riskantifrauddb.r_case_order where deleted = 0 ) a
       
        -- and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
       
                left join (
                  select 
                    a.case_order_id, 
                    Analyst, 
                    a.assign_time, 
                    SPV  
                  from (
                    select 
                      case_order_id, 
                      max (assign_time) as assign_time  
                    from (
                      select 
                        * 
                      from (
                        select 
                          case_order_id,
                          CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                          operator_name as SPV,
                          FROM_UNIXTIME(update_time/1000) AS assign_time 
                        from  mysql_risk_cms.riskantifrauddb.r_case_log 
                        where event_id = 2 ) 
                      where Analyst is not null  
                      
                      union 
                      
                      select 
                        * 
                      from (
                        select 
                          case_order_id, 
                          CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                          operator_name as SPV,
                          FROM_UNIXTIME(update_time/1000) AS assign_time 
                        from  mysql_risk_cms.riskantifrauddb.r_case_log 
                        where event_id = 2 ) 
                      where Analyst is not null)
                  group by 1) a
        
                  left join (
                    select 
                      * 
                    from (
                      select 
                        case_order_id, 
                        CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                        operator_name as SPV,
                        FROM_UNIXTIME(update_time/1000) AS assign_time 
                      from  mysql_risk_cms.riskantifrauddb.r_case_log 
                      where event_id = 2 ) 
                    where Analyst is not null  
        
                    union 
                    
                    select 
                      * 
                    from (
                      select 
                        case_order_id, 
                        CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                        operator_name as SPV,
                        FROM_UNIXTIME(update_time/1000) AS assign_time 
                      from  mysql_risk_cms.riskantifrauddb.r_case_log 
                      where event_id = 2 ) 
                    where Analyst is not null) b
        
                  on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id) b 
                
                on a.id = b.case_order_id

                left join (
                  select 
                    case_order_id,
                    FROM_UNIXTIME(update_time/1000) AS close_time  
                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                  where event_id = 8 )  c 
                
                on a.id = c.case_order_id
                
                left join (
                  select 
                    case_order_id, 
                    operator_name as QA,
                    FROM_UNIXTIME(update_time/1000) AS QA_time  
                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                  where event_id = 10 )  d 
                on a.id = d.case_order_id 
            
                left join (
                  select 
                    a.case_order_id, 
                    Analyst_2, 
                    a.assign_time_2  
                  from (
                    select 
                      case_order_id,
                      max (assign_time_2) as assign_time_2  
                    from (
                      select 
                        case_order_id, 
                        CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                        FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                      from  mysql_risk_cms.riskantifrauddb.r_case_log 
                      where event_id = 4 
                        and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') )
                  group by 1) a

                left join (
                  select 
                    case_order_id, 
                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                    FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                  where event_id = 4 
                    and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') ) b
                
                  on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id )  e
        
                on a.id = e.case_order_id)
      
                where analyst_2 is null)
                ORDER BY analyst_3)
            )
            
            where assign_time_2 is not null)
        
        
            union 
        
            select 
                * 
            from (
                select 
                    ticket,	
                    Issuer_tiket,
                    analyst_3 as analyst,
                    QA,	
                    SPV,
                    create_time, 
                    assign_time as assign_time_3,
                    close_time,	
                    QA_time
                from (
                    select 
                        * 
                    from (
                        select 
                            *, 
                            analyst_2 as analyst_3  
                        from (
                            select *
                        from (
                            select 
                                distinct id as ticket,
                                *
                            from (
                                select 
                                    id,
                                    deleted,
                                    creator as Issuer_tiket,
                                    FROM_UNIXTIME(create_time/1000) AS create_time  
                                from mysql_risk_cms.riskantifrauddb.r_case_order 
                                where deleted = 0) a
        
                                  --and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
        
                            left join (
                              select 
                                a.case_order_id, 
                                Analyst, 
                                a.assign_time,
                                SPV  
                              from (
                                select 
                                  case_order_id,
                                  max (assign_time) as assign_time  
                                from (
                                  select 
                                    * 
                                  from (
                                    select 
                                      case_order_id, 
                                      CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                      operator_name as SPV,
                                      FROM_UNIXTIME(update_time/1000) AS assign_time 
                                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                    where event_id = 2)  
                                  
                                  union 
                                  
                                  select * from (
                                    select 
                                      case_order_id, 
                                      CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                      operator_name as SPV,
                                      FROM_UNIXTIME(update_time/1000) AS assign_time 
                                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                    where event_id = 2 )
                                )
                              group by 1) a
                            
                            left join (
                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2 ) 
                            
                            union 
                            
                            select * from (
                              select 
                                case_order_id, 
                                CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                operator_name as SPV,
                                FROM_UNIXTIME(update_time/1000) AS assign_time 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 2 )
                            )b 
                            
                            on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id 
                            where analyst is not null ) b 
                            
                        on a.id = b.case_order_id
                            
                        left join (
                          select 
                            case_order_id,
                            FROM_UNIXTIME(update_time/1000) AS close_time  
                          from  mysql_risk_cms.riskantifrauddb.r_case_log 
                          where event_id = 8)  c 
                          
                        on a.id = c.case_order_id
                            
                        left join (
                          select 
                            case_order_id, 
                            operator_name as QA,
                            FROM_UNIXTIME(update_time/1000) AS QA_time 
                          from  mysql_risk_cms.riskantifrauddb.r_case_log 
                          where event_id = 10 )  d 
                        
                        on a.id = d.case_order_id 
                            
                            
                        left join (
                          select 
                            a.case_order_id, 
                            Analyst_2, 
                            a.assign_time_2  
                          from (
                            select 
                              case_order_id,
                              max (assign_time_2) as assign_time_2  
                            from (
                              select 
                                case_order_id, 
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 4 
                              and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') )
                            group by 1) a
                            
                            left join (
                              select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 4 
                              and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya', 'ekaputra','yogi.rahmadi','yudi.irawan') 
                            ) b
                            
                            on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id
                        )  e
                            
                        on a.id = e.case_order_id)
                        where analyst_2 is not null)
                            
                        union 
                        
                        select 
                          * ,
                          analyst as analyst_3 
                        from (
                          select * from (
                            select 
                              distinct id as ticket,
                              *
                            from (
                              select 
                                id,
                                deleted,
                                creator as Issuer_tiket,
                                FROM_UNIXTIME(create_time/1000) AS create_time  
                              from mysql_risk_cms.riskantifrauddb.r_case_order where deleted = 0 ) a
                                -- and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
                            
                            left join (
                              select 
                                a.case_order_id, 
                                Analyst, 
                                a.assign_time, 
                                SPV 
                              from (
                                select 
                                  case_order_id, 
                                  max (assign_time) as assign_time  
                                from (
                                  select * from (
                                    select 
                                      case_order_id, 
                                      CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                      operator_name as SPV ,FROM_UNIXTIME(update_time/1000) AS assign_time 
                                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                    where event_id = 2) 
                                where Analyst is not null  
                                
                                union 
                                
                                select * from (
                                  select 
                                    case_order_id, 
                                    CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2) 
                                where Analyst is not null)
                              group by 1) a
                            
                              left join (
                                select * from (
                                  select 
                                    case_order_id, 
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2 ) 
                                where Analyst is not null  
                            
                                union 
                            
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2) 
                                where Analyst is not null) b
                              
                              on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id)  b 
                            
                            on a.id = b.case_order_id
                            
                            left join (
                              select 
                                case_order_id,
                                FROM_UNIXTIME(update_time/1000) AS close_time  
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 8)  c 
                            
                            on a.id = c.case_order_id
                            
                            left join (
                              select 
                                case_order_id,
                                operator_name as QA,
                                FROM_UNIXTIME(update_time/1000) AS QA_time  
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 10) d 
                            
                            on a.id = d.case_order_id 
                            
                            left join (
                              select 
                                a.case_order_id, 
                                Analyst_2, 
                                a.assign_time_2  
                              from (
                                select 
                                  case_order_id, 
                                  max (assign_time_2) as assign_time_2  
                                from (
                                  select 
                                    case_order_id, 
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 4 
                                  and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') )
                                group by 1) a
                            
                                left join (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 4 
                                  and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                                  ) b
                                
                                on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id)  e
                            
                            on a.id = e.case_order_id)
                            
                        where analyst_2 is null)
                      
                      ORDER BY analyst_3) )
                      
                where assign_time_2 is null)
              )
        ) a
--end table 1
                            
        left join (
          select 
            id,
            case_type, 
            case_config_source_id, 
            case_config_reason_id, 
            case_config_clue_id, 
            case_config_result_id,
            case_target  
          from  mysql_risk_cms.riskantifrauddb.r_case_order) b
          
          on a.ticket = b.id 
                            
          left join (
            select 
              case_order_id, 
              CAST(channel_uid AS varchar ) as channel_uid  
            from mysql_risk_cms.riskantifrauddb.r_case_order_relate_uid ) c
          
          on a.ticket = c.case_order_id 
                            
          left join (
            select 
              channel_uid as C_uid, 
              credit_user_nm  
            from  dim.afi_user_info) d
          
          on c.channel_uid = d.C_uid
                            
          left join (
            select 
              CAST(vendor_id AS varchar ) as vendor_id, 
              vendor_name 
            from dim.asi_shop) e
          
          on c.channel_uid = e.vendor_id ) 
          where credit_user_nm not in ('') OR credit_user_nm is not null
          
          union -- merge Name column
          
          select 
            *, 
            vendor_name as NAME 
          from (
            select * from (
  --table 2
              select * from (
                select 
                  ticket,
                  Issuer_tiket,
                  analyst,
                  QA,
                  SPV,
                  create_time,
                  assign_time_3 as assign_time,	
                  close_time,	
                  QA_time 
                from (
                  select 
                    ticket,
                    Issuer_tiket,
                    analyst_3 as analyst,	
                    QA,
                    SPV,
                    create_time,
                    assign_time_2 as assign_time_3,	
                    close_time,	
                    QA_time
                  from (
                    select * from (
                      select 
                        * ,
                        analyst_2 as analyst_3  
                      from (
                        select * 
                        from (
                          select 
                            distinct id as ticket,
                             *
                          from (
                            select 
                              id,
                              deleted,
                              creator as Issuer_tiket,
                              FROM_UNIXTIME(create_time/1000) AS create_time  
                            from mysql_risk_cms.riskantifrauddb.r_case_order 
                            where deleted = 0 )a
         
                             --and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
          
          
          
                            left join (
                              select 
                                a.case_order_id,
                                Analyst, 
                                a.assign_time, 
                                SPV  
                              from (
                                select 
                                  case_order_id, 
                                  max (assign_time) as assign_time  
                                from (
                                  select * from (
                                    select 
                                      case_order_id, 
                                      CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                      operator_name as SPV,
                                      FROM_UNIXTIME(update_time/1000) AS assign_time 
                                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2 )  
                                  
                                  union 
                                  
                                  select * from (
                                    select 
                                      case_order_id,
                                      CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                      operator_name as SPV,
                                      FROM_UNIXTIME(update_time/1000) AS assign_time 
                                    from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                    where event_id = 2 )
                                )
                              group by 1) a
          
                              left join (
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                    operator_name as SPV ,FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2
                                ) 
          
                                union 
                                
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2 )
                              ) b 
                            
                            on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id 
          
                            where analyst is not null) b 
          
                        
                        on a.id = b.case_order_id

                        left join (
                          select 
                            case_order_id,
                            FROM_UNIXTIME(update_time/1000) AS close_time  
                          from  mysql_risk_cms.riskantifrauddb.r_case_log 
                          where event_id = 8 )  c 
                        
                        on a.id = c.case_order_id
                          
                        left join (
                          select 
                            case_order_id,
                            operator_name as QA,
                            FROM_UNIXTIME(update_time/1000) AS QA_time 
                          from  mysql_risk_cms.riskantifrauddb.r_case_log 
                          where event_id = 10 ) d 
                        
                        on a.id = d.case_order_id 
                          
                        left join (
                          select 
                            a.case_order_id,
                            Analyst_2, 
                            a.assign_time_2 
                          from (
                            select 
                              case_order_id,
                              max (assign_time_2) as assign_time_2  
                            from (
                              select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                            )
                          group by 1) a
                          
                          left join (
                            select 
                              case_order_id,
                              CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                              FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                          ) b
                          
                          on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id 
                        
                          )  e
                          
                        on a.id = e.case_order_id
                        
                        )
        
                        where analyst_2 is not null
                      )
      
                      union 
          
                      select 
                        *, 
                        analyst as analyst_3 
                      from (
                        select * from (
                          select 
                            distinct id as ticket,
                            *
                          from (
                            select 
                              id,
                              deleted,
                              creator as Issuer_tiket,
                              FROM_UNIXTIME(create_time/1000) AS create_time  
                            from mysql_risk_cms.riskantifrauddb.r_case_order 
                            where deleted = 0) a
                              -- and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
                      
                          left join (
                            select 
                              a.case_order_id,
                              Analyst , 
                              a.assign_time, 
                              SPV  
                            from (
                              select 
                                case_order_id,
                                max (assign_time) as assign_time  
                              from (
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2) 
                                where Analyst is not null  
                                
                                union 
                                
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2) 
                                where Analyst is not null
                              )
                            group by 1) a
                        
                            left join (
                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                  operator_name as SPV ,FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2
                              ) 
                              where Analyst is not null  
                            
                              union 
                              
                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2
                              ) 
                            
                            where Analyst is not null) b
                            
                            on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id
                          
                          
                          )  b 
                        
                          on a.id = b.case_order_id
                        
                          left join (
                            select 
                              case_order_id,
                              FROM_UNIXTIME(update_time/1000) AS close_time  
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 8 ) c 
                          
                          on a.id = c.case_order_id
                        
                          left join (
                            select 
                              case_order_id, 
                              operator_name as QA,
                              FROM_UNIXTIME(update_time/1000) AS QA_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 10
                          )  d 
                        
                          on a.id = d.case_order_id 
                        
                          left join (
                            select 
                              a.case_order_id,
                              Analyst_2,
                              a.assign_time_2 
                            from (
                              select 
                                case_order_id,
                                max (assign_time_2) as assign_time_2  
                              from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                              )
                            group by 1) a
                        
                            left join (
                              select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                            ) b
                            
                            on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id 
                      
                          )  e
                        
                          on a.id = e.case_order_id
                        )
                      
                        where analyst_2 is null
                      )
                      ORDER BY analyst_3
                    )
                    
                  )
                  where assign_time_2 is not null
                )
                
                union 
                
                select * from (
                  select 
                    ticket,	
                    Issuer_tiket,	analyst_3 as analyst,	
                    QA,	
                    SPV,
                    create_time, 	
                    assign_time as assign_time_3,	
                    close_time,	
                    QA_time
                  from (
                    select * from (
                      select 
                        *, 
                        analyst_2 as analyst_3 
                      from (
                        select * 
                        from (
                          select 
                            distinct id as ticket, *
                          from (
                            select 
                              id, 
                              deleted,
                              creator as Issuer_tiket,
                              FROM_UNIXTIME(create_time/1000) AS create_time  
                            from mysql_risk_cms.riskantifrauddb.r_case_order 
                            where deleted = 0
                          ) a
                            --and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
                    
                          left join (
                            select 
                              a.case_order_id,
                              Analyst, 
                              a.assign_time,
                              SPV  
                            from (
                              select 
                                case_order_id,
                                max (assign_time) as assign_time  
                              from (
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2 
                                )  
                              
                                union 
                                
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                    where event_id = 2 
                                )
                              )
                          
                              group by 1
                            ) a
                          
                          
                            left join (
                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2 
                              ) 
                              
                              union 
                              
                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2 
                              )
                            ) b 
                          
                            on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id 
                            
                            where analyst is not null
                          ) b 
                          
                          on a.id = b.case_order_id
                          
                          left join (
                            select 
                              case_order_id,
                              FROM_UNIXTIME(update_time/1000) AS close_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 8) c 
                          
                          on a.id = c.case_order_id
                          
                          left join (
                            select 
                              case_order_id, operator_name as QA,
                              FROM_UNIXTIME(update_time/1000) AS QA_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 10 
                          ) d 
                          
                          on a.id = d.case_order_id 
                          
                          
                          left join (
                            select 
                              a.case_order_id,
                              Analyst_2, 
                              a.assign_time_2 
                            from (
                              select 
                                case_order_id, 
                                max (assign_time_2) as assign_time_2  
                              from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                              )
                              group by 1
                            ) a
                          
                            left join (
                              select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2 ,FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                            ) b
                            
                            on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id

                          ) e
                        
                          on a.id = e.case_order_id
                 
                        )
                        where analyst_2 is not null
                      )
                    
                      union 

                      select 
                        *, 
                        analyst as analyst_3 
                      from (
                        select * from (
                          select 
                            distinct id as ticket, 
                            *
                          from (
                            select 
                              id,
                              deleted,
                              creator as Issuer_tiket,
                              FROM_UNIXTIME(create_time/1000) AS create_time  
                            from mysql_risk_cms.riskantifrauddb.r_case_order 
                            where deleted = 0
                          )a
                              -- and cast (substr(mte(create_time,7),1,10) as date) >= date ('2021-09-23'))a
                      
                          left join (
                            select 
                              a.case_order_id,
                              Analyst,
                              a.assign_time,
                              SPV  
                            from (
                              select 
                                case_order_id,
                                max (assign_time) as assign_time  
                              from (
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2 ) 
                                where Analyst is not null  
                                
                                union 
                                
                                select * from (
                                  select 
                                    case_order_id,
                                    CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                    operator_name as SPV,
                                    FROM_UNIXTIME(update_time/1000) AS assign_time 
                                  from mysql_risk_cms.riskantifrauddb.r_case_log 
                                  where event_id = 2 ) 
                                where Analyst is not null
                              )
                            group by 1
                            ) a
                      
                            left join (
                              select * from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2 ) 
                              where Analyst is not null  
                            
                              union 
                              
                              select * from (
                                select 
                                  case_order_id , 
                                  CAST(json_extract(content , '$.operator_name') AS varchar) as Analyst,
                                  operator_name as SPV,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 2) 
                              where Analyst is not null
                            ) b
                            
                            on a.assign_time = b.assign_time and a.case_order_id = b.case_order_id
                          )  b 
                      
                          on a.id = b.case_order_id
                      
                          left join (
                            select 
                              case_order_id,
                              FROM_UNIXTIME(update_time/1000) AS close_time 
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 8
                          )  c 
                      
                          on a.id = c.case_order_id
                      
                      
                          left join (
                            select 
                              case_order_id, 
                              operator_name as QA,
                              FROM_UNIXTIME(update_time/1000) AS QA_time  
                            from  mysql_risk_cms.riskantifrauddb.r_case_log 
                            where event_id = 10
                          )  d 
                          
                          on a.id = d.case_order_id 
                      
                          left join (
                            select 
                              a.case_order_id,
                              Analyst_2,
                              a.assign_time_2  
                            from (
                              select
                                case_order_id,
                                max (assign_time_2) as assign_time_2  
                              from (
                                select 
                                  case_order_id,
                                  CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                  FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                                from  mysql_risk_cms.riskantifrauddb.r_case_log 
                                where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') )
                              group by 1) a
                            
                            left join (
                              select 
                                case_order_id,
                                CAST(json_extract(content , '$.investigator_name') AS varchar) as Analyst_2,
                                FROM_UNIXTIME(update_time/1000) AS assign_time_2 
                              from  mysql_risk_cms.riskantifrauddb.r_case_log 
                              where event_id = 4 and CAST(json_extract(content , '$.investigator_name') AS varchar) not in ('Radhitya','ekaputra','yogi.rahmadi','yudi.irawan') 
                            ) b
                            
                            on a.assign_time_2 = b.assign_time_2 and a.case_order_id = b.case_order_id
                          )  e
                      
                          on a.id = e.case_order_id
                        )
                        
                        where analyst_2 is null
                      )
                      ORDER BY analyst_3
                    )
                  )
                  where assign_time_2 is null
                )
              )        
            ) a
              --end table 2
            
            
            
            left join (
              select 
                id,
                case_type,
                case_config_source_id,
                case_config_reason_id,
                case_config_clue_id, 
                case_config_result_id,
                case_target 
              from  mysql_risk_cms.riskantifrauddb.r_case_order
            ) b
            
            on a.ticket = b.id 
            
            left join (
              select 
                case_order_id,
                CAST(channel_uid AS varchar) as channel_uid 
              from mysql_risk_cms.riskantifrauddb.r_case_order_relate_uid) c
            
            on a.ticket = c.case_order_id 
            
            left join (
              select
                channel_uid  as C_uid,
                credit_user_nm  
              from  dim.afi_user_info
            ) d
            
            on c.channel_uid = d.C_uid
            
            
            left join (
              select 
                CAST(vendor_id AS varchar) as vendor_id, 
                vendor_name 
              from dim.asi_shop ) e
            
            on c.channel_uid = e.vendor_id) 
            
    where credit_user_nm in ('') OR credit_user_nm is null) aa


    left join (
      select 
        id as code_source, 
        ind_text as Case_source 
      from mysql_risk_cms.riskantifrauddb.r_case_config_source
    ) f
    
    on aa.case_config_source_id = f.code_source 
    
    left join (
      select 
        id as code_config_reason, 
        en_text as config_reason 
      from mysql_risk_cms.riskantifrauddb.r_case_config_reason
    ) g
    
    on aa.case_config_reason_id = g.code_config_reason
    
    left join (
      select 
        id as code_config_clue,
        ind_text as config_clue 
      from mysql_risk_cms.riskantifrauddb.r_case_config_clue
    ) h
    
    on aa.case_config_clue_id = h.code_config_clue
    
    left join (
      select 
        case_order_id, 
        remark_text,
        regexp_extract(remark_text,'^(\d+).(\d+).(\d+).(\d+)|^(\d+).(\d+).(\d+)|^(\d+).(\d+)|^(\d+)|^ (\d+).(\d+).(\d+).(\d+)|^ (\d+).(\d+).(\d+)|^ (\d+).(\d+)|^ (\d+)') as Action,
        regexp_extract(lower(remark_text),'suspect_fraud :(.*)|suspect_fraud:(.*)') as IS_Suspect 
      from mysql_risk_cms.riskantifrauddb.r_case_order_remark_info 
      where case_type = 1 
        and remark_type = 0 
    ) i
    
    on aa.ticket = i.case_order_id
    
    left join (
      select 
        case_order_id,
        remark_text as remark_QA,
        regexp_extract(remark_text,'^(\d+)') as Is_finding, 
        regexp_extract(lower(remark_text),'category_finding :(.*)|category_finding:(.*)') as Category_finding 
      from mysql_risk_cms.riskantifrauddb.r_case_order_remark_info 
      where case_type = 3 
        and remark_type = 0 
    ) j
    
    on aa.ticket = j.case_order_id

  )
  where date_create >= '2022-05-01'
    and Analyst not in ('','leviana.sari','rita.fatiha','gilang.yulian','yudha.eka','bayu','sophia.tan')
  order by ticket asc
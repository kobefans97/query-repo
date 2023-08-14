with raw_qa_rvc as (
    select 
        distinct cast(cast(tanggal_selesai_verifikasi as timestamp) as date) as create_date,
        penugasan,
        skenario_telepon,
        no_pengajuan,
        channel_uid,
        phone_num,
        case
            when agent = 'adityaboas.convergence.al' then 'Aditya Boas'
            when agent = 'gita.convergence.al' then 'Aulia Gita Subchani'
            when agent = 'rivanrinaldi.convergence.al' then 'Rivan Rinaldi'
            when agent = 'ridam.convergence.al' then 'Andreas Ridam Wicaksono'
            when agent = 'anisadamar.convergence.al' then 'Anisa Damar Fitriana'
            when agent = 'wisnusetyo.convergence.al' then 'Wisnu Setyo Adi Nugroho'
            when agent = 'nursalim.convergence.al' then 'Nursalim Rosidi'
            when agent = 'larasati.convergence.al' then 'Larasati Khoirunnisa'
            when agent = 'Duwisantoso.convergence.al' then 'Duwi Santoso'
            when agent = 'anggitkurnia.convergence.al' then 'Anggit Kurniawati'
            when agent = 'monica.convergence.al' then 'Monica Rizky Octaviani'
            when agent = 'ellaa.convergence.al' then 'Ella Oktaviani'
            when agent = 'arum.convergence.al' then 'Arum Minanti'
            when agent = 'serelia.convergence.al' then 'Serelia Dewi Fatima'
            when agent = 'juanmega.convergence.al' then 'Juan Mega Yharti'
            when agent = 'putridwiutami.convergence.al' then 'Putri Dwi Utami'
            when agent = 'fatchiyatul.convergence.al' then 'Fatchiyatul Hidayah'
            when agent = 'wanti.convergence.al' then 'Wanti'
            when agent = 'edywahyuaji.convergence.al' then 'Edy Wahyuaji'
            when agent = 'yohanita.convergence.al' then 'Yohanita Binayu Atmajanti'
            when agent = 'dinar.convergence.al' then 'Dinar Apriliana'
            when agent = 'dheny.convergence.al' then 'Dheny Ananda Arfa'
            else null
        end as agent,
        coalesce(nullif(call_1, null), '') as call_1,
        coalesce(nullif(call_2, null), '') as call_2,
        coalesce(nullif(call_3, null), '') as call_3,
        case
            when hasil_akhir = '7. Orang lain yang mengangkat telepon' then 'Orang lain yang mengangkat telepon'
            when hasil_akhir = '2. Tidak terhubung' then 'Tidak terhubung'
            when hasil_akhir = '1. Verifikasi Normal' then 'Verifikasi Normal'
            when hasil_akhir = '6. Verifikasi data diri tidak sesuai' then 'Verifikasi data diri tidak sesuai'
            when hasil_akhir = '8. Highrisk Non Fraud' then 'Highrisk Non Fraud'
            when hasil_akhir = '4. Dugaan Penipuan' then 'Dugaan Penipuan'
            when hasil_akhir = '5. Menolak verifikasi' then 'Menolak verifikasi'
            when hasil_akhir = '3. Nomer Tidak Valid/Salah' then 'Nomer Tidak Valid/Salah'
            else null
        end as hasil_akhir,
        case
            when hasil_kedua = '7.b. Nomer bukan milik user, mengenal user' then 'Nomer bukan milik user, mengenal user'
            when hasil_kedua = '2. Tidak terhubung' then 'Tidak terhubung'
            when hasil_kedua = '1. Verifikasi Normal' then 'Verifikasi Normal'
            when hasil_kedua = '7.a. Nomer milik user, mengenal user' then 'Nomer milik user, mengenal user'
            when hasil_kedua = '6.c. TTL tidak sesuai' then 'TTL tidak sesuai'
            when hasil_kedua = '8.a. Benar transaksi, dibantu orang lain' then 'Benar transaksi, dibantu orang lain'
            when hasil_kedua = '4.g. Dokumen Tidak Valid' then 'Dokumen tidak valid'
            when hasil_kedua = '5. Menolak verifikasi' then 'Menolak verifikasi'
            when hasil_kedua = '6.b. Tanggal lahir tidak sesuai' then 'Tanggal Lahir Tidak Sesuai'
            when hasil_kedua = '4.d. Tidak melakukan transaksi dan tidak merasa membagikan OTP/Pass maupun isi link' then 'Tidak melakukan transaksi dan tidak merasa membagikan OTP/Pass maupun isi link'
            when hasil_kedua = '4.a. Tidak melakukan transaksi dan membagikan OTP/Pass' then 'Tidak melakukan transaksi dan membagikan OTP/Pass'
            when hasil_kedua = '6.a. Tempat Lahir tidak sesuai' then 'Tempat Lahir tidak sesuai'
            when hasil_kedua = '3. Nomer Tidak Valid/Salah' then 'Nomer Tidak Valid/Salah'
            when hasil_kedua = '7.c. Nomer bukan milik user, tidak mengenal user' then 'Nomer bukan milik user, tidak mengenal user'
            when hasil_kedua = '4.e. Transaksi diarahkan oleh penipu/orang tak dikenal' then 'Transaksi diarahkan oleh penipu/orang tak dikenal'
            when hasil_kedua = '4.c. Tidak melakukan transaksi dan mengisi link ilegal,share OTP/Pass' then 'Tidak melakukan transaksi dan tidak merasa membagikan OTP/Pass maupun isi link'
            when hasil_kedua = '4.b. Tidak melakukan transaksi dan mengisi link ilegal' then 'Tidak melakukan transaksi dan mengisi link ilegal'
            else null
        end as hasil_kedua,
        if (frozen_flag = 1, 'IYA','TIDAK') as frozen_flag,
        '' as tanggal_blokir,
        '' as Apakah_sudah_diinput,
         if (sent_flag = 1, 'IYA','TIDAK') as sent_flag,
        remark
    from hive.risk_analysis.eric_af_rvc
    where date(cast(cast(tanggal_selesai_verifikasi as timestamp) as date)) = current_date - interval '1' day
        and agent is not null
        and status_verifikasi = 'Selesai verifikasi telepon'
),

ranked_data as (
    select 
        *, 
        row_number() over (partition by agent,create_date order by no_pengajuan desc) as rn
    from raw_qa_rvc
),

data_qa1 as (
select 
    row_number() over () as no,
    *
from ranked_data
),

data_qa as (
    select 
        *
    from data_qa1
    where 
    if (no >= 800,
        rn <= (
                select 
                    round(MAX(cast(rn as double))/2) 
                from data_qa1 as sub 
                where sub.agent = data_qa1.agent
        ),
        rn > 0
    )
),

qa_sample as (
select 
    *, 
    if ( no % 2 = 0,
        'Muhammad Maygi Syahbanu',
        'Pranika Giri Hastuti'
        ) 
    as qa_name
from data_qa
order by 1, qa_name asc
)

select 
    no,
    create_date,
    penugasan,
    skenario_telepon,
    no_pengajuan,
    channel_uid,
    phone_num,
    agent,
    call_1,
    call_2,
    call_3,
    hasil_akhir,
    hasil_kedua,
    frozen_flag,
    tanggal_blokir,
    apakah_sudah_diinput,
    sent_flag,
    remark,
    qa_name,
    current_date as tanggal_sebar_data
from qa_sample


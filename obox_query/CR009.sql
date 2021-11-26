SELECT 
'D' as flag_detail, '001' sandi_kantor, rn.Nama, d.Kode, rn.KTP, d.`GolonganKredit`, d.`Rekening`, d.`JenisPenggunaan`, d.`GolonganDebiturLBBPR`, d.`SektorEkonomiLBBPR`, d.`KategoriUsahaLBBPR`, d.`SukuBunga`, d.`CaraPerhitunganLBBPR`, NULL as jumlah_rekening
FROM 
debitur d
JOIN registernasabah rn ON d.Kode = rn.Kode
LIMIT 100;
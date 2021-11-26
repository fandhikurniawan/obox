SELECT 
'D' as flag_detail, '001' sandi_kantor, rn.Nama, d.Kode, rn.KTP, d.GolonganKredit, d.`Rekening`, d.`GolonganDebiturLBBPR`,
ad.tgl as top_up
FROM 
debitur d
JOIN registernasabah rn ON d.Kode = rn.Kode
JOIN adendum ad ON ad.Rekening = d.rekening
-- GROUP BY d.Kode
LIMIT 100;
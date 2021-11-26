SELECT 
'D' as flag_detail, t.Kode, rn.`Nama`, rn.KTP,
COUNT(mt.ID) jenis_dpk, SUM(mt.jumlah) as nominal
FROM 
tabungan t
JOIN registernasabah rn ON t.Kode = rn.Kode
JOIN mutasitabungan mt ON mt.`Rekening` = t.`Rekening`
GROUP BY t.Rekening
ORDER BY nominal DESC
LIMIT 20;
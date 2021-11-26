SELECT 
'D' as FlagDetail, sk.SandiKantor, d.CabangEntry, rn.Nama as NamaDebitur, d.Kode as NoCIF, rn.KTP as NoIdentitas, d.GolonganKredit KodeKelompokKredit, d.Rekening, d.JenisLBBPR JenisKredit,
DATE_FORMAT(d.tgl, '%Y%m%d') as TanggalMulai, DATE_FORMAT(DATE_ADD(d.tgl, INTERVAL d.lama MONTH), '%Y%m%d') as TanggalJatuhTempo,
d.GolonganDebiturLBBPR JenisDebitur, d.SektorEkonomiLBBPR SektorEkonomi, d.KategoriUsahaLBBPR KategoriUsaha,
d.SukuBunga, d.CaraPerhitunganLBBPR PerhitunganSukuBunga, d.Plafond PlafondAwal, d.Plafond PlafondEfektif, d.Plafond BakiDebet, ag.Jaminan, ag.NilaiYangDiPerhitungkan
FROM 
debitur d
JOIN registernasabah rn ON d.Kode = rn.Kode
LEFT JOIN agunan ag ON d.Rekening = ag.Rekening
JOIN sandikantor sk ON sk.CabangEntry = d.CabangEntry 
WHERE DATE_ADD(d.tgl, INTERVAL d.lama MONTH) BETWEEN DATE_SUB(curdate(), INTERVAL 2 WEEK) AND curdate()
AND sk.SandiKantor IN (001, 002)
ORDER BY d.Plafond DESC
LIMIT 20;
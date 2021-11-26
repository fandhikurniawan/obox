SELECT 
'D' as FlagDetail, sk.SandiKantor, d.CabangEntry, rn.Nama as NamaDebitur, d.Kode as NoCIF, rn.KTP as NoIdentitas, d.GolonganKredit KodeKelompokKredit, d.Rekening, d.`GolonganDebiturLBBPR` JenisKredit,
DATE_FORMAT(ad.tgl, '%Y%m%d') as TanggalTopUp,
(ang.`DPokok` - ang.`KPokok`) as PlafonSebelum,
(ang.`DPokok` - ang.`KPokok` + ad.`Plafond`) as PlafonSesudah,
(ang.`DPokok` - ang.`KPokok` + ad.`Plafond`) - (ang.`DPokok` - ang.`KPokok`) as SelisihPlafon,
(d.`Plafond` - ang.`KPokok`) as BakiDebetSebelum,
(d.`Plafond` - ang.`KPokok` + ad.`Plafond`) as BakiDebetSesudah,
(d.`Plafond` - ang.`KPokok` + ad.`Plafond`) - (d.`Plafond` - ang.`KPokok`) as SelisihBakiDebet,
1 as JumlahRekeningSebelum,
1 as JumlahRekeningSesudah
FROM 
debitur d
JOIN registernasabah rn ON d.Kode = rn.Kode
JOIN adendum ad ON ad.Rekening = d.rekening
JOIN angsuran ang ON ang.Rekening = d.rekening
JOIN sandikantor sk ON sk.CabangEntry = d.CabangEntry 
WHERE DATE_ADD(d.tgl, INTERVAL d.lama MONTH) BETWEEN DATE_SUB(curdate(), INTERVAL 2 WEEK) AND curdate()
AND sk.SandiKantor IN (001, 002)
-- GROUP BY d.rekening
ORDER BY d.rekening DESC
LIMIT 20;
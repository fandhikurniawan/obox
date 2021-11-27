SELECT 
'D' as FlagDetail, sk.SandiKantor, d.CabangEntry, rn.Nama as NamaDebitur, d.Kode as NoCIF, rn.KTP as NoIdentitas, d.GolonganKredit KodeKelompokKredit, d.Rekening, d.`GolonganDebiturLBBPR` JenisKredit,
DATE_FORMAT(ad.tgl, '%Y%m%d') as TanggalTopUp,
@PlafonSebelum := IF(ang.`DPokok` - ang.`KPokok` <= 0, 0, (ang.`DPokok` - ang.`KPokok`)) as PlafonSebelum,
@PlafonSesudah := IF(@PlafonSebelum + ad.`Plafond` <= 0, 0, (@PlafonSebelum + ad.`Plafond`)) as PlafonSesudah,
(@PlafonSesudah - @PlafonSebelum) as SelisihPlafon,
@BakiDebetSebelum := IF(ang.`DPokok` - ang.`KPokok` <= 0, 0, (ang.`DPokok` - ang.`KPokok`)) as BakiDebetSebelum,
@BakiDebetSesudah := IF(@BakiDebetSebelum + ad.`Plafond` <= 0, 0, (@BakiDebetSebelum + ad.`Plafond`)) as BakiDebetSesudah,
(@BakiDebetSesudah - @BakiDebetSebelum) as SelisihBakiDebet,
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
AND (ang.`DPokok` - ang.`KPokok`) > 0
ORDER BY d.rekening DESC
LIMIT 20;
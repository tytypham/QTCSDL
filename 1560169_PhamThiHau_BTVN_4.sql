---Bài 03
DECLARE @MaLop VARCHAR(25),
		@LopTruong NCHAR(25),
		@HoTen NCHAR(25),
		@ĐTB FLOAT,
		@STT INT
	
SET @STT = 1	
SELECT @LopTruong = hv.TenHocVien
FROM HOCVIEN hv JOIN LOPHOC lh ON hv.MaHocVien = lh.LopTruong and lh.MaLop = 'LH000001'

SET @MaLop = 'LH000001'

PRINT '**Lớp: ' + @MaLop
PRINT '**Lớp trưởng: ' + @LopTruong
PRINT '**Danh sách học viên: '

DECLARE cur CURSOR FOR SELECT hv.TenHocVien, SUM(kq.Diem*mh.SoChi)/SUM(mh.SoChi) AS ĐTB
						FROM HOCVIEN hv, KETQUA kq, MONHOC mh
						WHERE hv.MaHocVien = kq.MaHV and kq.MaMonHoc = mh.MaMonHoc
							and hv.MaLop = 'LH000001' and kq.LanThi = (SELECT MAX(kq1.LanThi)
																		FROM KETQUA kq1
																		WHERE kq1.MaHV = kq.MaHV and kq.MaMonHoc = kq.MaMonHoc)
						GROUP BY hv.TenHocVien
OPEN cur
FETCH NEXT FROM cur INTO @HoTen, @ĐTB

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '******' + CONVERT(CHAR(5),@STT)+ '.' + @HoTen + ': ' + CONVERT(VARCHAR(10),@ĐTB)
	SET @STT = @STT + 1
	FETCH NEXT FROM cur INTO @HoTen, @ĐTB
END
CLOSE cur
DEALLOCATE cur
GO



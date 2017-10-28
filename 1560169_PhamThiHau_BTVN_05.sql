--Ten: Phạm Thị Hậu
-- Lớp: 15ck2
-- ca: thực hành chiều thứ 3
-- Phòng 503 TTTH

--cau02:

DECLARE @malop VARCHAR(30),
		@lt VARCHAR(30),
		@hoten VARCHAR(30),
		@diemtb FLOAT
		
SELECT @lt = hv.TenHocVien
FROM HOCVIEN hv JOIN LOPHOC lh ON hv.MaHocVien = lh.LopTruong and lh.MaLop = 'LH000001'

SET @malop = 'LH000001'

PRINT N'**Lớp: ' + @malop
PRINT N'**Lớp trưởng: ' + @lt
PRINT N'**Danh sách học viên: '

DECLARE cur CURSOR FOR SELECT hv.TenHocVien, SUM(kq.Diem*mh.SoChi)/SUM(mh.SoChi) AS ĐTB
						FROM HOCVIEN hv, KETQUA kq, MONHOC mh
						WHERE hv.MaHocVien = kq.MaHV and kq.MaMonHoc = mh.MaMonHoc
							and hv.MaLop = 'LH000001' and kq.LanThi = (SELECT MAX(kq1.LanThi)
																		FROM KETQUA kq1
																		WHERE kq1.MaHV = kq.MaHV and kq.MaMonHoc = kq.MaMonHoc)
						GROUP BY hv.TenHocVien
OPEN cur
FETCH NEXT FROM cur INTO @hoten, @diemtb
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '******. ' + @hoten + ': ' + CONVERT(VARCHAR(10),@diemtb)
	FETCH NEXT FROM cur INTO @hoten, @diemtb
END
CLOSE cur
DEALLOCATE cur
GO
						
--Cau01:

create PROCEDURE TongSoTichLuy @mahv char(10) 
as 
 if(exists (select * from HOCVIEN hv 
					 where hv.MaHocVien = @mahv))
	Begin 
		Select SUM (mh.SoChi) 
		from HOCVIEN hv, KETQUA kq , MONHOC mh
		where hv.MaHocVien = kq.MaHV and kq.MaMonHoc = mh.MaMonHoc and  
				hv.MaHocVien = @mahv and kq.LanThi >1 and kq.Diem >=5
		end 
		else 
		print N'Ma so hoc vien khong hop le '
go
exec TongSoTichLuy 'HV000005'
go


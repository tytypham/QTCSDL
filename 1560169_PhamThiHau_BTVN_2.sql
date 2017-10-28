--Câu 1: cho biet giao vien da tung dạy it nhat 8 hoc vien

SELECT *
FROM  GIAOVIEN gv, LOPHOC lh
WHERE gv.MaGV = lh.GVQuanLi and lh.SiSo < 8

--caau2: cho biết danh sach học viên sinh năm 1990 đã từng làm lớp trưởng 

SELECT *
FROM HOCVIEN hv,LOPHOC lh
WHERE hv.MaLop = lh.MaLop and year(hv.NgaySinh) = 1990 and hv.MaHocVien = lh.LopTruong

-- cau3: cho biet giao vien co kha nag day mon co sso du lieu 
SELECT gvd.MaGV,gvd.MaMH
FROM GIAOVIEN_DAY_MONHOC gvd, MONHOC mh
WHERE gvd.MaMH = mh.MaMonHoc and mh.TenMonHoc = N'Cở sở dữ liệu'

--Cau4: Dem so lan giao vien "nguyen van an " duoc phan cong day mon "MH00005"

SELECT  COUNT (gv.MaGV) as SoLuong
FROM GIAOVIEN gv, PHANCONG pc
WHERE gv.MaGV = pc.MaGV and pc.MaMH = 'MH00005' and gv.TenGV = N'Nguyễn văn an'

--Cau5: Dem so luong ma moi giao vien quan li.xuat ra ma giao vien ,ho ten ,so luong ma ho quan li

SELECT count (lh.MaLop) as SoLuongGV
FROM GIAOVIEN gv , LOPHOC lh
WHERE lh.GVQuanLi = gv.MaGVQuanLi 


--Cau6:cho biet thong tin hoc vien(ma hoc vien ,ho ten) nho tuoi nhat lop "LH00001"

SELECT hv.MaHocVien , hv.TenHocVien
FROM HOCVIEN hv,LOPHOC lh
WHERE hv.MaLop = lh.MaLop and hv.MaLop = 'LH000001' and hv.NgaySinh >= all ( select hv1.NgaySinh
													from HOCVIEN hv1
													where hv1.MaLop = hv.MaLop)
--Cau7: cho biet hoc vien da tung dau mon "mang may tinh'

SELECT hv.TenHocVien, hv.MaHocVien
FROM HOCVIEN hv, MONHOC mh, KETQUA kq
WHERE  hv.MaHocVien = kq.MaHV and mh.TenMonHoc = N'Mạng máy tính' and kq.Diem >=5 and mh.MaMonHoc = kq.MaMonHoc


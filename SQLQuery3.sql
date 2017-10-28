create database TYKUTE
go
create table DONHANG
(
	MaDH char(5) ,
	NgayDatHang datetime
)
create table PhieuDH
(
	MaPG char(5),
	MaDH char(5),
	NgayGiaoHang datetime
)

insert into DONHANG values ('DH1','1/4/2002')
insert into DONHANG values ('DH2','1/2/2001')
insert into PhieuDH values ('PG1','DH1','4/15/2002')
insert into PhieuDH values ('PG2','DH2','4/10/2002')

select *
from DONHANG

select *
from PhieuDH

--Tao trigger cho su kien update tren bang 
create trigger trg_DH_phieuDH on DONHANG
for update 
as
begin
	if exists (select * from inserted I ,PhieuDH p
	where p.MaDH = i.MaDH and ( p.NgayGiaoHang<i.NgayDatHang or DATEDIFF(MM,i.NgayDatHang, p.NgayGiaoHang) >1))
	begin
	Raiserror ('Ngay dat hang khong hop le',16, 1)
	Rollback transaction 
	end 
End

update DONHANG
set NgayDatHang = '05/18/2002'
where MaDH = 'DH1'
--cau8
create function DanhsachGV(@TenMon nvarchar(50))
returns table
as
	return (select gv.* from GIAOVIEN gv, MONHOC mh, PHANCONG pc
						where mh.TenMonHoc like @TenMon 
						and mh.MaMonHoc = pc.MaMH and 
						pc.MaGV = gv.MaGV)
go

select * from dbo.DanhsachGV(N'Cơ sở dữ liệu')
go
--cau5

create function KiemTraChan(@n int)
returns int
as
begin
	if(@n % 2 = 0)
		return 1
	return -1
end
go

declare @kq int
set @kq  = dbo.KiemTraChan(7)
print @kq
go

--cau10


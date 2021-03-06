create database QuanLyAnime
go
use QuanLyAnime
go
create table PHIM
(
ID int identity(1, 1) primary key,
Ten NVARCHAR(500),
NhaSX INT,
SoTap INT,
ThoiLuong INT,
NamPhatHanh INT,
SoLuotThich INT,
SoLuotXem INT,
XepHang INT,
DiemDanhGia NUMERIC(19, 6),
TinhTrangPhim VARCHAR(1),
MoTaPhim NVARCHAR(500),
Hinh1 NVARCHAR(500),
Hinh2 NVARCHAR(500)
)
go
create table THELOAI
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
Ten NVARCHAR(200)
)
go
create table LOAIPHIM
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
Ten NVARCHAR(200)
)
go
create table NHASANXUAT
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
TenNSX NVARCHAR(200)
)
go
create table NHOMDICH
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
TenNhom NVARCHAR(500)
)
go
create table LichChieuPhim
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
Phim INT,
NgayChieu DATETIME
)
go
create table TaiKhoan
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
TenDN varchar(100),
MatKhau varchar(100),
Email varchar(100),
HoTen nvarchar(200),
PhanQuyen INT
)
go
create table TaiKhoan_Phim
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
MaTK int,
MaPhim int
)
go
create table Phim_TheLoai
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
MaPhim INT,
TheLoai INT
)
go
create table HinhAnhPhim
(
ID INT IDENTITY(1, 1) PRIMARY KEY,
MaPhim INT,
HinhAnh NVARCHAR(500)
)
go
insert into LOAIPHIM (Ten) values (N'TV series')
insert into LOAIPHIM (Ten) values (N'Movies')
insert into LOAIPHIM (Ten) values (N'Live Action')
insert into LOAIPHIM (Ten) values (N'Bluray')
go
insert into THELOAI (Ten) values (N'Hành động')
insert into THELOAI (Ten) values (N'Phiêu lưu')
insert into THELOAI (Ten) values (N'Học đường')
insert into THELOAI (Ten) values (N'Hài hước')
insert into THELOAI (Ten) values (N'Trinh thám')
insert into THELOAI (Ten) values (N'Trẻ em')
insert into THELOAI (Ten) values (N'Bạo lực')
insert into THELOAI (Ten) values (N'Lãng mạn')
insert into THELOAI (Ten) values (N'Kinh dị')
insert into THELOAI (Ten) values (N'Viễn tưởng')
insert into THELOAI (Ten) values (N'Lịch sử')
insert into THELOAI (Ten) values (N'Siêu nhiên')
insert into THELOAI (Ten) values (N'Thể thao')
insert into THELOAI (Ten) values (N'Mecha')
go
insert into NHOMDICH (TenNhom) values (N'Zing Fansub')
insert into NHOMDICH (TenNhom) values (N'Kimi')
insert into NHOMDICH (TenNhom) values (N'VNFS')
insert into NHOMDICH (TenNhom) values (N'Devil Player Team')
insert into NHOMDICH (TenNhom) values (N'Fire God Phoenix')
insert into NHOMDICH (TenNhom) values (N'WayA')
insert into NHOMDICH (TenNhom) values (N'X Team')
insert into NHOMDICH (TenNhom) values (N'Olivia Fansub')
insert into NHOMDICH (TenNhom) values (N'ATeam')
insert into NHOMDICH (TenNhom) values (N'Kokocon')
insert into NHOMDICH (TenNhom) values (N'Clip-Sub')


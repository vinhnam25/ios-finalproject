USE [QuanLyAnime]
GO
/****** Object:  Table [dbo].[THELOAI]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THELOAI](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[THELOAI] ON
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (1, N'Hành động')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (2, N'Phiêu lưu')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (3, N'Học đường')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (4, N'Hài hước')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (5, N'Trinh thám')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (6, N'Trẻ em')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (7, N'Bạo lực')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (8, N'Lãng mạn')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (9, N'Kinh dị')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (10, N'Viễn tưởng')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (11, N'Lịch sử')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (12, N'Siêu nhiên')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (13, N'Thể thao')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (14, N'Mecha')
INSERT [dbo].[THELOAI] ([ID], [Ten]) VALUES (15, N'Drama')
SET IDENTITY_INSERT [dbo].[THELOAI] OFF
/****** Object:  Table [dbo].[TaiKhoan_Phim]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan_Phim](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaTK] [int] NULL,
	[MaPhim] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDN] [varchar](100) NULL,
	[MatKhau] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[HoTen] [nvarchar](200) NULL,
	[PhanQuyen] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON
INSERT [dbo].[TaiKhoan] ([ID], [TenDN], [MatKhau], [Email], [HoTen], [PhanQuyen]) VALUES (1, N'admin', N'123456', N'admin@gmail.com', N'Lý Thanh Nam', 1)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
/****** Object:  Table [dbo].[Phim_TheLoai]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phim_TheLoai](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaPhim] [int] NULL,
	[TheLoai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Phim_TheLoai] ON
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (1, 1, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (2, 1, 2)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (3, 1, 4)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (4, 1, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (5, 2, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (6, 2, 2)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (7, 2, 4)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (8, 2, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (9, 3, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (10, 3, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (11, 3, 7)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (12, 4, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (13, 4, 2)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (14, 4, 8)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (15, 4, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (16, 5, 3)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (17, 5, 8)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (18, 5, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (19, 5, 7)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (20, 6, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (21, 6, 3)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (22, 6, 4)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (23, 6, 8)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (24, 7, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (25, 7, 3)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (26, 7, 4)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (27, 7, 8)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (28, 8, 2)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (29, 8, 6)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (30, 8, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (31, 9, 15)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (32, 9, 10)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (33, 10, 1)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (34, 10, 3)
INSERT [dbo].[Phim_TheLoai] ([ID], [MaPhim], [TheLoai]) VALUES (35, 10, 12)
SET IDENTITY_INSERT [dbo].[Phim_TheLoai] OFF
/****** Object:  Table [dbo].[Phim_NhomDich]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phim_NhomDich](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Phim] [int] NULL,
	[NhomDich] [int] NULL,
 CONSTRAINT [PK_Phim_NhomDich] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Phim_NhomDich] ON
INSERT [dbo].[Phim_NhomDich] ([ID], [Phim], [NhomDich]) VALUES (1, 1, 2)
INSERT [dbo].[Phim_NhomDich] ([ID], [Phim], [NhomDich]) VALUES (2, 1, 5)
INSERT [dbo].[Phim_NhomDich] ([ID], [Phim], [NhomDich]) VALUES (3, 1, 6)
INSERT [dbo].[Phim_NhomDich] ([ID], [Phim], [NhomDich]) VALUES (4, 2, 1)
INSERT [dbo].[Phim_NhomDich] ([ID], [Phim], [NhomDich]) VALUES (5, 2, 2)
INSERT [dbo].[Phim_NhomDich] ([ID], [Phim], [NhomDich]) VALUES (6, 2, 7)
SET IDENTITY_INSERT [dbo].[Phim_NhomDich] OFF
/****** Object:  Table [dbo].[PHIM]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PHIM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](500) NULL,
	[NhaSX] [int] NULL,
	[SoTap] [int] NULL,
	[SoTapHienCo] [int] NULL,
	[ThoiLuong] [int] NULL,
	[NamPhatHanh] [int] NULL,
	[SoLuotThich] [int] NULL,
	[SoLuotXem] [int] NULL,
	[XepHang] [int] NULL,
	[DiemDanhGia] [numeric](19, 6) NULL,
	[TinhTrangPhim] [varchar](1) NULL,
	[MoTaPhim] [nvarchar](max) NULL,
	[Hinh1] [nvarchar](500) NULL,
	[Hinh2] [nvarchar](500) NULL,
	[LoaiPhim] [int] NULL,
	[NgayPhatHanh] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK__PHIM__3214EC277F60ED59] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[PHIM] ON
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (1, N'Naruto Dattebayo', 1, 220, 220, 23, 2002, 3011, 8163201, NULL, CAST(8.000000 AS Numeric(19, 6)), N'F', N'12 năm trước, hồ ly 9 đuôi tấn công làng ninja Mộc Diệp, Hokage Đệ Tứ đã đánh bại và phong ấn vào cậu bé Naruto.Từ đó, Naruto bị mọi người xa lánh, vậy nên cậu tìm ra cách được thừa nhận và chú ý duy nhất – qua các trò phá phách và nghịch ngợm.Câu chuyện chính bám theo sự trưởng thành và tiến bộ của Naruto và bạn cậu khi làm ninja, và nhấn mạnh mối quan hệ giữa họ và sự ảnh hưởng của quá khứ đến tính cách họ. Naruto tìm được hai người bạn đồng hành cùng là Uchiha Sasuke và Haruno Sakura, cuộc phiêu lưu bắt đầu.', N'http://photos.animetvn.com/upload/film/5rHPGDc.jpg', N'http://photos.animetvn.com/upload/film_big/iIeeD1b.jpg', 1, CAST(0x0000A74900000000 AS DateTime), CAST(0x0000A74900000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (2, N'One Piece', 2, NULL, 788, 24, 1999, 4441, 10278684, NULL, CAST(8.400000 AS Numeric(19, 6)), N'P', N'One Piece xoay quanh 1 nhóm cướp biển được gọi là Băng Hải tặc Mũ Rơm - Straw Hat Pirates - được thành lập và lãnh đạo bởi thuyền trưởng Monkey D. Luffy. Cậu bé Luffy có ước mơ tìm thấy kho báu vĩ đại nhất, One Piece, của Vua Hải Tặc đời trước Gold D. Roger và trở thành Vua Hải Tặc đời kế tiếp.', N'http://photos.animetvn.com/upload/film/e7c936b5eacd4fd0f89bd7b651954e6b1383245216_full.jpg', N'http://photos.animetvn.com/upload/film_big/mKG3hO2.jpg', 1, CAST(0x0000A73400000000 AS DateTime), CAST(0x0000A73400000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (3, N'Attack on Titan 1', 5, 25, 25, 24, 2013, 2497, 617905, NULL, CAST(8.600000 AS Numeric(19, 6)), N'F', N'Eren Jaeger sống trong một thành phố bao bọc bởi tường đá. Titan giết người ở ngoài đó. Trong nhiều thập kỉ, thành viên của Nhóm trinh thám Legion là những con người duy nhất dám bước ra khỏi bức tường và thu thập thông tin về những Titan. Eren, một người yêu hòa bình, không còn nguyện vọng nào to lớn việc gia nhập họ.', N'http://photos.animetvn.com/upload/film/47347l.jpg', N'https://lh5.googleusercontent.com/-RwL351uoY38/VH-yIyPmAGI/AAAAAAAAZIE/sZm9iB8QCtc/s980/ikZZ6aD.jpg', 1, CAST(0x0000A76A00000000 AS DateTime), CAST(0x0000A76A00000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (4, N'Sword Art Online 1', 4, 25, 25, 23, 2012, 4223, 1330524, NULL, CAST(8.800000 AS Numeric(19, 6)), N'F', N'Năm 2022, thế hệ game chạy trên NERvGear tiếp theo đã được công bố, người dùng có thể kết nối với thế giới ảo thông qua chức năng FullDive. SAO (Sword Art Online) - dòng game VRMMORPG chính thống đầu tiên trên nền NERvGear đã gây xôn xao trên toàn thế giới. Một trong số rất nhiều người chơi, Kirito, quyết tâm chinh phục trò chơi này. Thế nhưng, người sáng tạo ra SAO, Akihiko Kayaba lại thông báo rằng: Một khi đã tham gia thì không người chơi nào có thể thoát ra ngoài cho đến khi phá đảo. Game Over tương đương với cái chết thực sự ngoài đời.', N'http://photos.animetvn.com/upload/film/39717.jpg', N'https://farm8.staticflickr.com/7485/15651945679_0d8cfbf3ce_b.jpg', 1, CAST(0x0000A78100000000 AS DateTime), CAST(0x0000A78100000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (5, N'MAHOUKA KOUKOU NO RETTOUSEI', 9, 26, 26, 23, 2014, 6375, 2120871, NULL, CAST(8.800000 AS Numeric(19, 6)), N'F', N'Phép thuật, đó không còn là truyền thuyết hay một câu chuyện cổ tích nữa. Nó đã trở thành một công nghệ thực tiễn từ gần một thế kỷ nay. Pháp sư, đó là cách mà người ta gọi những con người mang trong mình một tài năng phép thuật ưu việt. Đối với các quốc gia, sự tồn tại của con người này chính là những vũ khí mạnh mẽ. Nhiều quốc gia trên thế giới đã bị cuốn vào vòng xoáy của cuộc chạy đua trên lĩnh vực đào tạo ma pháp. "Anh hai chính là người mà em yêu quý và kính trọng nhất trên đời. Đó không phải là tình cảm trai gái, càng không phải cảm xúc yêu đương. Bởi vì anh... là anh ruột của em..."', N'https://farm6.staticflickr.com/5594/14336814533_c58be3281a_o.jpg', N'https://farm3.staticflickr.com/2917/14508001780_c2994d6113_o.jpg', 1, CAST(0x0000A6EF00000000 AS DateTime), CAST(0x0000A6EF00000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (6, N'High School DxD 1', 11, 12, 12, 24, 2012, 3010, 653636, NULL, CAST(8.300000 AS Numeric(19, 6)), N'F', N'Hyoudou Issei - một thằng main dâm dê đại non nhưng vẫn chưa có bạn gái. Thật đúng như các cụ đã nói: " Bé bằng quả ớt mà đòi lớt phớt tờ rym " .Nhưng, đêm hôm đó, một bạn gái nứng hết chỗ nói xuất hiện với cái tên Amano Yuuma rủ cậu đến một nơi vắng vẻ, nhẹ nhàng quỳ xuống, tay bám lấy chân cậu và nói một điều hết sức quyến rũ: Cậu có thể "chết đi" được không?', N'https://farm9.staticflickr.com/8609/15212016713_26c038982b_o.jpg', N'https://farm9.staticflickr.com/8272/15646616100_97863038ff_b.jpg', 1, CAST(0x0000A71A00000000 AS DateTime), CAST(0x0000A71A00000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (7, N'ROKUDENASHI MAJUTSU KOUSHI TO AKASHIC RECORDS', 10, 12, 7, 24, 2017, 4245, 269971, NULL, CAST(9.000000 AS Numeric(19, 6)), N'P', N'Sisti tham gia vào học viện pháp thuật để nâng cao khả năng phép thuật của mình và phá giải bí ẩn của Sky Catsle. Sau sự việc thầy giáo yêu thích của mình về hưu và được thay bởi Glen, một người lề mề, biếng nhác và là một lão thầy giáo dê cụ thứ thiệt, cô và Glen đã gặp vô số rắc rối cùng nhau… Một bộ manga chuyển thể từ Light Novel nổi tiếng.', N'http://photos.animetvn.com/upload/film/Roku_de_Nashi_Majutsu_Koushi_to_Akashic_Records-cover.jpg', N'http://photos.animetvn.com/upload/film_big/UUgnL1e.jpg', 1, CAST(0x0000A75E00000000 AS DateTime), CAST(0x0000A75E00000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (8, N'Pokemon Season 21: Sun & Moon', 2, NULL, 26, 24, 2017, 461, 479367, NULL, CAST(8.300000 AS Numeric(19, 6)), N'P', N'Satoshi lại cùng Pikachu bước sang một vùng đất mới để xoa dịu tâm hồn sau khi thua Liên đoàn (nói chung là cũng lại y chang mấy lần trước thôi :v ). Lần này, anh sang vùng Alola vốn là mấy hòn đảo nhiệt đới, quyết chí trở thành Pokemon Master bằng mọi giá, đến độ ghi danh nhập học vào Trường Pokemon, điều mà đáng lẽ một thằng nhóc 10 tuổi như anh phải làm từ lâu rồi :v. Tại đây, anh gặp nhiều bạn bè mới, các Pokemon mới với những loài Pokemon cũ nhưng mang hình thái hoàn toàn khác biệt. Nói chung là qua Alola xong thấy ở đây sướng quá, gái nơi đây cũng xinh nên là anh quyết định ở lại để gây dựng harem... ý lộn, để phấn đấu trở thành Pokemon Master :v :v Thôi, nói chung là cứ theo dõi phim là sẽ biết anh có làm được không ấy mà :v', N'http://photos.animetvn.com/upload/film/kv4.jpg', N'http://photos.animetvn.com/upload/film_big/abpypIQ.png', 1, CAST(0x0000A77400000000 AS DateTime), CAST(0x0000A77400000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (9, N'RE:ZERO KARA HAJIMERU ISEKAI SEIKATSU', 2, 25, 25, 24, 2016, 6518, 2073641, NULL, CAST(8.400000 AS Numeric(19, 6)), N'F', N'Trong phim Subaru Natsuki là một học sinh Trung học bình thường, cậu bị triệu hồi đến một thế giới khác và được cứu bởi một cô gái xinh đẹp. Cậu quyết định ở lại trả ơn cho cô ấy, nhưng không đơn giản như vẻ ngoài của nó. Hai người bị kẻ thù tấn công và họ đã chết. Nhưng chính lúc này cậu lại phát hiện ra khả năng đặc biệt của mình là quay ngược thời gian, tạm gọi là “ Hối Sinh “ về thời điểm mà cậu bắt đầu đến thế giới này nhưng chỉ có một mình cậu nhớ những gì đã xảy ra…. Cậu sẽ làm gì? Hãy cùng đón xem.', N'http://photos.animetvn.com/upload/film/77656.jpg', N'http://photos.animetvn.com/upload/film/ggtcnkk.jpg', 1, CAST(0x0000A77F00000000 AS DateTime), CAST(0x0000A77F00000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (10, N'Fairy Tail 2', 4, 102, 102, 24, 2014, 2047, 1718734, NULL, CAST(8.600000 AS Numeric(19, 6)), N'F', N'Tiếp nối phần 1. Chuyện xảy ra trong một thế giới hư cấu, ở Earth Land, có tồn tại một Mage Guild gọi là “Fairy Tail”. Fairy Tail được đóng quân ở thị trấn Magnolia, thuộc Vương Quốc Fiore, và hiện đang được thống trị bởi Makarov, chủ nhân của Guild. Lucy Heartfilia, một thiếu nữ 17 tuổi, ước ao được trở thành một pháp sư chính thức và tham gia vào một trong những Mage Guilds danh giá nhất trên thế giới, Fairy Tail. Một ngày kia, tình cờ cô gặp Natsu Dragneel, một anh chàng nhiễm-bệnh, nhưng bản chất lại là một người rất vui vẻ. Tuy nhiên, có một điều mà cô không hề hay biết rằng Natsu chính là mối liên hệ gần gũi nhất với Fairy Tail, bởi cậu chính là một Mage trong Fairy Tail. [Soạn bởi MAL Rewrite]', N'http://photos.animetvn.com/upload/film/HBEKxze.jpg', N'http://photos.animetvn.com/upload/film_big/pLH6LA8.jpg', 1, CAST(0x0000A74100000000 AS DateTime), CAST(0x0000A74100000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (11, N'Dragon Ball Super', 9, 0, 92, 25, 2016, 2235, 1684452, 0, CAST(8.200000 AS Numeric(19, 6)), N'P', N'Phần 3 trong series phim Bảy viên Ngọc rồng', N'http://photos.animetvn.com/upload/film/fdPVK3L.jpg', N'http://photos.animetvn.com/upload/film_big/VLioF1I.jpg', 1, CAST(0x0000A76500000000 AS DateTime), CAST(0x0000A76500000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (13, N'Master of Skills', 1, 12, 10, 24, 2017, 1772, 206597, NULL, CAST(8.700000 AS Numeric(19, 6)), N'P', N'Diệp Tu – cao thủ đứng đầu được vinh danh là bách khoa toàn thư của game Vinh Quang, vì đủ loại nguyên nhân mà bị câu lạc bộ đuổi đi. Sau khi bị trục xuất, rời khỏi nghề, hắn trở thành nhân viên quản lý trong một tiệm net nho nhỏ. Thế nhưng, với kinh nghiệm về game trong 10 năm, mang theo những hồi ức năm nào, cùng món vũ khí tự chế vẫn chưa hoàn thành, hắn lại bắt đầu quay về con đường đỉnh cao ấy…', N'http://photos.animetvn.com/upload/film/344c578c2f43ebb2da9167cd26f15d8e.jpg', N'http://photos.animetvn.com/upload/film_big/9ALN6Eu.jpg', 1, CAST(0x0000A77900000000 AS DateTime), CAST(0x0000A77900000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (14, N'Re:Creators', 4, 22, 9, 24, 2017, 2452, 93329, NULL, CAST(8.900000 AS Numeric(19, 6)), N'P', N'Con người đã tạo ra nhiều câu chuyện. Niềm vui, nỗi buồn, tức giận, cảm xúc sâu sắc. Câu chuyện cảm xúc của chúng tôi, và làm chúng tôi say mê. Tuy nhiên, đây chỉ là ý nghĩ của người ngoài cuộc. Nhưng nếu những người trong câu chuyện có "ý định"? Đối với họ, chúng ta có phải là những sinh vật giống như thần để đưa câu chuyện của họ vào thế giới? Thế giới của chúng ta đã thay đổi. Hãy giải quyết hình phạt trên lãnh vực của các vị thần. Trong Re: CREATORS, mọi người trở thành Creator.', N'http://photos.animetvn.com/upload/film/UyI6gSx.png', N'http://photos.animetvn.com/upload/film_big/UwKoRh3.jpg', 1, CAST(0x0000A78200000000 AS DateTime), CAST(0x0000A78200000000 AS DateTime))
INSERT [dbo].[PHIM] ([ID], [Ten], [NhaSX], [SoTap], [SoTapHienCo], [ThoiLuong], [NamPhatHanh], [SoLuotThich], [SoLuotXem], [XepHang], [DiemDanhGia], [TinhTrangPhim], [MoTaPhim], [Hinh1], [Hinh2], [LoaiPhim], [NgayPhatHanh], [UpdateDate]) VALUES (15, N'Sousei no Onmyouji', 3, 25, 25, 25, 2017, 3125, 1732079, NULL, CAST(8.500000 AS Numeric(19, 6)), N'F', N'Rokuro chỉ có một ước mơ duy nhất là trở thành Diệt Quỷ Sư ! Rồi Benio bí ẩn xuất hiện. Họ được gán cho cái tên “Song Tinh Diệt Quỷ Sư” và được định sẵn để kết hôn với nhau… Liệu Rokuro có thể thoát khỏi hai số mệnh này? Khi Ryogo, bạn thân của Rokuro, mất tích, cậu buộc phải nhờ Benio giúp đỡ để vào Magano, lãnh địa của con quỷ Kegare, để cứu bạn mình!', N'http://photos.animetvn.com/upload/film/79556.jpg', N'http://photos.animetvn.com/upload/film_big/34SOx1B.jpg', 1, CAST(0x0000A78500000000 AS DateTime), CAST(0x0000A78500000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[PHIM] OFF
/****** Object:  Table [dbo].[NHOMDICH]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOMDICH](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenNhom] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[NHOMDICH] ON
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (1, N'Zing FS')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (2, N'Kimi')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (3, N'VNFS')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (4, N'Devil Player Team')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (5, N'Fire God Phoenix')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (6, N'WayA')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (7, N'X Team')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (8, N'Olivia Fansub')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (9, N'ATeam')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (10, N'Kokocon')
INSERT [dbo].[NHOMDICH] ([ID], [TenNhom]) VALUES (11, N'Clip-Sub')
SET IDENTITY_INSERT [dbo].[NHOMDICH] OFF
/****** Object:  Table [dbo].[NHASANXUAT]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHASANXUAT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenNSX] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[NHASANXUAT] ON
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (1, N'Viz Media')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (2, N'TV Tokyo')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (3, N'Studio Pierrot')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (4, N'A-1 Pictures')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (5, N'Wit Studio')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (6, N'Bones')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (7, N'Ufotable')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (8, N'Studio Deen')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (9, N'Mad House')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (10, N'LidenFILMS')
INSERT [dbo].[NHASANXUAT] ([ID], [TenNSX]) VALUES (11, N'TNK')
SET IDENTITY_INSERT [dbo].[NHASANXUAT] OFF
/****** Object:  Table [dbo].[LOAIPHIM]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAIPHIM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[LOAIPHIM] ON
INSERT [dbo].[LOAIPHIM] ([ID], [Ten]) VALUES (1, N'TV series')
INSERT [dbo].[LOAIPHIM] ([ID], [Ten]) VALUES (2, N'Movies')
INSERT [dbo].[LOAIPHIM] ([ID], [Ten]) VALUES (3, N'Live Action')
INSERT [dbo].[LOAIPHIM] ([ID], [Ten]) VALUES (4, N'Bluray')
SET IDENTITY_INSERT [dbo].[LOAIPHIM] OFF
/****** Object:  Table [dbo].[LichChieuPhim]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichChieuPhim](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Phim] [int] NULL,
	[NgayChieu] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhAnhPhim]    Script Date: 06/07/2017 01:02:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhAnhPhim](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaPhim] [int] NULL,
	[HinhAnh] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

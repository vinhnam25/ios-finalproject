//
//  Phim.swift
//  wf-AnimeApp
//
//  Created by Nam Tran on 6/15/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import Foundation

class Phim {
    var ID : Int
    var Ten : String
    var NhaSX : Int?
    var SoTap : Int?
    var SoTapHienCo : Int?
    var ThoiLuong : Int?
    var NamPhatHanh : Int?
    var SoLuotThich : Int?
    var SoLuotXem : Int?
    var XepHang : Int?
    var DiemDanhGia : Decimal?
    var TinhTrangPhim : String
    var MoTaPhim : String
    var Hinh1 : String
    var Hinh2 : String
    var LoaiPhim : Int?
    var NgayPhatHanh : Date?
    var UpdateDate : Date?
    
    init(id: Int, ten: String, nsx: Int, sotap: Int, sotaphienco: Int, thoiluong: Int, nam: Int, thich: Int, xem: Int, xephang: Int, diem: Decimal, tinhtrang: String, mota: String, h1: String, h2: String, loai: Int, ngay: Date, udate: Date) {
        
        self.ID = id
        self.Ten = ten
        self.NhaSX = nsx
        self.SoTap = sotap
        self.SoTapHienCo = sotaphienco
        self.ThoiLuong = thoiluong
        self.NamPhatHanh = nam
        self.SoLuotThich = thich
        self.SoLuotXem = xem
        self.XepHang = xephang
        self.DiemDanhGia = diem
        self.TinhTrangPhim = tinhtrang
        self.MoTaPhim = mota
        self.Hinh1 = h1
        self.Hinh2 = h2
        self.LoaiPhim = loai
        self.NgayPhatHanh = ngay
        self.UpdateDate = udate
        
    }
}

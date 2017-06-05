//
//  UIImageView+ShowImgFrom.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/3/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func showImgFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func showImgFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        showImgFrom(url: url, contentMode: mode)
    }
}

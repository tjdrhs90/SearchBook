//
//  Extension.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    ///킹피셔 이미지 설정
    func setKfImg(urlStr: String?) {
        self.kf.indicatorType = .activity
        
        var url: URL?
        if let urlStr {
            url = URL(string: urlStr)
        }
        self.kf.setImage(with: url, options: [.transition(.fade(0.5))])
    }
}

//
//  ListCell.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import UIKit

///목록 셀
final class ListCell: UITableViewCell {
    ///커버 이미지뷰
    @IBOutlet weak private var ivCover: UIImageView!
    ///제목
    @IBOutlet weak private var lblTitle: UILabel!
    ///저자명
    @IBOutlet weak private var lblSubTitle: UILabel!
    
    func configure(data: Docs) {
        
        lblTitle.text  = data.title
        lblSubTitle.text = data.author_name?.first
        
        if let cover_i = data.cover_i {
            ivCover.setKfImg(urlStr: ApiURL.imgURL(id: String(cover_i), size: .small))
        } else {
            ivCover.setKfImg(urlStr: nil)
        }
    }
}

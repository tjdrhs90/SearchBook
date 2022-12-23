//
//  ListCell.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import UIKit
import Kingfisher

///목록 셀
final class ListCell: UITableViewCell {
    ///커버 이미지뷰
    @IBOutlet weak var ivCover: UIImageView!
    ///제목
    @IBOutlet weak var lblTitle: UILabel!
    ///저자명
    @IBOutlet weak var lblSubTitle: UILabel!
    
    func configure(data: Docs) {
        
        lblTitle.text  = data.title
        lblSubTitle.text = data.author_name?.first
        
        ivCover.kf.indicatorType = .activity
        
        var url: URL?
        
        if let cover_i = data.cover_i {
            url = URL(string: "https://covers.openlibrary.org/b/id/\(cover_i)-S.jpg")
        }
        
        ivCover.kf.setImage(with: url, options: [.transition(.fade(0.5))])
    }
    
}

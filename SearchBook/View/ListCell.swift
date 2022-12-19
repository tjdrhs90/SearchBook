//
//  ListCell.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import UIKit

///목록 셀
class ListCell: UITableViewCell {
    ///커버 이미지뷰
    @IBOutlet weak var ivCover: UIImageView!
    ///제목
    @IBOutlet weak var lblTitle: UILabel!
    ///저자명
    @IBOutlet weak var lblSubTitle: UILabel!
}

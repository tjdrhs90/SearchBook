//
//  DetailVC.swift
//  BookSearch
//
//  Created by sgsim on 2022/12/19.
//

import UIKit
import Kingfisher

///상세 화면
final class DetailVC: UIViewController {
    
    ///커버 이미지뷰
    @IBOutlet weak var ivCover: UIImageView!
    ///제목
    @IBOutlet weak var lblTitle: UILabel!
    ///저자
    @IBOutlet weak var lblAuthorName: UILabel!
    ///최초 발행 연도
    @IBOutlet weak var lblPublishYear: UILabel!
    ///에디션 수
    @IBOutlet weak var lblEditionCount: UILabel!
    ///발행 장소
    @IBOutlet weak var lblPublishPlace: UILabel!
    ///주제
    @IBOutlet weak var lblSubject: UILabel!
    ///배우
    @IBOutlet weak var lblPerson: UILabel!
    
    var data: Docs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false

        guard let data else { return }
        
        ivCover.kf.indicatorType = .activity
        
        if let cover_i = data.cover_i {
            let url = URL(string: "https://covers.openlibrary.org/b/id/\(cover_i)-M.jpg")
            ivCover.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        } else {
            ivCover.isHidden = true
        }
        
        lblTitle.text = data.title
        lblAuthorName.text = data.author_name?.joined(separator: ", ")
        
        if let first_publish_year = data.first_publish_year {
            lblPublishYear.text = "\(first_publish_year)년"
        }
        if let edition_count = data.edition_count {
            lblEditionCount.text = "\(edition_count)"
        }
        
        lblPublishPlace.text = data.publish_place?.joined(separator: ", ")
        lblSubject.text = data.subject?.joined(separator: ", ")
        lblPerson.text = data.person?.joined(separator: ", ")
    }
}

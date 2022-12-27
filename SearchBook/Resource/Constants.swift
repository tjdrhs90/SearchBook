//
//  Constants.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/23.
//

import Foundation

enum ApiURL: String {
    ///openlibrary base URL
    case baseURL = "https://openlibrary.org"
    ///도서 검색 path
    case search = "/search.json"
    ///커버 이미지 URL
    static func imgURL(id: String, size: ImgSize) -> String {
        String(format: "https://covers.openlibrary.org/b/id/%@-%@.jpg", id, size.rawValue )
    }
}

///커버 이미지 사이즈
enum ImgSize: String {
    case small = "S"
    case medium = "M"
}

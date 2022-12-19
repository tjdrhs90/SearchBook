//
//  Entity.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import Foundation

struct Entity: Codable {
    let numFound: Int?
    let start: Int?
    let docs: [Docs]?
    let q: String?
}
struct Docs: Codable {
    ///제목
    let title: String?
    ///커버 이미지 ID
    let cover_i: Int?
    ///저자
    let author_name: [String]?
    ///최초 발행 연도
    let first_publish_year: Int?
    ///에디션 수
    let edition_count: Int?
    ///발행 장소
    var publish_place: [String]?
    ///주제
    var subject: [String]?
    ///배우
    var person: [String]?
}

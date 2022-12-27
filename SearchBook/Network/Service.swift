//
//  Service.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import Foundation

struct Service {
    func searchData(keyword: String, page: String, onCompleted: @escaping (Entity) -> Void) {
        
        guard let encodeKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let queryItems = [URLQueryItem(name: "q", value: encodeKeyword),
                          URLQueryItem(name: "page", value: page)]
        
        Repository.requestAPI(path: .search, queryItems: queryItems) { (response: Entity) in
            onCompleted(response)
        } failure: { err in
            print(err.localizedDescription)
        }
    }
}

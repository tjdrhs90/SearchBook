//
//  Service.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import Foundation

struct Service {
    func fetchData(keyword: String, page: String, onCompleted: @escaping (Entity) -> Void) {
        
        let baseURL = "https://openlibrary.org/search.json"
        
        var components = URLComponents(string: baseURL)
        
        let queryItems = [URLQueryItem(name: "q", value: keyword),
                          URLQueryItem(name: "page", value: page)]
        
        components?.percentEncodedQueryItems = queryItems
        
        guard let url = components?.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data,
                  let model = try? JSONDecoder().decode(Entity.self, from: data) else { return }
            
            onCompleted(model)
        }.resume()
    }
}

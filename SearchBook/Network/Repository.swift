//
//  Repository.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/23.
//

import Foundation

struct Repository {
    static func requestAPI<T: Codable>(path: ApiURL,
                                       queryItems: [URLQueryItem],
                                       success: @escaping (T) -> Void,
                                       failure: @escaping (Error) -> Void) {
        
        var components = URLComponents(string: ApiURL.baseURL.rawValue)
        
        components?.path = path.rawValue
        components?.percentEncodedQueryItems = queryItems
        
        guard let url = components?.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error {
                failure(error)
                return
            }
            
            do {
                guard let data else { return }
                let model = try JSONDecoder().decode(T.self, from: data)
                success(model)
            } catch {
                failure(error)
            }
            
        }.resume()
    }
}

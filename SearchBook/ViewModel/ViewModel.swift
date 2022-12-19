//
//  ViewModel.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import Foundation

class ViewModel {
    
    var entity: Entity?
    
    var bookList: [Docs] = []
    
    let service = Service()
    
    var outPutData: (() -> ())?
    
    var isLoading: ((Bool) -> ())?
    
    var isPaging = false
    
    func inputKeyword(_ keyword: String) {
        fetchData(keyword: keyword, page: "1")
    }
    
    func fetchData(keyword: String, page: String) {
        print(type(of: self),#function)
        
        let changeKeyword = keyword.replacingOccurrences(of: " ", with: "+")
        
        isPaging = true
        isLoading?(true)
        
        service.fetchData(keyword: changeKeyword, page: page) { [weak self] in
            self?.entity = $0
            
            let list = $0.docs ?? []
            
            if page == "1" {
                self?.bookList = list
            } else {
                self?.bookList += list
            }
            
            DispatchQueue.main.async {
                self?.outPutData?()
                self?.isPaging = false
                self?.isLoading?(false)
            }
        }
    }
    
    func scrollBottom() {
        let totalCnt = entity?.numFound ?? 0
        let nowCnt = bookList.count
        
        let hasNextPage = nowCnt < totalCnt
        
        if isPaging == false && hasNextPage {
            
            let keyword = entity?.q ?? ""
            
            let start = entity?.start ?? 0
            let nowPage = (start + 100) / 100
            let nextPage = String(nowPage + 1)
            
            fetchData(keyword: keyword, page: nextPage)
        }
    }
}

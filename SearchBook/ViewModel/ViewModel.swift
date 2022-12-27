//
//  ViewModel.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import Foundation

final class ViewModel {
    ///데이터 엔티티
    var entity: Entity?
    ///책 목록
    var bookList: [Docs] = []
    ///서비스
    let service = Service()
    ///책 검색 완료
    var outputData: (() -> ())?
    ///로딩 클로저
    var isLoading: ((Bool) -> ())?
    ///페이징 플래그
    var isPaging = false {
        didSet {
            isLoading?(isPaging)
        }
    }
    
    func inputKeyword(_ keyword: String) {
        fetchData(keyword: keyword, page: "1")
    }
    
    func scrollBottom() {
        let totalCount = entity?.numFound ?? 0
        let nowCount = bookList.count
        
        let hasNextPage = nowCount < totalCount
        
        if isPaging == false && hasNextPage {
            
            let keyword = entity?.q ?? ""
            
            let start = entity?.start ?? 0
            let nowPage = (start + 100) / 100
            let nextPage = String(nowPage + 1)
            
            fetchData(keyword: keyword, page: nextPage)
        }
    }
    
    private func fetchData(keyword: String, page: String) {
        
        let changeKeyword = keyword.replacingOccurrences(of: " ", with: "+")
        
        isPaging = true
        
        service.searchData(keyword: changeKeyword, page: page) { [weak self] in
            self?.entity = $0
            
            let list = $0.docs ?? []
            
            if page == "1" {
                self?.bookList = list
            } else {
                self?.bookList += list
            }
            
            DispatchQueue.main.async {
                self?.outputData?()
                self?.isPaging = false
            }
        }
    }
}

//
//  ListVC.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import UIKit

///목록 화면
class ListVC: UIViewController {
    ///목록 테이블뷰
    @IBOutlet weak var tableView: UITableView!
    ///로딩 인디케이터
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "키워드를 입력해주세요."
        searchController.searchBar.delegate = self
        searchController.searchBar.text = "The lord of the rings"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "도서 검색"
    }
}

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListCell.self), for: indexPath) as? ListCell else { return UITableViewCell() }
        
        return cell
    }
}

extension ListVC: UISearchBarDelegate {
    
    private func dissmissKeyboard() {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dissmissKeyboard()
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
    }
}

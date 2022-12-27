//
//  ListVC.swift
//  SearchBook
//
//  Created by sgsim on 2022/12/18.
//

import UIKit

///목록 화면
final class ListVC: UIViewController {
    ///목록 테이블뷰
    @IBOutlet weak private var tableView: UITableView!
    ///로딩 인디케이터
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupBind()
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "키워드를 입력해주세요."
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "도서 검색"
    }
    
    private func setupBind() {
        
        viewModel.outputData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.isLoading = { [weak self] in
            $0 ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
        }
    }
}

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListCell.self), for: indexPath) as? ListCell else { return UITableViewCell() }
        
        cell.configure(data: viewModel.bookList[indexPath.row])
        
        return cell
    }
}

extension ListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC else { return }
        
        vc.data = viewModel.bookList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) {
            
            viewModel.scrollBottom()
        }
    }
}

extension ListVC: UISearchBarDelegate {
    
    private func dissmissKeyboard() {
        navigationItem.searchController?.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dissmissKeyboard()
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
        viewModel.inputKeyword(searchTerm)
    }
}

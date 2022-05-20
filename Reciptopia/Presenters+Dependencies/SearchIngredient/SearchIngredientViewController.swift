//
//  SearchIngredientViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/12.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa

class SearchIngredientViewController: UIViewController, StoryboardInstantiable {
    
    enum Page {
        case searchHistory
        case favorite
    }
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientSearchBar: UISearchBar!
    @IBOutlet weak var pageSegment: UISegmentedControl!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    // MARK: - Properties
    private var searchHistoryViewModel: SearchHistoryViewModel!
    private var favoriteViewModel: FavoriteViewModel!
    
    let selectedPage = BehaviorRelay<Page>(value: .searchHistory)
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    static func create(
        searchHistoryViewModel: SearchHistoryViewModel,
        favoriteViewModel: FavoriteViewModel
    ) -> Self {
        let vc = self.instantiateViewController()
        vc.searchHistoryViewModel = searchHistoryViewModel
        vc.favoriteViewModel = favoriteViewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindSelectedPageToTableView()
    }
}

// MARK: - Bind Page State
extension SearchIngredientViewController {
    private func bindSelectedPageToTableView() {
        selectedPage
            .map { $0 == .searchHistory }
            .bind(
                to: searchHistoryTableView.rx.isShown,
                favoriteTableView.rx.isHidden
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind ViewModel
extension SearchIngredientViewController {
    
    // MARK: Search History
    private func bindSearchHistoryTableView() {
        searchHistoryViewModel.histories
            .bind(to: searchHistoryTableView.rx.items(
                    cellIdentifier: SearchHistoryCell.reuseIdentifier,
                    cellType: SearchHistoryCell.self
            ))(bindSearchHistoryCell)
            .disposed(by: disposeBag)
    }
    
    private func bindSearchHistoryCell(index: Int, item: SearchHistory, cell: SearchHistoryCell) {
        cell.configureCell(item)
    }
    
    // MARK: Favorite
    private func bindFavoriteTableView() {
        favoriteViewModel.favorites
            .bind(to: favoriteTableView.rx.items(
                cellIdentifier: FavoriteCell.reuseIdentifier,
                cellType: FavoriteCell.self
            ))(bindFavoriteCell)
            .disposed(by: disposeBag)
    }
    
    private func bindFavoriteCell(index: Int, item: Favorite, cell: FavoriteCell) {
        cell.configureCell(item)
    }
}

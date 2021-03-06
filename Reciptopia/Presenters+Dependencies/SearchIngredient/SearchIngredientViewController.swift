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
    
    enum Page: Int {
        case searchHistory = 0
        case favorite = 1
    }
    
    typealias PostSearchViewControllerFactory = ([Ingredient]) -> PostSearchViewController
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientSearchBar: UISearchBar!
    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    @IBOutlet weak var pageSegment: UISegmentedControl!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var searchButton: FloatingActionButton!
    
    // MARK: - Properties
    private var searchIngredientViewModel: SearchIngredientViewModel!
    private var searchHistoryViewModel: SearchHistoryViewModel!
    private var favoriteViewModel: FavoriteViewModel!
    private var makePostSearchViewController: PostSearchViewControllerFactory!
    
    let selectedPage = BehaviorRelay<Page>(value: .searchHistory)
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    static func create(
        searchIngredientViewModel: SearchIngredientViewModel,
        searchHistoryViewModel: SearchHistoryViewModel,
        favoriteViewModel: FavoriteViewModel,
        postSearchViewControllerFactory: @escaping PostSearchViewControllerFactory
    ) -> Self {
        let vc = self.instantiateViewController()
        vc.searchIngredientViewModel = searchIngredientViewModel
        vc.searchHistoryViewModel = searchHistoryViewModel
        vc.favoriteViewModel = favoriteViewModel
        vc.makePostSearchViewController = postSearchViewControllerFactory
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ingredientSearchBar.becomeFirstResponder()
    }
    
    private func registerCells() {
        ingredientCollectionView.registerNib(IngredientCell.self)
        searchHistoryTableView.registerNib(SearchHistoryCell.self)
        favoriteTableView.registerNib(FavoriteCell.self)
    }
    
    @IBAction func onCancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        let ingredients = searchIngredientViewModel.ingredients.value
        guard !ingredients.isEmpty else { return }
        
        searchIngredientViewModel.ingredients.accept([])
        searchHistoryViewModel.save(ingredients)
        
        let vc = makePostSearchViewController(ingredients)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Bind Page State
extension SearchIngredientViewController {
    private func bindSelectedPageToTableView() {
        pageSegment.rx.selectedSegmentIndex
            .map { Page(rawValue: $0) ?? .searchHistory }
            .bind(to: selectedPage)
            .disposed(by: disposeBag)
        
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
    
    private func bindViewModel() {
        bindIngredientToView()
        bindSelectedPageToTableView()
        bindSearchHistoryTableView()
        bindFavoriteTableView()
    }
    
    // MARK: Ingredient
    private func bindIngredientToView() {
        bindIngredientToSearchButton()
        bindIngredientCollectionView()
    }
    
    private func bindIngredientToSearchButton() {
        searchIngredientViewModel.ingredients
            .map { !$0.isEmpty }
            .bind(to: searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        searchIngredientViewModel.ingredients
            .map { !$0.isEmpty }
            .map { $0 ? UIColor(named: "AccentColor") : .lightGray }
            .bind(to: searchButton.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    private func bindIngredientCollectionView() {
        searchIngredientViewModel.ingredients
            .bind(to: ingredientCollectionView.rx.items(
                cellIdentifier: IngredientCell.reuseIdentifier,
                cellType: IngredientCell.self
            ))(bindIngredientCell)
            .disposed(by: disposeBag)
    }
    
    private func bindIngredientCell(index: Int, item: Ingredient, cell: IngredientCell) {
        cell.configureCell(
            ingredient: item,
            removeHandler: removeIngredient(at: index)
        )
    }
    
    private func removeIngredient(at index: Int) -> (() -> Void) {
        return { [weak self] in
            self?.searchIngredientViewModel.removeIngredient(at: index)
        }
    }
    
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

// MARK: - Delegates
extension SearchIngredientViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchHistoryTableView {
            searchHistoryViewModel.update(at: indexPath.row)
        } else if tableView == favoriteTableView {
            print("favorite")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == searchHistoryTableView {
            return searchHistoryDeleteActionConfiguration(at: indexPath.row)
        } else if tableView == favoriteTableView {
            return favoriteDeleteActionConfiguration(at: indexPath.row)
        }
        return nil
    }
    
    private func searchHistoryDeleteActionConfiguration(at index: Int) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(
            style: .destructive,
            title: "삭제"
        ) { [weak self] (_, _, completion) in
            self?.searchHistoryViewModel.delete(at: index)
            FeedbackGenerator.shared.execute()
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func favoriteDeleteActionConfiguration(at index: Int) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(
            style: .destructive,
            title: "삭제"
        ) { [weak self] (_, _, completion) in
            self?.favoriteViewModel.delete(at: index)
            FeedbackGenerator.shared.execute()
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension SearchIngredientViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              !text.isEmpty else { return }
        searchBar.text = ""
        searchIngredientViewModel.addIngredient(text)
    }
}

extension SearchIngredientViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchIngredientViewModel.toggleState(at: indexPath.item)
    }
}

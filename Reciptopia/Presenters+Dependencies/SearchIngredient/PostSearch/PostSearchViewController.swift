//
//  PostSearchViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/24.
//

import UIKit
import RxSwift
import RxCocoa

class PostSearchViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Outlets
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var ingredientSearchBar: UISearchBar!
    
    // MARK: - Properties
    private var viewModel: PostSearchViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    static func create(with viewModel: PostSearchViewModel) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configureRefreshControl()
        bindPostTableView()
        viewModel.fetch()
    }
    
    private func registerCell() {
        postTableView.registerNib(PostCell.self)
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        postTableView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(_ sender: UIRefreshControl) {
        viewModel.fetch()
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Bind ViewModel
extension PostSearchViewController {
    func bindPostTableView() {
        viewModel.posts
            .bind(to: postTableView.rx.items(
                cellIdentifier: PostCell.reuseIdentifier,
                cellType: PostCell.self
            ))(bindPostCell)
            .disposed(by: disposeBag)
    }
    
    private func bindPostCell(index: Int, item: Post, cell: PostCell) {
        cell.configureCell(
            item,
            onAccountTapped(at: index),
            onFavoriteTapped(at: index)
        )
    }
    
    private func onAccountTapped(at index: Int) -> (() -> Void) {
        return {
            print("account tapped.")
        }
    }
    
    private func onFavoriteTapped(at index: Int) -> (() -> Void) {
        return { [weak self] in
            self?.viewModel.toggleFavorite(at: index)
        }
    }
}

// MARK: - Delegates
extension PostSearchViewController: UISearchBarDelegate, UITableViewDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.popViewController(animated: true)
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
}

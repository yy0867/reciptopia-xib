//
//  SearchHistoryViewController.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/16.
//

import UIKit
import RxSwift
import RxCocoa

class SearchHistoryViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Outlets
    @IBOutlet weak var searchHistoryTableView: UITableView!
    
    // MARK: - Properties
    private var viewModel: SearchHistoryViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    static func create(viewModel: SearchHistoryViewModel) -> Self {
        let vc = self.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }
}

// MARK: - Bind ViewModel
extension SearchHistoryViewController {
    private func bindViewModel() {
        bindSearchHistoriesToTableView()
    }
    
    private func bindSearchHistoriesToTableView() {
        viewModel.histories
            .bind(
                to: searchHistoryTableView.rx.items(
                    cellIdentifier: SearchHistoryCell.reuseIdentifier,
                    cellType: SearchHistoryCell.self
                )
            )(bindSearchHistoryToTableViewCell)
            .disposed(by: disposeBag)
    }
    
    private func bindSearchHistoryToTableViewCell(
        index: Int,
        history: SearchHistory,
        cell: SearchHistoryCell
    ) {
        cell.configureCell(history)
    }
}

// MARK: - UITableView Delegate
extension SearchHistoryViewController: UITableViewDelegate {
}

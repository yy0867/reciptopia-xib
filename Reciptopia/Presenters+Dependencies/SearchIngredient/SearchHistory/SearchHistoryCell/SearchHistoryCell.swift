//
//  SearchHistoryCell.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/19.
//

import UIKit

class SearchHistoryCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var searchHistoryLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func configureCell(_ history: SearchHistory) {
        let title = makeTitleByHistory(history)
        searchHistoryLabel.text = title
    }
    
    private func makeTitleByHistory(_ history: SearchHistory) -> String {
        return history.ingredients
            .map { $0.name }
            .joined(separator: ", ")
    }
}

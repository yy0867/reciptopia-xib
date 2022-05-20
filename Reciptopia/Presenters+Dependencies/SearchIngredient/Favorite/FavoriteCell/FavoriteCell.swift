//
//  FavoriteCell.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/20.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteLabel: UILabel!
    
    // MARK: - Properties

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func configureCell(_ favorite: Favorite) {
        let title = favorite.title
        favoriteLabel.text = title
    }
}

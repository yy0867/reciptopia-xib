//
//  PostCell.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/24.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var nicknameButton: UIButton!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var picturesCollectionView: UICollectionView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var liketags: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    // MARK: - Properties
    private var pictureURLs = [URL]()
    
    private var onAccountTapped: (() -> Void)?
    private var onFavoriteTapped: (() -> Void)?

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configurePicturesCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        changeFavoriteState(to: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func configurePicturesCollectionView() {
        picturesCollectionView.registerNib(LoadableImageCell.self)
        picturesCollectionView.dataSource = self
    }
    
    func configureCell(
        _ post: Post,
        _ accountTapHandler: @escaping () -> Void,
        _ favoriteTapHandler: @escaping () -> Void
    ) {
        postTitleLabel.text = post.title
        nicknameButton.setTitle("nickname", for: .normal)
        changeFavoriteState(to: post.isFavorite)
        viewsLabel.text = "\(post.views)"
        liketags.text = "\(post.likeTags)"
        comments.text = "\(post.comments)"
        
        self.onAccountTapped = accountTapHandler
        self.onFavoriteTapped = favoriteTapHandler
        
        pictureURLs = post.pictureUrls.compactMap { URL(string: $0) }
        picturesCollectionView.reloadData()
    }
    
    func changeFavoriteState(to isFavorite: Bool) {
        favoriteButton.isSelected = isFavorite
    }
}

// MARK: - Pictures DataSource
extension PostCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LoadableImageCell.reuseIdentifier,
            for: indexPath
        ) as? LoadableImageCell else { return UICollectionViewCell() }
        
        cell.loadImage(at: pictureURLs[indexPath.item])
        
        return cell
    }
}

// MARK: - IBActions
extension PostCell {
    @IBAction func onNicknameTapped(_ sender: UIButton) {
        onAccountTapped?()
    }
    
    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        onFavoriteTapped?()
    }
}

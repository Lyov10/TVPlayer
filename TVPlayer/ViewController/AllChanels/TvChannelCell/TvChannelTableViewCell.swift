//
//  TvChannelTableViewCell.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import UIKit

protocol TvChannelTableViewCellDelegate: AnyObject {
    func favoriteButtonDidTapped(id: Int)
}

class TvChannelTableViewCell: UITableViewCell {

    static let id = "TvChannelTableViewCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var chanellImage: UIImageView!
    @IBOutlet weak var chanellNameLabel: UILabel!
    @IBOutlet weak var chanellDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: TvChannelTableViewCellDelegate?
    private var id: Int?
    private var isFavorite: Bool = false
    
    func setupCell(model: ChannelModel, isFavorite: Bool) {
        containerView.layer.cornerRadius = 10
        chanellImage.layer.cornerRadius = 4
        chanellNameLabel.text = model.name
        chanellDescriptionLabel.text = model.current.title
        guard let url = URL(string: model.image) else {return}
        chanellImage.downloaded(from: url)
        self.isFavorite = isFavorite
        favoriteButton.tintColor = self.isFavorite ? Constatns.Collor.seperatorCollor  : Constatns.Collor.basicGray
        self.id = model.id
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        guard let id = id else {return}
        self.isFavorite = !self.isFavorite
        favoriteButton.tintColor = self.isFavorite ? Constatns.Collor.seperatorCollor  : Constatns.Collor.basicGray
        delegate?.favoriteButtonDidTapped(id: id)
    }
    
}

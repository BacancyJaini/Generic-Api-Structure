//
//  UsersTableViewCell.swift
//  API Structure
//
//  Created by user on 10/11/23.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userBackgroundView: UIView!
    @IBOutlet weak var firstLastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK: - Variables
    var user: User? {
        didSet {
            userDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userBackgroundView.clipsToBounds = false
        userBackgroundView.setCornerRadius(radius: 15)
        userImageView.setCornerRadius(radius: userImageView.frame.size.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func userDetailConfiguration() {
        guard let user else { return }
        firstLastNameLabel.text = "\(user.firstName) \(user.lastName)"
        usernameLabel.text = user.username
        userImageView.setImage(with: user.image)
    }
}

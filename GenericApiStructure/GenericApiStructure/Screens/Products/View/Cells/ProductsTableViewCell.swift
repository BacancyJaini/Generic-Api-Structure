//
//  ProductsTableViewCell.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    // MARK: - Variables
    var product: Product? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productBackgroundView.clipsToBounds = false
        productBackgroundView.setCornerRadius(radius: 15)
        productImageView.setCornerRadius(radius: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let product else { return }
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = (product.price ?? Constants.kZero).priceWithCurrency
        productImageView.setImage(with: product.thumbnail ?? Constants.kEmpty)
        //productImageView.image = ImageProvider.sampleImage.image
    }
}

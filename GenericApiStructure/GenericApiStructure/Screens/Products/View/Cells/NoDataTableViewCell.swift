//
//  NoDataTableViewCell.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import UIKit

class NoDataTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var noDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

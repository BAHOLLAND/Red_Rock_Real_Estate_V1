//
//  HouseTableViewCell.swift
//  Red Rock Real Estate


import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet var bed: UILabel!
    @IBOutlet var bath: UILabel!
    @IBOutlet var sqft: UILabel!
    @IBOutlet var lotSqft: UILabel!
    @IBOutlet var stories: UILabel!
    @IBOutlet var garage: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var listPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

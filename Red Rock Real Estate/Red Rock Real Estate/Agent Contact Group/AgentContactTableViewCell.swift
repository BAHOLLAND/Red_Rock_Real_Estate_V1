//
//  AgentContactTableViewCell.swift
//  Red Rock Real Estate


import UIKit

class AgentContactTableViewCell: UITableViewCell {

    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var nameOutlet: UILabel!
    @IBOutlet var phoneOutlet: UILabel!
    @IBOutlet var officeOutlet: UILabel!
    @IBOutlet var emailOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

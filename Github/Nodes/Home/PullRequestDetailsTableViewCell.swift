//
//  PullRequestDetailsTableViewCell.swift
//  Github
//
//  Created by Rishi Indolia on 31/07/22.
//

import UIKit

class PullRequestDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var prCloseDateLabel: UILabel!
    @IBOutlet weak var prCreatedDateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var prTitleLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetUp()
        // Initialization code
    }
    
    private func uiSetUp() {
        userProfileImageView.cornerRadius(with: 8)
        userProfileImageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        userProfileImageView.layer.borderWidth = 0.75
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetails(for pr: PullRequestModel) {
        prTitleLabel.text = pr.title
        userNameLabel.text = pr.user.login
        prCreatedDateLabel.text = Date.getDate(fromString: pr.createdAt)?.toString
        prCloseDateLabel.text = pr.state
        prCloseDateLabel.textColor = .red
        if pr.state == "open" {
            prCloseDateLabel.textColor = .green
        }
        
        let defualtImage = UIImage(named: "Icon-App.png")
        userProfileImageView.setImage(for: pr.user.avatarURL, placeholder: defualtImage) {_ in }
    }
    
}

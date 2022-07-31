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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetails(for pr: PullRequestModel) {
        prTitleLabel.text = pr.title
        userNameLabel.text = pr.user.login
        prCreatedDateLabel.text = pr.createdAt
        prCloseDateLabel.text = pr.closedAt
        let defualtImage = UIImage(named: "man.png")
        userProfileImageView.setImage(for: pr.user.avatarURL, placeholder: defualtImage) {_ in }
    }
    
}

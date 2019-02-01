//
//  HomeCell.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 31/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var totalStarsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(repo: RepoViewModel) {
        
    }
}

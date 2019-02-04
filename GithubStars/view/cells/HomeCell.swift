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
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var totalStarsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(repo: RepoViewModel, index: Int) {
        self.ownerImageView.isHidden = true
        self.ownerImageView.image = nil
        self.placeholderView.isHidden = false
        self.activityIndicatorView.startAnimating()
        
        ownerNameLabel.text = repo.ownerName
        repoNameLabel.text = repo.name
        totalStarsLabel.text = "Stars: \(repo.totalStars)"
        
        if (!repo.ownerImage.isEmpty) {
            ImageService.instance.downloadImage(url: repo.ownerImage, index: index) { [weak self] (image, indexFromApi) in
                guard let `self` = self else { return }
                if index == indexFromApi {
                    `self`.ownerImageView.image = image
                    `self`.activityIndicatorView.stopAnimating()
                    `self`.ownerImageView.isHidden = false
                    `self`.placeholderView.isHidden = true
                }
            }
        }
    }
}

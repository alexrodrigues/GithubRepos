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

    private var imageLoadTask: Task<Void, Never>?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        imageLoadTask = nil
        ownerImageView.image = nil
        ownerImageView.isHidden = true
        placeholderView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    func setup(repo: RepositoryResponse, index: Int) {
        imageLoadTask?.cancel()

        ownerImageView.isHidden = true
        ownerImageView.image = nil
        placeholderView.isHidden = false
        activityIndicatorView.startAnimating()

        ownerNameLabel.text = repo.ownerName
        repoNameLabel.text = repo.name
        totalStarsLabel.text = "Stars: \(repo.totalStars)"

        guard !repo.ownerImage.isEmpty else { return }

        imageLoadTask = Task { [weak self] in
            let image = await ImageService.shared.downloadImage(from: repo.ownerImage)
            guard !Task.isCancelled, let self else { return }

            await MainActor.run {
                self.ownerImageView.image = image
                self.activityIndicatorView.stopAnimating()
                self.ownerImageView.isHidden = false
                self.placeholderView.isHidden = true
            }
        }
    }
}

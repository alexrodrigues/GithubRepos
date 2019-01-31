//
//  ViewController.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var homeTableView: UITableView!
    private var viewModels = [RepoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetch()
    }
    
    private func fetch() {
        GithubService().performFetch { [weak self] (viewModels, errorMessage) in
            guard let `self` = self else { return }
            `self`.fillDataOnTableView(models: viewModels)
        }
    }
    
    
    private func fillDataOnTableView(models: [RepoViewModel]) {
        viewModels = models
    }
}


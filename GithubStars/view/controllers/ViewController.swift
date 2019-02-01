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
    private let HOME_CELL = "HomeCell"
    private var viewModels = [RepoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetch()
    }
    
    private func fetch() {
        GithubService().performFetch { [weak self] (viewModels, errorMessage) in
            guard let `self` = self else { return }
            `self`.fillDataOnTableView(models: viewModels)
            `self`.activityIndicator.stopAnimating()
            `self`.homeTableView.isHidden = false
            `self`.homeTableView.reloadData()
        }
    }
    
    private func fillDataOnTableView(models: [RepoViewModel]) {
        viewModels = models
    }
    
    private func registerCells() {
        homeTableView.register(UINib(nibName: HOME_CELL, bundle: nil), forCellReuseIdentifier: HOME_CELL)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HOME_CELL, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        cell.setup(repo: viewModels[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123.0
    }
}


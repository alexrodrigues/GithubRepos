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
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupRefreshControl()
        setupAccessibilityLabels()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetch()
    }
    
    @objc private func fetch() {
        GithubService().performFetch { [weak self] (viewModels, errorMessage) in
            guard let `self` = self else { return }
            `self`.fillDataOnTableView(models: viewModels)
            `self`.activityIndicator.stopAnimating()
            `self`.homeTableView.isHidden = false
            `self`.homeTableView.reloadData()
            if (`self`.refreshControl.isRefreshing) { `self`.refreshControl.endRefreshing() }
        }
    }
    
    func fillDataOnTableView(models: [RepoViewModel]) {
        viewModels = models
    }
    
    private func setupAccessibilityLabels() {
        homeTableView.receiveAccessibilityIdentifier(identifier: .homeTableView)
    }
    
    private func registerCells() {
        homeTableView.register(UINib(nibName: HOME_CELL, bundle: nil), forCellReuseIdentifier: HOME_CELL)
    }
    
    private func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            homeTableView.refreshControl = refreshControl
        } else {
            homeTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(ViewController.fetch), for: .valueChanged)
    }
    
    @objc func refresh() {
        fetch()
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


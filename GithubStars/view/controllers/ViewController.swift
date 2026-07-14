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
    private lazy var refreshControl = UIRefreshControl()
    private lazy var homeViewModel = HomeViewModel()
    private var localViewModels = [RepositoryResponse]()
    private var fetchTask: Task<Void, Never>?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupRefreshControl()
        setupAccessibilityLabels()
        loadRepos()
    }

    deinit {
        fetchTask?.cancel()
    }

    private func loadRepos() {
        fetchTask?.cancel()
        fetchTask = Task { [weak self] in
            guard let self else { return }
            do {
                let repos = try await self.homeViewModel.fetch()
                guard !Task.isCancelled else { return }
                await MainActor.run {
                    self.updateUI(with: repos)
                }
            } catch {
                guard !Task.isCancelled else { return }
                await MainActor.run {
                    self.handleFetchError(error)
                }
            }
        }
    }

    private func updateUI(with repos: [RepositoryResponse]) {
        guard !repos.isEmpty else { return }
        localViewModels = repos
        homeTableView.isHidden = false
        homeTableView.reloadData()
        activityIndicator.stopAnimating()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    private func handleFetchError(_ error: Error) {
        showErrorAlert(error.localizedDescription)
        activityIndicator.stopAnimating()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    private func setupAccessibilityLabels() {
        homeTableView.receiveAccessibilityIdentifier(identifier: .homeTableView)
    }

    private func registerCells() {
        homeTableView.register(UINib(nibName: HOME_CELL, bundle: nil), forCellReuseIdentifier: HOME_CELL)
    }

    private func setupRefreshControl() {
        homeTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: .valueChanged)
    }

    @objc func refresh() {
        loadRepos()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HOME_CELL, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        cell.setup(repo: localViewModels[indexPath.row], index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123.0
    }
}

//
//  ViewController.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var homeTableView: UITableView!
    private let HOME_CELL = "HomeCell"
    private lazy var refreshControl = UIRefreshControl()
    private lazy var homeViewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var localViewModels = [RepoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        homeViewModel.fetch()
        registerCells()
        setupRefreshControl()
        setupAccessibilityLabels()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func bind() {
        homeViewModel.repoList
                        .asObservable()
                            .subscribe(onNext: { [weak self] viewModels in
                                if let self = self, !viewModels.isEmpty {
                                    self.localViewModels = viewModels
                                    self.homeTableView.isHidden = false
                                    self.homeTableView.reloadData()
                                    self.activityIndicator.stopAnimating()
                                    if (self.refreshControl.isRefreshing) {
                                        self.refreshControl.endRefreshing()
                                    }
                                }
                            }).disposed(by: disposeBag)
        homeViewModel.errorMessage
                        .asObservable()
                            .subscribe(onNext: { [weak self] errorMessage in
                                if let self = self, !errorMessage.isEmpty {
                                    self.showErrorAlert(errorMessage)
                                }
                            }).disposed(by: disposeBag)
    }
    
    func fillDataOnTableView(models: [RepoViewModel]) {
        self.localViewModels = models
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
        refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        homeViewModel.fetch()
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


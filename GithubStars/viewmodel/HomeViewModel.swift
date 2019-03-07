//
//  HomeViewModel.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 07/03/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private var service: GithubService!
    private var disposeBag: DisposeBag!
    private var activityTracker: ActivityTracker!
    
    var repoList = BehaviorRelay<[RepoViewModel]>(value: [])
    var errorMessage = BehaviorRelay<String>(value: "")
    
    
    init() {
        service = GithubService()
        disposeBag = DisposeBag()
        activityTracker = ActivityTracker()
    }
    
    func fetch() {
        service.performFetch()
                        .subscribe(onNext: { repoviewModelList in
                            self.repoList.accept(repoviewModelList)
                        }, onError: { error in
                            self.errorMessage.accept(error.localizedDescription)
                        }).disposed(by: disposeBag)
    }
}

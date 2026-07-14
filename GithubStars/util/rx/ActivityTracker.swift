//
//  ActivityTracker.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 07/03/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class ActivityTracker: SharedSequenceConvertibleType {
    
    typealias Element = Bool
    typealias SharingStrategy = DriverSharingStrategy
    
    private let _lock = NSRecursiveLock()
    private let _variable = BehaviorRelay<Bool>(value: false)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    
    init() {
        _loading = _variable.asDriver()
            .distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        _lock.lock()
        _variable.accept(true)
        _lock.unlock()
    }
    
    private func sendStopLoading() {
        _lock.lock()
        _variable.accept(false)
        _lock.unlock()
    }
    
    func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _loading
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ activityTracker: ActivityTracker) -> Observable<Element> {
        return activityTracker.trackActivityOfObservable(self)
    }
}

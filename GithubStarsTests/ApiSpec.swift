//
//  ApiSpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
@testable import GithubStars

class ApiSpec: QuickSpec {
    
    override func spec() {
        describe("Testing API") {
            let api = Api<GithubResponse>()
            it("API response is OK", closure:  {
                let disposeBag = DisposeBag()
                var resultIsOk = false
                waitUntil(timeout: 9.0, action: { (done) in
                    api.requestRx(endpoint: .home)
                            .asObservable()
                                .subscribe(onNext: { _ in
                                    resultIsOk = true
                                }, onCompleted: {
                                    expect(resultIsOk).to(equal(true))
                                    done()
                                }).disposed(by: disposeBag)
                })
            })
        }
    }
}

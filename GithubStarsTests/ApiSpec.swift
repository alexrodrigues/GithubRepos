//
//  ApiSpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
@testable import GithubStars

class ApiSpec: QuickSpec {
    
    override func spec() {
        describe("Testing API") {
            let api = Api<GithubResponse>()
            it("API response is OK", closure:  {
                waitUntil(timeout: 9.0, action: { (done) in
                    api.requestObject(endpoint: .home, completion: { (result) -> (Void) in
                        var resultIsOk = false
                        switch result {
                        case .success(_):
                            resultIsOk = true
                        case .error(_):
                            resultIsOk = false
                        }
                        expect(resultIsOk).to(equal(true))
                        done()
                    })
                })
            })
        }
    }
}

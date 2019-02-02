//
//  ServiceSpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
@testable import GithubStars

class ServiceSpec: QuickSpec {

    override func spec() {
        describe("Testing MediaService") {
            it("Media Service responding Ok", closure: {
                waitUntil(timeout: 9.0, action: { (done) in
                    GithubService().performFetch(completion: { (models, errorMessage) in
                        expect(errorMessage.count).to(equal(0))
                        expect(models.count).to(beGreaterThan(1))
                        done()
                    })
                })
            })
        }
    }
}

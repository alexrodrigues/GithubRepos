//
//  FactorySpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
@testable import GithubStars

class FactorySpec: QuickSpec {

    override func spec() {
        describe("testing factory") {
            
            var githubResponse: GithubResponse!
            
            beforeEach {
                let quickNimble = Repo(name: "Quick/Nimble", stars: 120, owner: Owner(name: "Applessed", profileImageUrl: "https://www.quickimage.com/image.png"))
                
                let alamofire = Repo(name: "Alamofire", stars: 3232, owner: Owner(name: "John Jones", profileImageUrl: "https://www.alamofire.com/image.png"))
                
                let rxswift = Repo(name: "RxSwift", stars: 9432943289423, owner: Owner(name: "Awnsome person", profileImageUrl: "https://www.rxswift.com/image.png"))
                
                githubResponse = GithubResponse(items: [quickNimble, alamofire, rxswift])
            }
            
            it("Testing if is all repos", closure: {
                let viewModels = GithubResponseFactory().factor(githubResponse: githubResponse)
                expect(viewModels.count).to(equal(3))
            })
            
            it("Testing positions", closure: {
                let viewModels = GithubResponseFactory().factor(githubResponse: githubResponse)
                expect(viewModels.first?.name).to(equal("Quick/Nimble"))
            })
            
            it("Testing positions", closure: {
                let viewModels = GithubResponseFactory().factor(githubResponse: githubResponse)
                expect(viewModels[1].name).to(equal("Alamofire"))
            })
            
            it("Testing positions", closure: {
                let viewModels = GithubResponseFactory().factor(githubResponse: githubResponse)
                expect(viewModels[2].name).to(equal("RxSwift"))
            })
        }
    }
}

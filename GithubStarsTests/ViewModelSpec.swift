//
//  ViewModelSpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
@testable import GithubStars

class ViewModelSpec: QuickSpec {

    override func spec() {
        describe("ViewModel spec") {
            var viewModels = [RepoViewModel]()
            
            beforeEach {
                let quickNimble = Repo(name: "Quick/Nimble", stars: 120, owner: Owner(name: "Applessed", profileImageUrl: "https://www.quickimage.com/image.png"))
                viewModels.append(RepoViewModel(repo: quickNimble))
                
                let alamofire = Repo(name: "Alamofire", stars: 3232, owner: Owner(name: "John Jones", profileImageUrl: "https://www.alamofire.com/image.png"))
                viewModels.append(RepoViewModel(repo: alamofire))
                
                let rxswift = Repo(name: "RxSwift", stars: 9432943289423, owner: Owner(name: "Awnsome person", profileImageUrl: "https://www.rxswift.com/image.png"))
                viewModels.append(RepoViewModel(repo: rxswift))
            }
            
            it("Testing if is all repos", closure: {
                expect(viewModels.count).to(equal(3))
            })
            
            it("Testing positions", closure: {
                expect(viewModels.first?.name).to(equal("Quick/Nimble"))
            })
            
            it("Testing positions", closure: {
                expect(viewModels[1].name).to(equal("Alamofire"))
            })
            
            it("Testing positions", closure: {
                expect(viewModels[2].name).to(equal("RxSwift"))
            })
        }
    }
}

//
//  ViewControllerSpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
@testable import GithubStars

class ViewControllerSpec: QuickSpec {

    override func spec() {
        describe("Testing view controller") {
            var repoViewModels = [RepoViewModel]()
            var viewController: ViewController!
            
            beforeEach {
                let quickNimble = Repo(name: "Quick/Nimble", stars: 120, owner: Owner(name: "Applessed", profileImageUrl: "https://www.quickimage.com/image.png"))
                repoViewModels.append(RepoViewModel(repo: quickNimble))
                
                let alamofire = Repo(name: "Alamofire", stars: 3232, owner: Owner(name: "John Jones", profileImageUrl: "https://www.alamofire.com/image.png"))
                repoViewModels.append(RepoViewModel(repo: alamofire))
                
                let rxswift = Repo(name: "RxSwift", stars: 9432943289423, owner: Owner(name: "Awnsome person", profileImageUrl: "https://www.rxswift.com/image.png"))
                repoViewModels.append(RepoViewModel(repo: rxswift))
            }
            
            it("testing view controller", closure: {
                guard let firstOfMainViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
                viewController = firstOfMainViewController
                let tableView = UITableView(frame: CGRect(x:0,y:0,width:300,height:300))
                viewController.homeTableView = tableView
                tableView.dataSource = viewController
                
                viewController.fillDataOnTableView(models: repoViewModels)
                viewController.homeTableView.reloadData()
                
                expect(viewController.homeTableView.numberOfSections).to(equal(1))
                expect(viewController.homeTableView.numberOfRows(inSection: 0)).to(equal(3))
            })
            
        }
    }
}

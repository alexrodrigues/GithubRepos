//
//  ImageServiceSpec.swift
//  GithubStarsTests
//
//  Created by Alex Rodrigues on 02/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Quick
import Nimble
@testable import GithubStars

class ImageServiceSpec: QuickSpec {
    
    override func spec() {
        describe("Testing ImageService") {
            var service: ImageService!
            let validUrl = "https://avatars3.githubusercontent.com/u/7774181?v=4"
            let invalidUrl = ""
            beforeEach {
                service = ImageService()
            }
            
            it("Valid URL & index", closure: {
                waitUntil(timeout: 9.0, action: { (done) in
                    service.downloadImage(url: validUrl, index: 1, completion: { (image, index) in
                        expect(index).to(equal(1))
                        expect(image).toNot(beNil())
                        done()
                    })
                })
            })
            
            it("Inalid URL & index", closure: {
                waitUntil(timeout: 9.0, action: { (done) in
                    service.downloadImage(url: invalidUrl, index: 2, completion: { (image, index) in
                        expect(index).to(equal(2))
                        expect(image).to(beNil())
                        done()
                    })
                })
            })
        }
    }
}

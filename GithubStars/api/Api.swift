//
//  Api.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


enum Endpoints: String {
    case home = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
}

class Api<T: Decodable>  {
    
    private let session = SessionManager.default

    func requestRx(endpoint: Endpoints) -> Observable<T> {
        return Observable<T>.create{ observer -> Disposable in
            let request = self.session.request(URL(endpoint: .home)).validate().responseData { (dataResponse) in
                let result = dataResponse.result
                switch result {
                case .success(let dataReceived):
                    do {
                        let objectResponse = try JSONDecoder().decode(T.self, from: dataReceived)
                        observer.onNext(objectResponse)
                        observer.onCompleted()
                    } catch let error {
                        observer.onError(MyError(msg: error.localizedDescription))
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(MyError(msg: error.localizedDescription))
                    observer.onCompleted()
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

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

enum Result<T> {
    case success(T)
    case error(String)
}

class Api<T: Decodable>  {
    
    private var remoteTask: URLSessionTask!

    func requestRx(endpoint: Endpoints) -> Observable<T> {
        return Observable<T>.create{ observer -> Disposable in
            request(URL(endpoint: .home)).responseJSON { (dataResponse) in
                guard let dataReceived = dataResponse.data else {
                    observer.onError(MyError(msg: "Something went wrong on fetching repos"))
                    observer.onCompleted()
                    return
                }
                do {
                    let objectResponse = try JSONDecoder().decode(T.self, from: dataReceived)
                    observer.onNext(objectResponse)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(MyError(msg: error.localizedDescription))
                    observer.onCompleted()
                }
            }
            return Disposables.create {
            }
        }
    }
}

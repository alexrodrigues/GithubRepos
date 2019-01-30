//
//  Api.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case error(String)
}

class Api  {
    
    private let ERROR_MESSAGE = "Something went wrong on fetching repos"
    
    func requestObject(endpoint: Endpoints) {
        guard let url = URL(string: endpoint.rawValue)  else {
//            completion(.error(self.ERROR_MESSAGE))
            return
        }
        request(url).responseJSON { (dataResponse) in
            guard let dataReceived = dataResponse.data else {
//                completion(.error(self.ERROR_MESSAGE))
                return
            }
            print(String(data: dataReceived, encoding: String.Encoding.utf8))
        }
    }
}

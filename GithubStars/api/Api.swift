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

class Api<T: Decodable>  {
    
    private let ERROR_MESSAGE = "Something went wrong on fetching repos"
    
    func requestObject(endpoint: Endpoints, completion: @escaping (Result<T>) -> (Void)) {
        guard let url = URL(string: endpoint.rawValue)  else {
            completion(.error(self.ERROR_MESSAGE))
            return
        }
        request(url).responseJSON { (dataResponse) in
            guard let dataReceived = dataResponse.data else {
                completion(.error(self.ERROR_MESSAGE))
                return
            }
            do {
                let objectResponse = try JSONDecoder().decode(T.self, from: dataReceived)
                completion(.success(objectResponse))
            } catch {
                completion(.error(self.ERROR_MESSAGE))
            }
        }
    }
}

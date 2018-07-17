//
//  MoyaProvider+Promise.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 16/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import Moya
import PromiseKit

extension MoyaProvider {
    
    /**
     Wraps up a common moya request into a promise.
     */
    func request(_ target: Target) -> Promise<Response> {
        return Promise { seal in
            
            self.request(target) { result in
                switch result {
                    
                case .success(let response):
                    seal.fulfill(response)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

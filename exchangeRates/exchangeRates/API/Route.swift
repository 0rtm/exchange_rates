//
//  Route.swift
//  exchangeRates
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import Alamofire

typealias RequestProperties = (method: HTTPMethod, path: String, query: [String: String])

enum Route {

    case rates(base: String)

    var requestProperties: RequestProperties {
        switch self {
        case .rates(let base):
            return (.get, "/latest", ["base": base])
        }
    }
    
}

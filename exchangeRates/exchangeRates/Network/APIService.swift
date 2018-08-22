//
//  APIService.swift
//  exchangeRates
//
//  Created by Artem Tselikov on 2018-08-22.
//  Copyright © 2018 Artem Tselikov. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case genericError(description: String)
    case parsingError(description: String)
}

struct APIService {

    fileprivate let decoder = JSONDecoder()
    fileprivate let serverURL: URL

    init(serverURL: URL) {
        self.serverURL = serverURL
    }

    func fetchRates(for currencyCode: String, completion: @escaping (Error?, ExchangeRates?)->()) {
        request(Route.rates(base: currencyCode), completion: completion)
    }

    fileprivate func request<T>(_ route: Route, completion: @escaping (Error?, T?)->()) where T: Decodable {
        let properties = route.requestProperties

        guard let url = urlFor(path: properties.path) else {
            completion(APIError.genericError(description: "Invalid url"), nil)
            return
        }

        request(url: url, params: properties.query, completion: completion)
    }

    fileprivate func urlFor(path: String) -> URL? {
        return serverURL.appendingPathComponent(path)
    }

    fileprivate func request<T>(url: URL, params: [String: Any], completion: @escaping (Error?, T?)->()) where T: Decodable {

        Alamofire.request(url, parameters: params)
            .validate()
            .responseJSON {(response) in

                switch response.result {
                case .success:

                    guard let jsonData = response.data else {
                        completion(APIError.genericError(description: "No Data recieved"), nil)
                        return
                    }

                    print(response.result)

                    do {
                        let decoded = try self.decoder.decode(T.self, from: jsonData)
                        completion(nil, decoded)

                    } catch {
                        completion(APIError.parsingError(description: error.localizedDescription), nil)
                    }

                case .failure(let error):
                    completion(error, nil)
                }
        }
    }

}

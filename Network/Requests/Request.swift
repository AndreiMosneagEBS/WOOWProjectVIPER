//
//  Request.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 28.07.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class Request {
    static let shared = Request()
    let decoder = JSONDecoder()
    
    func fetchProducts( page: Int = 1, completion: @escaping (Result<[About],Error>)-> Void) {
        
        AF.request("http://mobile-shop-api.hiring.devebs.net/products?page=\(page)&page_size=15").response { response in
            switch response.result {
            case .success(let values):
                if let values = values {
                    let products = try? self.decoder.decode(Products.self, from: values)
                    if products != nil{
                        if let products = products?.results {
                            completion(.success(products))
                            print(products)
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}

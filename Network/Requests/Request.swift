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
    var isPagination = false
    
    func fetchProducts(requestingPorcess:Bool = false, page: Int , completion: @escaping (Result<ProductsResults,Error>)-> Void) {
        
      
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            AF.request("http://mobile-shop-api.hiring.devebs.net/products?page=\(page)&page_size=20").response { response in
                switch response.result {
                case .success(let values):
                    if let values = values {
                        let products = try? self.decoder.decode(ProductsResults.self, from: values)
                        
                        if products != nil{
                            if let products = products {
                                completion(.success(products))
                            }
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
        })
    }
    
    func getDetails(id: Int, completion: @escaping (Result<ProductDetails, Error>)->  Void ) {
        AF.request("http://mobile-shop-api.hiring.devebs.net/products/\(id)").response { response in
            switch response.result {
            case .success(let value):
                guard let value = value else {return}
                do {
                    let reviews = try self.decoder.decode(ProductDetails.self, from: value)
                    completion(.success(reviews))
                    print( reviews)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
}

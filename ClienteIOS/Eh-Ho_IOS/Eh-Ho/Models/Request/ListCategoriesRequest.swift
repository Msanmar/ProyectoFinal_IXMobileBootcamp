//
//  ListCategoriesRequest.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//


import Foundation

struct ListCategoriesRequest: APIRequest {
    
    typealias Response = ListCategoriesResponse
    
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}

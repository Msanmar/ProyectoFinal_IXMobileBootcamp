//
//  ListTopicsCategoryRequest.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct ListTopicsCategoryRequest: APIRequest {
    
    typealias Response = ListTopicsCategoryResponse
    
    let catId: Int
    
    init(catId: Int) {
        self.catId = catId
    }
    
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/c/\(catId).json"
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

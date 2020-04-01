//
//  CreateTopicRequest.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct CreateTopicRequest: APIRequest {
    
    typealias Response = AddNewTopicResponse
    
    let title: String
    let raw: String
    let createdAt: String
    let category: Int
    
    init(title: String,
         raw: String,
         createdAt: String,
         category: Int) {
        self.title = title
        self.raw = raw
        self.createdAt = createdAt
        self.category = category
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["title": title,
                "raw": raw,
                "created_at": createdAt,
            "category": category]
    }
    
    var headers: [String : String] {
        return [:]
    }
}

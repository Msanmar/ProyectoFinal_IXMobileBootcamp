//
//  ListPostsTopicRequest.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct ListPostsTopicRequest: APIRequest {
    
    typealias Response = ListPostsTopicResponse
    
    let topicId: Int
    
    init(topicId: Int) {
        self.topicId = topicId
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/t/\(topicId)/posts.json"
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


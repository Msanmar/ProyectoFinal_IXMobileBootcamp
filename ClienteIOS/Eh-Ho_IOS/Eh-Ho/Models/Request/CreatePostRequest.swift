//
//  CreatePostRequest.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//


import Foundation

struct CreatePostRequest: APIRequest {
    
    typealias Response = AddNewPostResponse
    
    let topicId: Int
    let raw: String
   // let createdAt: String
  
    
    init(topicId: Int,
         raw: String) {
        self.topicId = topicId
        self.raw = raw
      //  self.createdAt = createdAt
        print("init request")
        print(topicId)
        print(raw)
      
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
        return ["topic_id": topicId,
                "raw": raw]
    }
    
    var headers: [String : String] {
        return [:]
    }
}

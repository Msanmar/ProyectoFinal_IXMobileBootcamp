//
//  EditTopicRequest.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 27/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation



struct EditTopicRequest: APIRequest {
    
    typealias Response = EditTopicResponse
    
    let title: String
    let category_id: Int
    //let slug: String
    let id: Int
    

    
    init(title: String, category_id: Int, id: Int) {
       self.title = title
        self.category_id = category_id
      self.id = id
        
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/t/-/\(id).json"
       
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["title": title,
                "category_id": category_id]
    }
    
    var headers: [String : String] {
        return [:]
    }
}

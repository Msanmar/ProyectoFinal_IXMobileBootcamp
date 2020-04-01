//
//  FilteredResponseRequest.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 01/03/2020.
//  Copyright © 2020 KeepCoding. All rights reserved.
//

//
//  LatestTopicsRequest.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct FilteredResponseRequest: APIRequest {
    
    typealias Response = FilteredResponse
    
    let text : String
    let include_blurbs: String
    
    init(text: String) {
         self.text = text
         self.include_blurbs = "true"
     }
    

    
    var method: Method {
        return .GET
    }
    
    var path: String {
        //return "/search/queryterm=\(text)&include_blurbs=true"
    
        return "/search/query.json"
    }
    
    var parameters: [String : String] {
        return [text:include_blurbs]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}


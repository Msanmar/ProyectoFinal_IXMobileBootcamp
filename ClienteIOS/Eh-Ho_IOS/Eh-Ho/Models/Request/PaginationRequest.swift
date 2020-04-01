//
//  PaginationResponse.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 27/03/2020.
//  Copyright © 2020 KeepCoding. All rights reserved.
//


import Foundation

struct PaginationRequest: APIRequest {
    
    typealias Response = LatestTopicsResponse
    
     let no_definitions: String
    let page : String
   
    
    init(page: String) {
         self.page = page
         self.no_definitions = "true"
     }
    

    
    var method: Method {
        return .GET
    }
    
    var path: String {
        //return "/search/queryterm=\(text)&include_blurbs=true"
    
        return "latest.json"
    }
    
    var parameters: [String : String] {
        return [no_definitions:page]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}

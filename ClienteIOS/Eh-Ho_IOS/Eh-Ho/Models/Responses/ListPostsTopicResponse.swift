//
//  ListPostsTopicResponse.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation


// MARK: - ListPostsTopicResponse
struct ListPostsTopicResponse: Codable {
    let postStream: PostStream
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case postStream = "post_stream"
        case id
    }
}



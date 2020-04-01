//
//  ListCategoriesResponse.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 23/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//


import Foundation

// MARK: - ListCategoriesResponse
struct ListCategoriesResponse: Codable {
    let categoryList: CategoryList
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let canCreateCategory: Bool
    let canCreateTopic: Bool
    let draft: Bool?
    let draftKey: String
    let draftSequence: Int?
    let categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case canCreateCategory = "can_create_category"
        case canCreateTopic = "can_create_topic"
        case draft
        case draftKey = "draft_key"
        case draftSequence = "draft_sequence"
        case categories
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name, color, textColor, slug: String
    let topicCount, postCount, position: Int
    let categoryDescription: String
    let topicURL: String?
    let backgroundURL: String?
    let readRestricted: Bool?
    let hasChildren: Bool
    let topicsDay, topicsWeek, topicsMonth, topicsYear: Int
    let topicsAllTime: Int
    let descriptionExcerpt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, color
        case textColor = "text_color"
        case slug
        case topicCount = "topic_count"
        case postCount = "post_count"
        case position
        case categoryDescription = "description"
        case topicURL = "topic_url"
        case backgroundURL = "background_url"
        case readRestricted = "read_restricted"
        case hasChildren = "has_children"
        case topicsDay = "topics_day"
        case topicsWeek = "topics_week"
        case topicsMonth = "topics_month"
        case topicsYear = "topics_year"
        case topicsAllTime = "topics_all_time"
        case descriptionExcerpt = "description_excerpt"
    }
}


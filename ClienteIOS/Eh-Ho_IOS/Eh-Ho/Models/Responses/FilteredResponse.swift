//
//  FilteredResponse.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 01/03/2020.
//  Copyright © 2020 KeepCoding. All rights reserved.
//

import Foundation


// MARK: - FilteredResponse
struct FilteredResponse: Codable {
    
  
    let topics: [FilteredTopic]?
    let posts: [FilteredPost]
    let users: [FilteredUser]
    let categories: [FilteredCategory]
    let groups: [FilteredGroup]
    let grouped_search_result:  GroupedSearchResult
    
}
struct GroupedSearchResult: Codable {
    //let more_posts: Bool?
    //let more_users: Bool?
    //let more_categories: Bool?
    let term: String
    let search_log_id: Int
   // let more_full_page_results: Bool?
    let can_create_topic: Bool
   // let error: String?
    let post_ids: [Int]
    let user_ids: [Int]
    let category_ids: [Int]
    let group_ids: [Int]
    
}

struct FilteredGroup: Codable {
    let id: Int
    let automatic: Bool
    let name: String
    let display_name: String
    let user_count: Int
    let mentionable_level: Int
    let messageable_level: Int
    let visibility_level: Int
    let primary_group: Bool
    //let title: String?
    //let grant_trust_level: String?
    //let flair_url: String?
    //let flair_bg_color: String?
   // let flair_color: String?
    //let bio_cooked: String?
    //let bio_excerpt: String?
    let public_admission: Bool
    let public_exit: Bool
    let allow_membership_requests: Bool
   // let full_name: String?
    let default_notification_level: Int
   // let membership_rquest_template: String?
    
}

struct FilteredCategory : Codable {
    let id: Int
    let name: String
    let color: String
    let text_color: String
    let slug: String
    let topic_count: Int
    let post_count: Int
    let position: Int
    let description: String
    let description_text: String
    let topic_url: String
    let read_restricted: Bool
    let permission: String?
    let notification_level: String?
    let topic_template: String?
    let has_children: String?
    let sort_order: String?
    let sort_ascending: String?
    let show_subcategory_list: Bool
    let num_featured_topics: Int
    let default_view: String?
    let subcategory_list_style: String
    let default_top_period: String
    let minimum_required_tags: Int
    let navigate_to_first_post_after_read: Bool
    let uploaded_logo: String?
    let uploaded_background: String?
    
}

struct FilteredUser : Codable {
    let id: Int
    let username: String
    let name: String
    let avatar_template: String
    
}

struct FilteredTopic: Codable{
    let id: Int
    let title: String
    let fancy_title: String
    let slug: String
    let posts_count: Int
    let reply_count: Int
    let highest_post_number: Int
    let image_url: String?
    let created_at: String
    let last_posted_at: String
    let bumped: Bool
    let bumped_at: String
    let unseen: Bool
    let pinned: Bool
    let unpinned: String?
    let excerpt: String?
    let visible: Bool
    let closed: Bool
    let archived: Bool
    let bookmarked: String?
    let liked: String?
    let category_id: Int
    
    
}




struct FilteredPost: Codable {
    
    let id: Int
    let name: String
    let username: String
    let avatar_template: String
    let created_at: String
    let like_count: Int
    let blurb : String
    let post_number: Int
    let topic_id : Int
    
    
}

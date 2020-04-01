//
//  UITableViewCellExten.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

protocol ReusableCell {
    
    static var identifier: String { get }
    
}


struct maxTime {
    static let maxTimePosts  = 2
    static let maxTimeTopics = 2
    static let maxTimeCategories = 2
    static let maxTimeLatestTopics = 2
    static let maxTimeSingleTopic = 2
}

extension ReusableCell {
    
    static var identifier: String {
        return "\(self)"
    }
}

extension UICollectionViewCell: ReusableCell {}

extension UITableViewCell: ReusableCell {}

extension UITableViewHeaderFooterView: ReusableCell {}

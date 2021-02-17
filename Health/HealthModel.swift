//
//  HealthModel.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 02/02/21.
//

import Foundation

class HealthModel {
    
    /// Remodel Post class, bcuz it currently doesn't have a post id property
    var id: String?
    
    var photoUrl: String?
    
    var leftTag: String?
    var heading: String?
    var readTime: String?
    var description: String?
    
}

extension HealthModel {
    
    // Photo
    static func transformPostPhoto(dict: [String: Any], key: String) -> HealthModel {
        
        let post = HealthModel()
        /// Remodel Post class, bcuz it currently doesn't have a post id property
        post.id = key
        post.photoUrl = dict["1) Photo Url"] as? String
        post.leftTag = dict["2) Left Tag"] as? String
        post.heading = dict["3) Heading"] as? String
        post.readTime = dict["4) Read Time"] as? String
        post.description = dict["5) Description"] as? String
        return post
        
    }
    
}   // #42

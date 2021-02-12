//
//  TravelModel.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 02/02/21.
//

import Foundation

class TravelModel {
    
    /// Remodel Post class, bcuz it currently doesn't have a post id property
    var id: String?
    
    var photoUrl: String?
    
    var leftTag: String?
    var heading: String?
    var readTime: String?
    
}

extension TravelModel {
    
    // Photo
    static func transformPostPhoto(dict: [String: Any], key: String) -> TravelModel {
        
        let post = TravelModel()
        /// Remodel Post class, bcuz it currently doesn't have a post id property
        post.id = key
        post.photoUrl = dict["1) Photo Url"] as? String
        post.leftTag = dict["2) Left Tag"] as? String
        post.heading = dict["3) Heading"] as? String
        post.readTime = dict["4) Read Time"] as? String
        return post
        
    }
    
}   // #40

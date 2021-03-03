//
//  JobsModel.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 07/02/21.
//

import Foundation

class JobsModel {
    
    /// Remodel Post class, bcuz it currently doesn't have a post id property
    var id: String?
    
    var photoUrl: String?
    
    var leftTag: String?
    var heading: String?
    var readTime: String?
    var description: String?
    var urlString: String?
    
}

extension JobsModel {
    
    // Photo
    static func transformPostPhoto(dict: [String: Any], key: String) -> JobsModel {
        
        let post = JobsModel()
        /// Remodel Post class, bcuz it currently doesn't have a post id property
        post.id = key
        post.photoUrl = dict["1) Photo Url"] as? String
        post.leftTag = dict["2) Left Tag"] as? String
        post.heading = dict["3) Heading"] as? String
        post.readTime = dict["4) Read Time"] as? String
        post.description = dict["5) Description"] as? String
        post.urlString = dict["6) Web Url"] as? String
        return post
        
    }
    
}   // #44

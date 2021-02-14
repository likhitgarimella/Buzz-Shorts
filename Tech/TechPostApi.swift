//
//  TechPostApi.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 02/02/21.
//

import Foundation
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class TechPostApi {
    
    var REF_POSTS = Database.database().reference().child("Tech-Posts").child("Details")
    
    func observePosts(completion: @escaping (TechModel) -> Void) {
        
        REF_POSTS.observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newPost = TechModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        })
        
    }
    
    func observePost(withId id: String, completion: @escaping (TechModel) -> Void) {
        
        REF_POSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let post = TechModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(post)
            }
            
        })
        
    }
    
}   // #45

//
//  IndiaPostApi.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 31/01/21.
//

import Foundation
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class IndiaPostApi {
    
    var REF_POSTS = Database.database().reference().child("1-2-India-Posts").child("Details")
    
    func observePosts(completion: @escaping (IndiaModel) -> Void) {
        
        REF_POSTS.observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newPost = IndiaModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        })
        
    }
    
    func observePost(withId id: String, completion: @escaping (IndiaModel) -> Void) {
        
        REF_POSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let post = IndiaModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(post)
            }
            
        })
        
    }
    
}   // #45

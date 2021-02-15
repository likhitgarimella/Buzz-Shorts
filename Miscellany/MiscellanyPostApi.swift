//
//  MiscellanyPostApi.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 07/02/21.
//

import Foundation
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class MiscellanyPostApi {
    
    var REF_POSTS = Database.database().reference().child("Miscellany-Posts").child("Details")
    
    func observePosts(completion: @escaping (MiscellanyModel) -> Void) {
        
        REF_POSTS.observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newPost = MiscellanyModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        })
        
    }
    
    func observePost(withId id: String, completion: @escaping (MiscellanyModel) -> Void) {
        
        REF_POSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let post = MiscellanyModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(post)
            }
            
        })
        
    }
    
}   // #45

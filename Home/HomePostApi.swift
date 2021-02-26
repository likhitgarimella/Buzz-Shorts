//
//  HomePostApi.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 27/01/21.
//

import Foundation
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class HomePostApi {
    
    var REF_POSTS = Database.database().reference().child("1-1-Home-Posts").child("Details")
    
    func observePosts(completion: @escaping (HomeModel) -> Void) {
        
        REF_POSTS.observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newPost = HomeModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        })
        
    }
    
    func observePost(withId id: String, completion: @escaping (HomeModel) -> Void) {
        
        REF_POSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let post = HomeModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(post)
            }
            
        })
        
    }
    
}   // #45

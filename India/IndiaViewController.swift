//
//  IndiaViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 13/01/21.
//

import UIKit
// import Firebase

class IndiaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet var indiaCollectionView: UICollectionView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // reference to store IndiaModel class info
    var indiaPosts = [IndiaModel]()
    
    // copy of reference
    var realIndiaPosts = [IndiaModel]()
    
    // load home posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView.startAnimating()
        
        Api.IndiaPost.observePosts { (post) in
            self.indiaPosts.append(post)
            print(self.indiaPosts)
            /// stop before view reloads data
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidesWhenStopped = true
            self.realIndiaPosts = self.indiaPosts
            self.indiaCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
    }
    
}   // #50

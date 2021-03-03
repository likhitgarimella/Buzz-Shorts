//
//  GamingViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class GamingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var gamingCollectionView: UICollectionView!
    
    var activityIndicatorView23 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var gamingPosts = [GamingModel]()
    
    // copy of reference
    var realGamingPosts = [GamingModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        gamingCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        gamingCollectionView.showsVerticalScrollIndicator = true
        gamingCollectionView.backgroundColor = UIColor.white
        
        gamingCollectionView.dataSource = self
        gamingCollectionView.delegate = self
        
        // Register CollectionViewCell 'GamingCell' here
        gamingCollectionView.register(UINib.init(nibName: "GamingCell", bundle: nil), forCellWithReuseIdentifier: "GamingCell")
        if let flowLayout = gamingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(gamingCollectionView)
        
    }
    
    // load gaming posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView23.startAnimating()
        
        Api.GamingPost.observePosts { (post) in
            self.gamingPosts.append(post)
            print(self.gamingPosts)
            /// stop before view reloads data
            self.activityIndicatorView23.stopAnimating()
            self.activityIndicatorView23.hidesWhenStopped = true
            self.realGamingPosts = self.gamingPosts
            self.gamingCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView23)
        activityIndicatorView23.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamingPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gamingCell = gamingCollectionView.dequeueReusableCell(withReuseIdentifier: "GamingCell", for: indexPath) as! GamingCell
        let post = gamingPosts[indexPath.row]
        gamingCell.gamingPost = post
        // linking feed VC & feed cell
        gamingCell.gamingFeedVC = self
        return gamingCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = gamingPosts[indexPath.row]
        /// storing model's strings in an arrays
        let arr1 = post.leftTag
        let arr2 = post.readTime
        let arr3 = post.heading
        let arr4 = post.photoUrl
        let arr5 = post.description
        let arr6 = post.urlString
        /// embedding those array strings in global variables
        vc.name = arr1!
        vc.time = arr2!
        vc.head = arr3!
        vc.photourl = arr4!
        vc.desc = arr5!
        vc.url = arr6!
        self.present(vc, animated: true, completion: nil)
    }
    
}   // #120

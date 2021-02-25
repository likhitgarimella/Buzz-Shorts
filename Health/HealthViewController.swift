//
//  HealthViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class HealthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var healthCollectionView: UICollectionView!
    
    var activityIndicatorView9 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var healthPosts = [HealthModel]()
    
    // copy of reference
    var realHealthPosts = [HealthModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        healthCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        healthCollectionView.showsVerticalScrollIndicator = true
        healthCollectionView.backgroundColor = UIColor.white
        
        healthCollectionView.dataSource = self
        healthCollectionView.delegate = self
        
        // Register CollectionViewCell 'HealthCell' here
        healthCollectionView.register(UINib.init(nibName: "HealthCell", bundle: nil), forCellWithReuseIdentifier: "HealthCell")
        if let flowLayout = healthCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(healthCollectionView)
        
    }
    
    // load health posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView9.startAnimating()
        
        Api.HealthPost.observePosts { (post) in
            self.healthPosts.append(post)
            print(self.healthPosts)
            /// stop before view reloads data
            self.activityIndicatorView9.stopAnimating()
            self.activityIndicatorView9.hidesWhenStopped = true
            self.realHealthPosts = self.healthPosts
            self.healthCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView9)
        activityIndicatorView9.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let healthCell = healthCollectionView.dequeueReusableCell(withReuseIdentifier: "HealthCell", for: indexPath) as! HealthCell
        let post = healthPosts[indexPath.row]
        healthCell.healthPost = post
        // linking feed VC & feed cell
        healthCell.healthFeedVC = self
        return healthCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = healthPosts[indexPath.row]
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

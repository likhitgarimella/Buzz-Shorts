//
//  LifestyleViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class LifestyleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var lifestyleCollectionView: UICollectionView!
    
    var activityIndicatorView10 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var lifestylePosts = [LifestyleModel]()
    
    // copy of reference
    var realLifestylePosts = [LifestyleModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        lifestyleCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        lifestyleCollectionView.showsVerticalScrollIndicator = true
        lifestyleCollectionView.backgroundColor = UIColor.white
        
        lifestyleCollectionView.dataSource = self
        lifestyleCollectionView.delegate = self
        
        // Register CollectionViewCell 'LifestyleCell' here
        lifestyleCollectionView.register(UINib.init(nibName: "LifestyleCell", bundle: nil), forCellWithReuseIdentifier: "LifestyleCell")
        if let flowLayout = lifestyleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(lifestyleCollectionView)
        
    }
    
    // load lifestyle posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView10.startAnimating()
        
        Api.LifestylePost.observePosts { (post) in
            self.lifestylePosts.append(post)
            print(self.lifestylePosts)
            /// stop before view reloads data
            self.activityIndicatorView10.stopAnimating()
            self.activityIndicatorView10.hidesWhenStopped = true
            self.realLifestylePosts = self.lifestylePosts
            self.lifestyleCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView10)
        activityIndicatorView10.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lifestylePosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lifestyleCell = lifestyleCollectionView.dequeueReusableCell(withReuseIdentifier: "LifestyleCell", for: indexPath) as! LifestyleCell
        let post = lifestylePosts[indexPath.row]
        lifestyleCell.lifestylePost = post
        // linking feed VC & feed cell
        lifestyleCell.lifestyleFeedVC = self
        return lifestyleCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = lifestylePosts[indexPath.row]
        /// storing model's strings in an arrays
        let arr1 = post.leftTag
        let arr2 = post.readTime
        let arr3 = post.heading
        let arr4 = post.photoUrl
        let arr5 = post.description
        /// embedding those array strings in global variables
        vc.name = arr1!
        vc.time = arr2!
        vc.head = arr3!
        vc.photourl = arr4!
        vc.desc = arr5!
        self.present(vc, animated: true, completion: nil)
    }
    
}   // #118

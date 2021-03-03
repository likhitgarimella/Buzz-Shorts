//
//  WorldViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 13/01/21.
//

import UIKit
// import Firebase

class WorldViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var worldCollectionView: UICollectionView!
    
    var activityIndicatorView3 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var worldPosts = [WorldModel]()
    
    // copy of reference
    var realWorldPosts = [WorldModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        worldCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        worldCollectionView.showsVerticalScrollIndicator = true
        worldCollectionView.backgroundColor = UIColor.white
        
        worldCollectionView.dataSource = self
        worldCollectionView.delegate = self
        
        // Register CollectionViewCell 'WorldCell' here
        worldCollectionView.register(UINib.init(nibName: "WorldCell", bundle: nil), forCellWithReuseIdentifier: "WorldCell")
        if let flowLayout = worldCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(worldCollectionView)
        
    }
    
    // load world posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView3.startAnimating()
        
        Api.WorldPost.observePosts { (post) in
            self.worldPosts.append(post)
            print(self.worldPosts)
            /// stop before view reloads data
            self.activityIndicatorView3.stopAnimating()
            self.activityIndicatorView3.hidesWhenStopped = true
            self.realWorldPosts = self.worldPosts
            self.worldCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView3)
        activityIndicatorView3.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return worldPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let worldCell = worldCollectionView.dequeueReusableCell(withReuseIdentifier: "WorldCell", for: indexPath) as! WorldCell
        let post = worldPosts[indexPath.row]
        worldCell.worldPost = post
        // linking feed VC & feed cell
        worldCell.worldFeedVC = self
        return worldCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = worldPosts[indexPath.row]
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

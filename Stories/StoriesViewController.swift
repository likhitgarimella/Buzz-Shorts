//
//  StoriesViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class StoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var storiesCollectionView: UICollectionView!
    
    var activityIndicatorView19 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var storiesPosts = [StoriesModel]()
    
    // copy of reference
    var realStoriesPosts = [StoriesModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        storiesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        storiesCollectionView.showsVerticalScrollIndicator = true
        storiesCollectionView.backgroundColor = UIColor.white
        
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        
        // Register CollectionViewCell 'StoriesCell' here
        storiesCollectionView.register(UINib.init(nibName: "StoriesCell", bundle: nil), forCellWithReuseIdentifier: "StoriesCell")
        if let flowLayout = storiesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(storiesCollectionView)
        
    }
    
    // load stories posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView19.startAnimating()
        
        Api.StoriesPost.observePosts { (post) in
            self.storiesPosts.append(post)
            print(self.storiesPosts)
            /// stop before view reloads data
            self.activityIndicatorView19.stopAnimating()
            self.activityIndicatorView19.hidesWhenStopped = true
            self.realStoriesPosts = self.storiesPosts
            self.storiesCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView19)
        activityIndicatorView19.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let storiesCell = storiesCollectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCell", for: indexPath) as! StoriesCell
        let post = storiesPosts[indexPath.row]
        storiesCell.storiesPost = post
        // linking feed VC & feed cell
        storiesCell.storiesFeedVC = self
        return storiesCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = storiesPosts[indexPath.row]
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

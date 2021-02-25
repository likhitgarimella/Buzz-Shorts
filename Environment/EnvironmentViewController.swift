//
//  EnvironmentViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class EnvironmentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var environmentCollectionView: UICollectionView!
    
    var activityIndicatorView16 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var environmentPosts = [EnvironmentModel]()
    
    // copy of reference
    var realEnvironmentPosts = [EnvironmentModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        environmentCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        environmentCollectionView.showsVerticalScrollIndicator = true
        environmentCollectionView.backgroundColor = UIColor.white
        
        environmentCollectionView.dataSource = self
        environmentCollectionView.delegate = self
        
        // Register CollectionViewCell 'EnvironmentCell' here
        environmentCollectionView.register(UINib.init(nibName: "EnvironmentCell", bundle: nil), forCellWithReuseIdentifier: "EnvironmentCell")
        if let flowLayout = environmentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(environmentCollectionView)
        
    }
    
    // load environment posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView16.startAnimating()
        
        Api.EnvironmentPost.observePosts { (post) in
            self.environmentPosts.append(post)
            print(self.environmentPosts)
            /// stop before view reloads data
            self.activityIndicatorView16.stopAnimating()
            self.activityIndicatorView16.hidesWhenStopped = true
            self.realEnvironmentPosts = self.environmentPosts
            self.environmentCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView16)
        activityIndicatorView16.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return environmentPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let environmentCell = environmentCollectionView.dequeueReusableCell(withReuseIdentifier: "EnvironmentCell", for: indexPath) as! EnvironmentCell
        let post = environmentPosts[indexPath.row]
        environmentCell.environmentPost = post
        // linking feed VC & feed cell
        environmentCell.environmentFeedVC = self
        return environmentCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = environmentPosts[indexPath.row]
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

//
//  HotOvenViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class HotOvenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var hotovenCollectionView: UICollectionView!
    
    var activityIndicatorView22 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var hotovenPosts = [HotOvenModel]()
    
    // copy of reference
    var realHotovenPosts = [HotOvenModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        hotovenCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        hotovenCollectionView.showsVerticalScrollIndicator = true
        hotovenCollectionView.backgroundColor = UIColor.white
        
        hotovenCollectionView.dataSource = self
        hotovenCollectionView.delegate = self
        
        // Register CollectionViewCell 'HotOvenCell' here
        hotovenCollectionView.register(UINib.init(nibName: "HotOvenCell", bundle: nil), forCellWithReuseIdentifier: "HotOvenCell")
        if let flowLayout = hotovenCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(hotovenCollectionView)
        
    }
    
    // load hotoven posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView22.startAnimating()
        
        Api.HotovenPost.observePosts { (post) in
            self.hotovenPosts.append(post)
            print(self.hotovenPosts)
            /// stop before view reloads data
            self.activityIndicatorView22.stopAnimating()
            self.activityIndicatorView22.hidesWhenStopped = true
            self.realHotovenPosts = self.hotovenPosts
            self.hotovenCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView22)
        activityIndicatorView22.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotovenPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hotovenCell = hotovenCollectionView.dequeueReusableCell(withReuseIdentifier: "HotOvenCell", for: indexPath) as! HotOvenCell
        let post = hotovenPosts[indexPath.row]
        hotovenCell.hotovenPost = post
        // linking feed VC & feed cell
        hotovenCell.hotovenFeedVC = self
        return hotovenCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = hotovenPosts[indexPath.row]
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

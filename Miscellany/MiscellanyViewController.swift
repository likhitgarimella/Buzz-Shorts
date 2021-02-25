//
//  MiscellanyViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class MiscellanyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var miscellanyCollectionView: UICollectionView!
    
    var activityIndicatorView26 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var miscellanyPosts = [MiscellanyModel]()
    
    // copy of reference
    var realMiscellanyPosts = [MiscellanyModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        miscellanyCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        miscellanyCollectionView.showsVerticalScrollIndicator = true
        miscellanyCollectionView.backgroundColor = UIColor.white
        
        miscellanyCollectionView.dataSource = self
        miscellanyCollectionView.delegate = self
        
        // Register CollectionViewCell 'MiscellanyCell' here
        miscellanyCollectionView.register(UINib.init(nibName: "MiscellanyCell", bundle: nil), forCellWithReuseIdentifier: "MiscellanyCell")
        if let flowLayout = miscellanyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(miscellanyCollectionView)
        
    }
    
    // load miscellany posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView26.startAnimating()
        
        Api.MiscellanyPost.observePosts { (post) in
            self.miscellanyPosts.append(post)
            print(self.miscellanyPosts)
            /// stop before view reloads data
            self.activityIndicatorView26.stopAnimating()
            self.activityIndicatorView26.hidesWhenStopped = true
            self.realMiscellanyPosts = self.miscellanyPosts
            self.miscellanyCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView26)
        activityIndicatorView26.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miscellanyPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let miscellanyCell = miscellanyCollectionView.dequeueReusableCell(withReuseIdentifier: "MiscellanyCell", for: indexPath) as! MiscellanyCell
        let post = miscellanyPosts[indexPath.row]
        miscellanyCell.miscellanyPost = post
        // linking feed VC & feed cell
        miscellanyCell.miscellanyFeedVC = self
        return miscellanyCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = miscellanyPosts[indexPath.row]
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

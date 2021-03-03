//
//  MoodfreshViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class MoodfreshViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var moodfreshCollectionView: UICollectionView!
    
    var activityIndicatorView21 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var moodfreshPosts = [MoodfreshModel]()
    
    // copy of reference
    var realMoodfreshPosts = [MoodfreshModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        moodfreshCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        moodfreshCollectionView.showsVerticalScrollIndicator = true
        moodfreshCollectionView.backgroundColor = UIColor.white
        
        moodfreshCollectionView.dataSource = self
        moodfreshCollectionView.delegate = self
        
        // Register CollectionViewCell 'MoodfreshCell' here
        moodfreshCollectionView.register(UINib.init(nibName: "MoodfreshCell", bundle: nil), forCellWithReuseIdentifier: "MoodfreshCell")
        if let flowLayout = moodfreshCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(moodfreshCollectionView)
        
    }
    
    // load moodfresh posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView21.startAnimating()
        
        Api.MoodfreshPost.observePosts { (post) in
            self.moodfreshPosts.append(post)
            print(self.moodfreshPosts)
            /// stop before view reloads data
            self.activityIndicatorView21.stopAnimating()
            self.activityIndicatorView21.hidesWhenStopped = true
            self.realMoodfreshPosts = self.moodfreshPosts
            self.moodfreshCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView21)
        activityIndicatorView21.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moodfreshPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moodfreshCell = moodfreshCollectionView.dequeueReusableCell(withReuseIdentifier: "MoodfreshCell", for: indexPath) as! MoodfreshCell
        let post = moodfreshPosts[indexPath.row]
        moodfreshCell.moodfreshPost = post
        // linking feed VC & feed cell
        moodfreshCell.moodfreshFeedVC = self
        return moodfreshCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = moodfreshPosts[indexPath.row]
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

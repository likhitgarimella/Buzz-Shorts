//
//  AutoViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class AutoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var autoCollectionView: UICollectionView!
    
    var activityIndicatorView6 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var autoPosts = [AutoModel]()
    
    // copy of reference
    var realAutoPosts = [AutoModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        autoCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        autoCollectionView.showsVerticalScrollIndicator = true
        autoCollectionView.backgroundColor = UIColor.white
        
        autoCollectionView.dataSource = self
        autoCollectionView.delegate = self
        
        // Register CollectionViewCell 'AutoCell' here
        autoCollectionView.register(UINib.init(nibName: "AutoCell", bundle: nil), forCellWithReuseIdentifier: "AutoCell")
        if let flowLayout = autoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(autoCollectionView)
        
    }
    
    // load auto posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView6.startAnimating()
        
        Api.AutoPost.observePosts { (post) in
            self.autoPosts.append(post)
            print(self.autoPosts)
            /// stop before view reloads data
            self.activityIndicatorView6.stopAnimating()
            self.activityIndicatorView6.hidesWhenStopped = true
            self.realAutoPosts = self.autoPosts
            self.autoCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView6)
        activityIndicatorView6.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return autoPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let autoCell = autoCollectionView.dequeueReusableCell(withReuseIdentifier: "AutoCell", for: indexPath) as! AutoCell
        let post = autoPosts[indexPath.row]
        autoCell.autoPost = post
        // linking feed VC & feed cell
        autoCell.autoFeedVC = self
        return autoCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = autoPosts[indexPath.row]
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

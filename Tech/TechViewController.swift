//
//  TechViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class TechViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var techCollectionView: UICollectionView!
    
    var activityIndicatorView5 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var techPosts = [TechModel]()
    
    // copy of reference
    var realTechPosts = [TechModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        techCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        techCollectionView.showsVerticalScrollIndicator = true
        techCollectionView.backgroundColor = UIColor.white
        
        techCollectionView.dataSource = self
        techCollectionView.delegate = self
        
        // Register CollectionViewCell 'TechCell' here
        techCollectionView.register(UINib.init(nibName: "TechCell", bundle: nil), forCellWithReuseIdentifier: "TechCell")
        if let flowLayout = techCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(techCollectionView)
        
    }
    
    // load tech posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView5.startAnimating()
        
        Api.TechPost.observePosts { (post) in
            self.techPosts.append(post)
            print(self.techPosts)
            /// stop before view reloads data
            self.activityIndicatorView5.stopAnimating()
            self.activityIndicatorView5.hidesWhenStopped = true
            self.realTechPosts = self.techPosts
            self.techCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView5)
        activityIndicatorView5.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return techPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let techCell = techCollectionView.dequeueReusableCell(withReuseIdentifier: "TechCell", for: indexPath) as! TechCell
        let post = techPosts[indexPath.row]
        techCell.techPost = post
        // linking feed VC & feed cell
        techCell.techFeedVC = self
        return techCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = techPosts[indexPath.row]
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

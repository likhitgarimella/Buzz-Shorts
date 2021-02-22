//
//  PropertyViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class PropertyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var propertyCollectionView: UICollectionView!
    
    var activityIndicatorView13 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var propertyPosts = [PropertyModel]()
    
    // copy of reference
    var realPropertyPosts = [PropertyModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        propertyCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        propertyCollectionView.showsVerticalScrollIndicator = true
        propertyCollectionView.backgroundColor = UIColor.white
        
        propertyCollectionView.dataSource = self
        propertyCollectionView.delegate = self
        
        // Register CollectionViewCell 'PropertyCell' here
        propertyCollectionView.register(UINib.init(nibName: "PropertyCell", bundle: nil), forCellWithReuseIdentifier: "PropertyCell")
        if let flowLayout = propertyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(propertyCollectionView)
        
    }
    
    // load property posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView13.startAnimating()
        
        Api.PropertyPost.observePosts { (post) in
            self.propertyPosts.append(post)
            print(self.propertyPosts)
            /// stop before view reloads data
            self.activityIndicatorView13.stopAnimating()
            self.activityIndicatorView13.hidesWhenStopped = true
            self.realPropertyPosts = self.propertyPosts
            self.propertyCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView13)
        activityIndicatorView13.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propertyPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let propertyCell = propertyCollectionView.dequeueReusableCell(withReuseIdentifier: "PropertyCell", for: indexPath) as! PropertyCell
        let post = propertyPosts[indexPath.row]
        propertyCell.propertyPost = post
        // linking feed VC & feed cell
        propertyCell.propertyFeedVC = self
        return propertyCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = propertyPosts[indexPath.row]
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

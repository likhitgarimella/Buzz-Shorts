//
//  TravelViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class TravelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var travelCollectionView: UICollectionView!
    
    var activityIndicatorView11 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var travelPosts = [TravelModel]()
    
    // copy of reference
    var realTravelPosts = [TravelModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        travelCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        travelCollectionView.showsVerticalScrollIndicator = true
        travelCollectionView.backgroundColor = UIColor.white
        
        travelCollectionView.dataSource = self
        travelCollectionView.delegate = self
        
        // Register CollectionViewCell 'TravelCell' here
        travelCollectionView.register(UINib.init(nibName: "TravelCell", bundle: nil), forCellWithReuseIdentifier: "TravelCell")
        if let flowLayout = travelCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(travelCollectionView)
        
    }
    
    // load travel posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView11.startAnimating()
        
        Api.TravelPost.observePosts { (post) in
            self.travelPosts.append(post)
            print(self.travelPosts)
            /// stop before view reloads data
            self.activityIndicatorView11.stopAnimating()
            self.activityIndicatorView11.hidesWhenStopped = true
            self.realTravelPosts = self.travelPosts
            self.travelCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView11)
        activityIndicatorView11.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return travelPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let travelCell = travelCollectionView.dequeueReusableCell(withReuseIdentifier: "TravelCell", for: indexPath) as! TravelCell
        let post = travelPosts[indexPath.row]
        travelCell.travelPost = post
        // linking feed VC & feed cell
        travelCell.travelFeedVC = self
        return travelCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = travelPosts[indexPath.row]
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

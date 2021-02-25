//
//  SportsViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var sportsCollectionView: UICollectionView!
    
    var activityIndicatorView7 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var sportsPosts = [SportsModel]()
    
    // copy of reference
    var realSportsPosts = [SportsModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        sportsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        sportsCollectionView.showsVerticalScrollIndicator = true
        sportsCollectionView.backgroundColor = UIColor.white
        
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        
        // Register CollectionViewCell 'SportsCell' here
        sportsCollectionView.register(UINib.init(nibName: "SportsCell", bundle: nil), forCellWithReuseIdentifier: "SportsCell")
        if let flowLayout = sportsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(sportsCollectionView)
        
    }
    
    // load sports posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView7.startAnimating()
        
        Api.SportsPost.observePosts { (post) in
            self.sportsPosts.append(post)
            print(self.sportsPosts)
            /// stop before view reloads data
            self.activityIndicatorView7.stopAnimating()
            self.activityIndicatorView7.hidesWhenStopped = true
            self.realSportsPosts = self.sportsPosts
            self.sportsCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView7)
        activityIndicatorView7.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sportsCell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCell
        let post = sportsPosts[indexPath.row]
        sportsCell.sportsPost = post
        // linking feed VC & feed cell
        sportsCell.sportsFeedVC = self
        return sportsCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = sportsPosts[indexPath.row]
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

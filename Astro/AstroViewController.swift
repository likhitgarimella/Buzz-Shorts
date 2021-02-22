//
//  AstroViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class AstroViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var astroCollectionView: UICollectionView!
    
    var activityIndicatorView12 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var astroPosts = [AstroModel]()
    
    // copy of reference
    var realAstroPosts = [AstroModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        astroCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        astroCollectionView.showsVerticalScrollIndicator = true
        astroCollectionView.backgroundColor = UIColor.white
        
        astroCollectionView.dataSource = self
        astroCollectionView.delegate = self
        
        // Register CollectionViewCell 'AstroCell' here
        astroCollectionView.register(UINib.init(nibName: "AstroCell", bundle: nil), forCellWithReuseIdentifier: "AstroCell")
        if let flowLayout = astroCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(astroCollectionView)
        
    }
    
    // load astro posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView12.startAnimating()
        
        Api.AstroPost.observePosts { (post) in
            self.astroPosts.append(post)
            print(self.astroPosts)
            /// stop before view reloads data
            self.activityIndicatorView12.stopAnimating()
            self.activityIndicatorView12.hidesWhenStopped = true
            self.realAstroPosts = self.astroPosts
            self.astroCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView12)
        activityIndicatorView12.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return astroPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let astroCell = astroCollectionView.dequeueReusableCell(withReuseIdentifier: "AstroCell", for: indexPath) as! AstroCell
        let post = astroPosts[indexPath.row]
        astroCell.astroPost = post
        // linking feed VC & feed cell
        astroCell.astroFeedVC = self
        return astroCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = astroPosts[indexPath.row]
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

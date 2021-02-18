//
//  EntertainmentViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class EntertainmentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var entertainmentCollectionView: UICollectionView!
    
    var activityIndicatorView8 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var entertainmentPosts = [EntertainmentModel]()
    
    // copy of reference
    var realEntertainmentPosts = [EntertainmentModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        entertainmentCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        entertainmentCollectionView.showsVerticalScrollIndicator = true
        entertainmentCollectionView.backgroundColor = UIColor.white
        
        entertainmentCollectionView.dataSource = self
        entertainmentCollectionView.delegate = self
        
        // Register CollectionViewCell 'EntertainmentCell' here
        entertainmentCollectionView.register(UINib.init(nibName: "EntertainmentCell", bundle: nil), forCellWithReuseIdentifier: "EntertainmentCell")
        if let flowLayout = entertainmentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(entertainmentCollectionView)
        
    }
    
    // load entertainment posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView8.startAnimating()
        
        Api.EntertainmentPost.observePosts { (post) in
            self.entertainmentPosts.append(post)
            print(self.entertainmentPosts)
            /// stop before view reloads data
            self.activityIndicatorView8.stopAnimating()
            self.activityIndicatorView8.hidesWhenStopped = true
            self.realEntertainmentPosts = self.entertainmentPosts
            self.entertainmentCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView8)
        activityIndicatorView8.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entertainmentPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let entertainmentCell = entertainmentCollectionView.dequeueReusableCell(withReuseIdentifier: "EntertainmentCell", for: indexPath) as! EntertainmentCell
        let post = entertainmentPosts[indexPath.row]
        entertainmentCell.entertainmentPost = post
        // linking feed VC & feed cell
        entertainmentCell.entertainmentFeedVC = self
        return entertainmentCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = entertainmentPosts[indexPath.row]
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

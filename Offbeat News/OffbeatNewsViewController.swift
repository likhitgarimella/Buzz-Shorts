//
//  OffbeatNewsViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class OffbeatNewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var offbeatCollectionView: UICollectionView!
    
    var activityIndicatorView17 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var offbeatPosts = [OffbeatModel]()
    
    // copy of reference
    var realOffbeatPosts = [OffbeatModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        offbeatCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        offbeatCollectionView.showsVerticalScrollIndicator = true
        offbeatCollectionView.backgroundColor = UIColor.white
        
        offbeatCollectionView.dataSource = self
        offbeatCollectionView.delegate = self
        
        // Register CollectionViewCell 'OffbeatNewsCell' here
        offbeatCollectionView.register(UINib.init(nibName: "OffbeatNewsCell", bundle: nil), forCellWithReuseIdentifier: "OffbeatNewsCell")
        if let flowLayout = offbeatCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(offbeatCollectionView)
        
    }
    
    // load offbeat posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView17.startAnimating()
        
        Api.OffbeatPost.observePosts { (post) in
            self.offbeatPosts.append(post)
            print(self.offbeatPosts)
            /// stop before view reloads data
            self.activityIndicatorView17.stopAnimating()
            self.activityIndicatorView17.hidesWhenStopped = true
            self.realOffbeatPosts = self.offbeatPosts
            self.offbeatCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView17)
        activityIndicatorView17.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offbeatPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let offbeatCell = offbeatCollectionView.dequeueReusableCell(withReuseIdentifier: "OffbeatNewsCell", for: indexPath) as! OffbeatNewsCell
        let post = offbeatPosts[indexPath.row]
        offbeatCell.offbeatPost = post
        // linking feed VC & feed cell
        offbeatCell.offbeatFeedVC = self
        return offbeatCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = offbeatPosts[indexPath.row]
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

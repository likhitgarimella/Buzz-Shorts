//
//  TopTenViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class TopTenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var toptenCollectionView: UICollectionView!
    
    var activityIndicatorView18 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var toptenPosts = [TopTenModel]()
    
    // copy of reference
    var realToptenPosts = [TopTenModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        toptenCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        toptenCollectionView.showsVerticalScrollIndicator = true
        toptenCollectionView.backgroundColor = UIColor.white
        
        toptenCollectionView.dataSource = self
        toptenCollectionView.delegate = self
        
        // Register CollectionViewCell 'TopTenCell' here
        toptenCollectionView.register(UINib.init(nibName: "TopTenCell", bundle: nil), forCellWithReuseIdentifier: "TopTenCell")
        if let flowLayout = toptenCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(toptenCollectionView)
        
    }
    
    // load topten posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView18.startAnimating()
        
        Api.ToptenPost.observePosts { (post) in
            self.toptenPosts.append(post)
            print(self.toptenPosts)
            /// stop before view reloads data
            self.activityIndicatorView18.stopAnimating()
            self.activityIndicatorView18.hidesWhenStopped = true
            self.realToptenPosts = self.toptenPosts
            self.toptenCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView18)
        activityIndicatorView18.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toptenPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let toptenCell = toptenCollectionView.dequeueReusableCell(withReuseIdentifier: "TopTenCell", for: indexPath) as! TopTenCell
        let post = toptenPosts[indexPath.row]
        toptenCell.toptenPost = post
        // linking feed VC & feed cell
        toptenCell.toptenFeedVC = self
        return toptenCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = toptenPosts[indexPath.row]
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

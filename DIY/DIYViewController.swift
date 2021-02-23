//
//  DIYViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class DIYViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var diyCollectionView: UICollectionView!
    
    var activityIndicatorView20 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var diyPosts = [DIYModel]()
    
    // copy of reference
    var realDiyPosts = [DIYModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        diyCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        diyCollectionView.showsVerticalScrollIndicator = true
        diyCollectionView.backgroundColor = UIColor.white
        
        diyCollectionView.dataSource = self
        diyCollectionView.delegate = self
        
        // Register CollectionViewCell 'DIYCell' here
        diyCollectionView.register(UINib.init(nibName: "DIYCell", bundle: nil), forCellWithReuseIdentifier: "DIYCell")
        if let flowLayout = diyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(diyCollectionView)
        
    }
    
    // load diy posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView20.startAnimating()
        
        Api.DIYPost.observePosts { (post) in
            self.diyPosts.append(post)
            print(self.diyPosts)
            /// stop before view reloads data
            self.activityIndicatorView20.stopAnimating()
            self.activityIndicatorView20.hidesWhenStopped = true
            self.realDiyPosts = self.diyPosts
            self.diyCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView20)
        activityIndicatorView20.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diyPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let diyCell = diyCollectionView.dequeueReusableCell(withReuseIdentifier: "DIYCell", for: indexPath) as! DIYCell
        let post = diyPosts[indexPath.row]
        diyCell.diyPost = post
        // linking feed VC & feed cell
        diyCell.diyFeedVC = self
        return diyCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = diyPosts[indexPath.row]
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

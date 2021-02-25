//
//  PhotoGalleryViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class PhotoGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var photogalCollectionView: UICollectionView!
    
    var activityIndicatorView25 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var photogalPosts = [PhotoModel]()
    
    // copy of reference
    var realPhotogalPosts = [PhotoModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        photogalCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        photogalCollectionView.showsVerticalScrollIndicator = true
        photogalCollectionView.backgroundColor = UIColor.white
        
        photogalCollectionView.dataSource = self
        photogalCollectionView.delegate = self
        
        // Register CollectionViewCell 'PhotoGalleryCell' here
        photogalCollectionView.register(UINib.init(nibName: "PhotoGalleryCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCell")
        if let flowLayout = photogalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(photogalCollectionView)
        
    }
    
    // load photogal posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView25.startAnimating()
        
        Api.PhotoPost.observePosts { (post) in
            self.photogalPosts.append(post)
            print(self.photogalPosts)
            /// stop before view reloads data
            self.activityIndicatorView25.stopAnimating()
            self.activityIndicatorView25.hidesWhenStopped = true
            self.realPhotogalPosts = self.photogalPosts
            self.photogalCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView25)
        activityIndicatorView25.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photogalPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photogalCell = photogalCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCell", for: indexPath) as! PhotoGalleryCell
        let post = photogalPosts[indexPath.row]
        photogalCell.photoPost = post
        // linking feed VC & feed cell
        photogalCell.photoFeedVC = self
        return photogalCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = photogalPosts[indexPath.row]
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

//
//  EducationViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class EducationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var educationCollectionView: UICollectionView!
    
    var activityIndicatorView14 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var educationPosts = [EducationModel]()
    
    // copy of reference
    var realEducationPosts = [EducationModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        educationCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        educationCollectionView.showsVerticalScrollIndicator = true
        educationCollectionView.backgroundColor = UIColor.white
        
        educationCollectionView.dataSource = self
        educationCollectionView.delegate = self
        
        // Register CollectionViewCell 'EducationCell' here
        educationCollectionView.register(UINib.init(nibName: "EducationCell", bundle: nil), forCellWithReuseIdentifier: "EducationCell")
        if let flowLayout = educationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(educationCollectionView)
        
    }
    
    // load education posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView14.startAnimating()
        
        Api.EducationPost.observePosts { (post) in
            self.educationPosts.append(post)
            print(self.educationPosts)
            /// stop before view reloads data
            self.activityIndicatorView14.stopAnimating()
            self.activityIndicatorView14.hidesWhenStopped = true
            self.realEducationPosts = self.educationPosts
            self.educationCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView14)
        activityIndicatorView14.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return educationPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let educationCell = educationCollectionView.dequeueReusableCell(withReuseIdentifier: "EducationCell", for: indexPath) as! EducationCell
        let post = educationPosts[indexPath.row]
        educationCell.educationPost = post
        // linking feed VC & feed cell
        educationCell.educationFeedVC = self
        return educationCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = educationPosts[indexPath.row]
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

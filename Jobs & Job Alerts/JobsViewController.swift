//
//  JobsViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class JobsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var jobsCollectionView: UICollectionView!
    
    var activityIndicatorView24 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var jobsPosts = [JobsModel]()
    
    // copy of reference
    var realJobsPosts = [JobsModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        jobsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        jobsCollectionView.showsVerticalScrollIndicator = true
        jobsCollectionView.backgroundColor = UIColor.white
        
        jobsCollectionView.dataSource = self
        jobsCollectionView.delegate = self
        
        // Register CollectionViewCell 'JobsCell' here
        jobsCollectionView.register(UINib.init(nibName: "JobsCell", bundle: nil), forCellWithReuseIdentifier: "JobsCell")
        if let flowLayout = jobsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(jobsCollectionView)
        
    }
    
    // load jobs posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView24.startAnimating()
        
        Api.JobsPost.observePosts { (post) in
            self.jobsPosts.append(post)
            print(self.jobsPosts)
            /// stop before view reloads data
            self.activityIndicatorView24.stopAnimating()
            self.activityIndicatorView24.hidesWhenStopped = true
            self.realJobsPosts = self.jobsPosts
            self.jobsCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView24)
        activityIndicatorView24.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobsPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let jobsCell = jobsCollectionView.dequeueReusableCell(withReuseIdentifier: "JobsCell", for: indexPath) as! JobsCell
        let post = jobsPosts[indexPath.row]
        jobsCell.jobsPost = post
        // linking feed VC & feed cell
        jobsCell.jobsFeedVC = self
        return jobsCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = jobsPosts[indexPath.row]
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

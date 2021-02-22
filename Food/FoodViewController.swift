//
//  FoodViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 06/02/21.
//

import UIKit
// import Firebase

class FoodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var foodCollectionView: UICollectionView!
    
    var activityIndicatorView15 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var foodPosts = [FoodModel]()
    
    // copy of reference
    var realFoodPosts = [FoodModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        foodCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        foodCollectionView.showsVerticalScrollIndicator = true
        foodCollectionView.backgroundColor = UIColor.white
        
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        
        // Register CollectionViewCell 'FoodCell' here
        foodCollectionView.register(UINib.init(nibName: "FoodCell", bundle: nil), forCellWithReuseIdentifier: "FoodCell")
        if let flowLayout = foodCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(foodCollectionView)
        
    }
    
    // load food posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView15.startAnimating()
        
        Api.FoodPost.observePosts { (post) in
            self.foodPosts.append(post)
            print(self.foodPosts)
            /// stop before view reloads data
            self.activityIndicatorView15.stopAnimating()
            self.activityIndicatorView15.hidesWhenStopped = true
            self.realFoodPosts = self.foodPosts
            self.foodCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView15)
        activityIndicatorView15.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let foodCell = foodCollectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
        let post = foodPosts[indexPath.row]
        foodCell.foodPost = post
        // linking feed VC & feed cell
        foodCell.foodFeedVC = self
        return foodCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = foodPosts[indexPath.row]
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

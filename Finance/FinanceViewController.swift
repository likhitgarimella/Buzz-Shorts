//
//  FinanceViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 14/01/21.
//

import UIKit
// import Firebase

class FinanceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    var financeCollectionView: UICollectionView!
    
    var activityIndicatorView4 = UIActivityIndicatorView(style: .large)
    
    // reference to store model class info
    var financePosts = [FinanceModel]()
    
    // copy of reference
    var realFinancePosts = [FinanceModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        financeCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        financeCollectionView.showsVerticalScrollIndicator = true
        financeCollectionView.backgroundColor = UIColor.white
        
        financeCollectionView.dataSource = self
        financeCollectionView.delegate = self
        
        // Register CollectionViewCell 'FinanceCell' here
        financeCollectionView.register(UINib.init(nibName: "FinanceCell", bundle: nil), forCellWithReuseIdentifier: "FinanceCell")
        if let flowLayout = financeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(financeCollectionView)
        
    }
    
    // load finance posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView4.startAnimating()
        
        Api.FinancePost.observePosts { (post) in
            self.financePosts.append(post)
            print(self.financePosts)
            /// stop before view reloads data
            self.activityIndicatorView4.stopAnimating()
            self.activityIndicatorView4.hidesWhenStopped = true
            self.realFinancePosts = self.financePosts
            self.financeCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView4)
        activityIndicatorView4.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return financePosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let financeCell = financeCollectionView.dequeueReusableCell(withReuseIdentifier: "FinanceCell", for: indexPath) as! FinanceCell
        let post = financePosts[indexPath.row]
        financeCell.financePost = post
        // linking feed VC & feed cell
        financeCell.financeFeedVC = self
        return financeCell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        /// ref for model 'post'
        let post = financePosts[indexPath.row]
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

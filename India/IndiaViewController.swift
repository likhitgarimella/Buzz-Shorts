//
//  IndiaViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 13/01/21.
//

import UIKit
// import Firebase

class IndiaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    // @IBOutlet var indiaCollectionView: UICollectionView!
    // @IBOutlet var activityIndicatorView2: UIActivityIndicatorView!
    
    var indiaCollectionView: UICollectionView!
    var activityIndicatorView2 = UIActivityIndicatorView(style: .whiteLarge)
    
    // reference to store IndiaModel class info
    var indiaPosts = [IndiaModel]()
    
    // copy of reference
    var realIndiaPosts = [IndiaModel]()
    
    func CollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        indiaCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        indiaCollectionView.showsVerticalScrollIndicator = false
        indiaCollectionView.backgroundColor = UIColor.white
        
        indiaCollectionView.dataSource = self
        indiaCollectionView.delegate = self
        
        // Register CollectionViewCell 'IndiaCell' here
        indiaCollectionView.register(UINib.init(nibName: "IndiaCell", bundle: nil), forCellWithReuseIdentifier: "IndiaCell")
        if let flowLayout = indiaCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        self.view.addSubview(indiaCollectionView)
        
    }
    
    // load india posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView2.startAnimating()
        
        Api.IndiaPost.observePosts { (post) in
            self.indiaPosts.append(post)
            print(self.indiaPosts)
            /// stop before view reloads data
            self.activityIndicatorView2.stopAnimating()
            self.activityIndicatorView2.hidesWhenStopped = true
            self.realIndiaPosts = self.indiaPosts
            self.indiaCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        self.view.addSubview(activityIndicatorView2)
        activityIndicatorView2.center = self.view.center
        
        CollectionView()
        
        loadPosts()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indiaPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indiaCell = indiaCollectionView.dequeueReusableCell(withReuseIdentifier: "IndiaCell", for: indexPath) as! IndiaCell
        let post = indiaPosts[indexPath.row]
        indiaCell.indiaPost = post
        // linking feed VC & feed cell
        indiaCell.indiaFeedVC = self
        return indiaCell
        
    }
    
}   // #102

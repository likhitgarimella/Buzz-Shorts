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
    @IBOutlet var indiaCollectionView: UICollectionView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // reference to store IndiaModel class info
    var indiaPosts = [IndiaModel]()
    
    // copy of reference
    var realIndiaPosts = [IndiaModel]()
    
    // load india posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView.startAnimating()
        
        Api.IndiaPost.observePosts { (post) in
            self.indiaPosts.append(post)
            print(self.indiaPosts)
            /// stop before view reloads data
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidesWhenStopped = true
            self.realIndiaPosts = self.indiaPosts
            self.indiaCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        activityIndicatorView.center = self.view.center
        
        indiaCollectionView.delegate = self
        indiaCollectionView.dataSource = self
        
        // Register CollectionViewCell 'IndiaCell' here
        indiaCollectionView.register(UINib.init(nibName: "IndiaCell", bundle: nil), forCellWithReuseIdentifier: "IndiaCell")
        if let flowLayout = indiaCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
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
    
}   // #82

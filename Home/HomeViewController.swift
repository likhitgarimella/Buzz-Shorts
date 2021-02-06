//
//  HomeViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 16/12/20.
//

import UIKit
import SideMenu
// import Firebase

class HomeViewController: UIViewController, MenuControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet var homeCollectionView: UICollectionView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    private var sideMenu: SideMenuNavigationController?
    
    private let indiaController = IndiaViewController()
    private let worldController = WorldViewController()
    private let financeController = FinanceViewController()
    private let techController = TechViewController()
    private let autoController = AutoViewController()
    private let sportsController = SportsViewController()
    private let entertainmentController = EntertainmentViewController()
    private let healthController = HealthViewController()
    private let lifestyleController = LifestyleViewController()
    private let travelController = TravelViewController()
    private let astroController = AstroViewController()
    private let propertyController = PropertyViewController()
    private let educationController = EducationViewController()
    private let foodController = FoodViewController()
    private let environmentController = EnvironmentViewController()
    private let offbeatController = OffbeatNewsViewController()
    private let toptenController = TopTenViewController()
    private let storiesController = StoriesViewController()
    private let diyController = DIYViewController()
    private let moodfreshController = MoodfreshViewController()
    private let hotController = HotOvenViewController()
    private let gamingController = GamingViewController()
    private let jobsController = JobsViewController()
    private let photoController = PhotoGalleryViewController()
    private let videosController = VideosViewController()
    private let miscellanyController = MiscellanyViewController()
    
    func SideMenuProp() {
        
        let menu = MenuController(with: SideMenuItem.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
    }
    
    // reference to store HomeModel class info
    var homePosts = [HomeModel]()
    
    // copy of reference
    var realHomePosts = [HomeModel]()
    
    // load home posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView.startAnimating()
        
        Api.HomePost.observePosts { (post) in
            self.homePosts.append(post)
            print(self.homePosts)
            /// stop before view reloads data
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidesWhenStopped = true
            self.realHomePosts = self.homePosts
            self.homeCollectionView.reloadData()
        }
        
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        activityIndicatorView.center = self.view.center
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        // Register CollectionViewCell 'HomeCell' here
        homeCollectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        if let flowLayout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        loadPosts()
        
        SideMenuProp()
        AddChildControllers()
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let homeCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let post = homePosts[indexPath.row]
        homeCell.homePost = post
        // linking feed VC & feed cell
        homeCell.homeFeedVC = self
        return homeCell
        
    }
    
    // MARK: -
    
    private func AddChildControllers() {
        
        addChild(indiaController)
        addChild(worldController)
        addChild(financeController)
        addChild(techController)
        addChild(autoController)
        addChild(sportsController)
        addChild(entertainmentController)
        addChild(healthController)
        addChild(lifestyleController)
        addChild(travelController)
        addChild(astroController)
        
        view.addSubview(indiaController.view)
        view.addSubview(worldController.view)
        view.addSubview(financeController.view)
        view.addSubview(techController.view)
        view.addSubview(autoController.view)
        view.addSubview(sportsController.view)
        view.addSubview(entertainmentController.view)
        view.addSubview(healthController.view)
        view.addSubview(lifestyleController.view)
        view.addSubview(travelController.view)
        view.addSubview(astroController.view)
        
        indiaController.view.frame = view.bounds
        worldController.view.frame = view.bounds
        financeController.view.frame = view.bounds
        techController.view.frame = view.bounds
        autoController.view.frame = view.bounds
        sportsController.view.frame = view.bounds
        entertainmentController.view.frame = view.bounds
        healthController.view.frame = view.bounds
        lifestyleController.view.frame = view.bounds
        travelController.view.frame = view.bounds
        astroController.view.frame = view.bounds
        
        /// View Controller Lifecycle
        indiaController.didMove(toParent: self)
        worldController.didMove(toParent: self)
        financeController.didMove(toParent: self)
        techController.didMove(toParent: self)
        autoController.didMove(toParent: self)
        sportsController.didMove(toParent: self)
        entertainmentController.didMove(toParent: self)
        healthController.didMove(toParent: self)
        lifestyleController.didMove(toParent: self)
        travelController.didMove(toParent: self)
        astroController.didMove(toParent: self)
        
        /// Keep all hidden initially
        indiaController.view.isHidden = true
        worldController.view.isHidden = true
        financeController.view.isHidden = true
        techController.view.isHidden = true
        autoController.view.isHidden = true
        sportsController.view.isHidden = true
        entertainmentController.view.isHidden = true
        healthController.view.isHidden = true
        lifestyleController.view.isHidden = true
        travelController.view.isHidden = true
        astroController.view.isHidden = true
        
    }
    
    @IBAction func didTapMenuButton() {
        
        present(sideMenu!, animated: true)
        
    }
    
    func didSelectMenuItem(named: SideMenuItem) {
        
        sideMenu?.dismiss(animated: true, completion: nil)
            
            title = named.rawValue
            
            switch named {
            
            case .home:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .india:
                indiaController.view.isHidden = false
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .world:
                indiaController.view.isHidden = true
                worldController.view.isHidden = false
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .finance:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = false
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .tech:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = false
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .auto:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = false
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .sports:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = false
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .entertainment:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = false
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .health:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = false
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .lifestyle:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = false
                travelController.view.isHidden = true
                astroController.view.isHidden = true
            case .travel:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = false
                astroController.view.isHidden = true
            case .astro:
                indiaController.view.isHidden = true
                worldController.view.isHidden = true
                financeController.view.isHidden = true
                techController.view.isHidden = true
                autoController.view.isHidden = true
                sportsController.view.isHidden = true
                entertainmentController.view.isHidden = true
                healthController.view.isHidden = true
                lifestyleController.view.isHidden = true
                travelController.view.isHidden = true
                astroController.view.isHidden = false
            
        }
        
    }
    
}   // #359

//
//  CustomTabBarController.swift
//  FacebookNewFeed
//
//  Created by Vicki Yang on 2023/8/23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedVC = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedNav.title = "New Feed"
        feedNav.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendRequestVC = FriendRequestsController()
        let friendRequestNav = UINavigationController(rootViewController: friendRequestVC)
        friendRequestNav.title = "Requests"
        friendRequestNav.tabBarItem.image = UIImage(named: "requests_icon")
        
        let messengerVC = UIViewController()
        messengerVC.navigationItem.title = "Messenger"
        let messengerNav = UINavigationController(rootViewController: messengerVC)
        messengerNav.title = "Messenger"
        messengerNav.tabBarItem.image = UIImage(named: "messenger_icon")
        
        let notificationsVC = UIViewController()
        notificationsVC.navigationItem.title = "Notifications"
        let notificationsNav = UINavigationController(rootViewController: notificationsVC)
        notificationsNav.title = "Notifications"
        notificationsNav.tabBarItem.image = UIImage(named: "globe_icon")
        
        let moreVC = UIViewController()
        moreVC.navigationItem.title = "More"
        let moreNav = UINavigationController(rootViewController: moreVC)
        moreNav.title = "More"
        moreNav.tabBarItem.image = UIImage(named: "more_icon")
        
        viewControllers = [feedNav, friendRequestNav, messengerNav, notificationsNav, moreNav]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}

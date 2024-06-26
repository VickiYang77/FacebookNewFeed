//
//  ViewController.swift
//  FacebookNewFeed
//
//  Created by Vicki Yang on 2023/8/9.
//

import UIKit

let cellId = "cellId123"

class FeedViewController: UICollectionViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        
        let postKiki = Post()
        postKiki.name = "Kiki"
        postKiki.statusText = "《魔女宅急便》於1989年首映，是吉卜力工作室推出的動畫電影，也是吉卜力工作室製作的第4部作品，由宮崎駿所執導、製作與編劇並獲得1989年Animage漫畫大獎。"
        postKiki.profileImageName = "kiki_profile"
        postKiki.statusImageName = "kiki_status"
        postKiki.numLikes = 777
        postKiki.numComments = 300
        postKiki.statusImageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWIvZv0L7SgYGKvUxKRyuO-ROMoIWwc_t6mLdsHaSYxYlsa0SuqEmy2MbOkTDE2FZDbgM&usqp=CAU"
        
        let postGirlWorld = Post()
        postGirlWorld.name = "Girl's world"
        postGirlWorld.statusText = "Hello World!"
        postGirlWorld.profileImageName = "girlWorld_profile"
        postGirlWorld.statusImageName = "girlWorld_status"
        postGirlWorld.numLikes = 666
        postGirlWorld.numComments = 37
        postGirlWorld.statusImageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXZzpa26AfiwimO1WvnLoko2IOCgmHxBtYyAYTaBx4P04gr8jEkkViJxqXZNbiurZq0iQ&usqp=CAU"
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\nBeing the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\nSometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.profileImageName = "steve_profile"
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 150
        postSteve.numComments = 222
        postSteve.statusImageUrl = "https://argjirolajm.net/wp-content/uploads/2021/04/Apple-768x410.jpg"
        
        let postZuck = Post()
        postZuck.name = "Mark Zuckerberg"
        postZuck.statusText = "By giving people the power to share, we're making the world more transparent."
        postZuck.profileImageName = "zuck_profile"
        postZuck.statusImageName = "zuck_status"
        postZuck.numLikes = 333
        postZuck.numComments = 444
        postZuck.statusImageUrl = "https://images.gizbot.com/webp/img/2022/11/mark-zuckerberg-firing-meta-employees-1667992306.jpg"
        
        posts.append(postKiki)
        posts.append(postGirlWorld)
        posts.append(postSteve)
        posts.append(postZuck)
        
        navigationItem.title = "Facebook Feed"
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var statusImageView: UIImageView?
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    func animate(_ statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            statusImageView.alpha = 0
            
            // black backGround View
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            // navBar Cover
            if let keyWindow = UIApplication.shared.keyWindow,
               let navBarHeight = navigationController?.navigationBar.frame.height,
               let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets {
                let navBarCoverHeight = navBarHeight + safeAreaInsets.top
                navBarCoverView.frame = CGRectMake(0, 0, 1000, navBarCoverHeight)
                navBarCoverView.backgroundColor = .black
                navBarCoverView.alpha = 0
                keyWindow.addSubview(navBarCoverView)
            }
            
            // tabBar Cover
            if let keyWindow = UIApplication.shared.keyWindow,
               let tabBarHeight = tabBarController?.tabBar.frame.height {
                tabBarCoverView.frame = CGRectMake(0, keyWindow.frame.height - tabBarHeight, 1000, tabBarHeight)
                tabBarCoverView.backgroundColor = .black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            // zoom Image
            zoomImageView.backgroundColor = .red
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            // set zoomOut gesture
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            // zoomIn
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                let height = (self.view.frame.width / statusImageView.frame.width) * statusImageView.frame.height
                let y = (self.view.frame.height - height) / 2
                self.zoomImageView.frame = CGRectMake(0, y, self.view.frame.width, height)
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            })
        }
    }
    
    @objc func zoomOut() {
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
            
            UIView.animate(withDuration: 0.75) {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            } completion: { didComplete in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath.item]
        feedCell.feedViewController = self
        return feedCell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 轉向
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewController Delegate
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            let rect = statusText.boundingRect(
                with: CGSize(width: view.frame.width, height: 1000),
                options: [.usesFontLeading, .usesLineFragmentOrigin],
                attributes: [.font: UIFont.systemFont(ofSize: 14)],
                context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return  CGSize(width: view.frame.width, height: rect.height + knownHeight + 24)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
}

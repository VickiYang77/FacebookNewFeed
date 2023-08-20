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
        
        let postVicki = Post()
        postVicki.name = "Vicki Yang"
        postVicki.statusText = "Hello World!"
        postVicki.profileImageName = "vicki_profile"
        postVicki.statusImageName = "vicki_status"
        postVicki.numLikes = 777
        postVicki.numComments = 300
        postVicki.statusImageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWIvZv0L7SgYGKvUxKRyuO-ROMoIWwc_t6mLdsHaSYxYlsa0SuqEmy2MbOkTDE2FZDbgM&usqp=CAU"
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Design is not just what it looks like and feels like. Design is how it works.\n\nBeing the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\nSometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations."
        postSteve.profileImageName = "steve_profile"
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 150
        postSteve.numComments = 222
        postSteve.statusImageUrl = "https://womany.net/cdn-cgi/image/w=800,fit=scale-down,f=auto/https://castle.womany.net/images/content/pictures/135467/44f0120fd20ef3dc899042bd4b14eb2a.jpg"
        
        let postZuck = Post()
        postZuck.name = "Mark Zuckerberg"
        postZuck.statusText = "By giving people the power to share, we're making the world more transparent."
        postZuck.profileImageName = "zuck_profile"
        postZuck.statusImageName = "zuck_status"
        postZuck.numLikes = 333
        postZuck.numComments = 444
        
        posts.append(postVicki)
        posts.append(postSteve)
        posts.append(postZuck)
        
        navigationItem.title = "Facebook Feed"
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath.item]
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

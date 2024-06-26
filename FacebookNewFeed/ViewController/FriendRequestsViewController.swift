//
//  FriendRequestsViewController.swift
//  FacebookNewFeed
//
//  Created by Vicki Yang on 2023/8/23.
//

import UIKit

class FriendRequestsController: UITableViewController {
    
    static let cellId = "cellId"
    static let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Friend Requests"
        
        tableView.separatorColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        tableView.sectionHeaderHeight = 26
        
        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: FriendRequestsController.cellId)
        tableView.register(RequestHeader.self, forHeaderFooterViewReuseIdentifier: FriendRequestsController.headerId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: FriendRequestsController.cellId, for: indexPath) as! FriendRequestCell
        
        if indexPath.row % 3 == 0 {
            cell.nameLabel.text = "Kiki"
            cell.requestImageView.image = UIImage(named: "kiki_profile")
        } else if indexPath.row % 3 == 1 {
            cell.nameLabel.text = "Girl's World"
            cell.requestImageView.image = UIImage(named: "girlWorld_profile")
        } else {
            cell.nameLabel.text = "Steve Jobs"
            cell.requestImageView.image = UIImage(named: "steve_profile")
        }
        
        cell.imageView?.backgroundColor = UIColor.black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendRequestsController.headerId) as! RequestHeader
        
        if section == 0 {
            header.nameLabel.text = "FRIEND REQUESTS"
        } else {
            header.nameLabel.text = "PEOPLE YOU MAY KNOW"
        }
        
        return header
    }
    
}

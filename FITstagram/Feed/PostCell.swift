//
//  PostCell.swift
//  FITstagram
//
//  Created by Jakub Olejník on 28.10.2020.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var personButton: UIButton!
    @IBOutlet weak var photoHeader: PhotoHeader!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var personTapped: (() -> (Void))?
    
    var post: Post? {
        didSet {
            photoHeader.usernameLabel.text = post?.username
            photoHeader.locationLabel.text = post?.location
//            photoImageView.image = post?.image
            photoImageView.image = UIImage(named: "image")!
            descriptionLabel.text = post?.caption
//            followButton.isSelected = post?.isFollowed ?? false
            followButton.isSelected = false
//            likes = post?.likes ?? 0
            likes = 0
        }
    }
    
    private var likes = 0 {
        didSet {
            likeButton.setTitle("\(likes) likes", for: .normal)
        }
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func personButtonTapped(_ sender: Any) {
        personTapped?()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likes += 1
    }
}

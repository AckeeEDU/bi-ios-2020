//
//  ViewController.swift
//  FITstagram
//
//  Created by Jakub Olejník on 01.10.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var likes = 87 {
        didSet {
            likeButton.setTitle("\(likes) likes", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoHeader = PhotoHeader(frame: CGRect(x: 20, y: 50, width: 100, height: 45))
        photoHeader.center.x = view.center.x
        view.addSubview(photoHeader)
        photoHeader.usernameLabel.text = "olejnjak"
        photoHeader.locationLabel.text = "Praha"
        
        photoImageView.image = UIImage(named: "image")
        descriptionLabel.text = "Auto"
        
        let likeAction = UIAction { [weak self] _ in
            self?.likes += 1
        }
        
        likeButton.setTitle("87 likes", for: .normal)
        likeButton.addAction(likeAction, for: .touchUpInside)
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Unfollow", for: .selected)
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc private func moreButtonTapped() {
        print("More button tapped!")
    }
}


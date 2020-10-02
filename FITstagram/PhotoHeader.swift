//
//  PhotoHeader.swift
//  FITstagram
//
//  Created by Jakub Olejník on 01.10.2020.
//

import UIKit

class PhotoHeader: UIView {
    weak var usernameLabel: UILabel!
    weak var locationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        usernameLabel.text = "Username"
        usernameLabel.textAlignment = .center
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        addSubview(usernameLabel)
        self.usernameLabel = usernameLabel
        
        let locationLabel = UILabel(frame: CGRect(x: 0, y: 25, width: 100, height: 20))
        locationLabel.text = "Location"
        locationLabel.textAlignment = .center
        locationLabel.font = .systemFont(ofSize: 14)
        addSubview(locationLabel)
        self.locationLabel = locationLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Private helpers
    
    private func setup() {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username"
        usernameLabel.textAlignment = .center
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        addSubview(usernameLabel)

        let margin = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            usernameLabel.leftAnchor.constraint(equalTo: margin.leftAnchor),
            usernameLabel.rightAnchor.constraint(equalTo: margin.rightAnchor),
            usernameLabel.topAnchor.constraint(equalTo: margin.topAnchor)
        ])

        self.usernameLabel = usernameLabel
        
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "Location"
        locationLabel.textAlignment = .center
        locationLabel.font = .systemFont(ofSize: 14)
        addSubview(locationLabel)

        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            locationLabel.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        self.locationLabel = locationLabel
    }
}

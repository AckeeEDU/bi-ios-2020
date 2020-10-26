//
//  ProfileViewController.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 26/10/2020.
//

import UIKit

final class ProfileViewController: UIViewController {
    private weak var profileImageView: UIImageView!
    private weak var usernameLabel: UILabel!
    private weak var editUsernameButton: UIButton!
    private weak var postsLabel: UILabel!
    private weak var descriptionLabel: UILabel!
    
    var username: String? = "username" {
        didSet {
            usernameLabel.text = username
        }
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let profileImageView = UIImageView(image: UIImage(named: "image"))
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = 4
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        self.profileImageView = profileImageView
        
        let usernameLabel = UILabel()
        usernameLabel.text = username
        usernameLabel.font = .systemFont(ofSize: 36)
        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16)
        ])
        self.usernameLabel = usernameLabel
        
        let editUsernameButton = UIButton(type: .system)
        editUsernameButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editUsernameButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.addSubview(editUsernameButton)
        editUsernameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editUsernameButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            editUsernameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            editUsernameButton.leadingAnchor.constraint(greaterThanOrEqualTo: usernameLabel.trailingAnchor, constant: 16)
        ])
        self.editUsernameButton = editUsernameButton
        
        let postsLabel = UILabel()
        postsLabel.text = "posts: 154"
        postsLabel.font = .systemFont(ofSize: 16)
        view.addSubview(postsLabel)
        postsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postsLabel.topAnchor.constraint(equalTo: editUsernameButton.bottomAnchor, constant: 16),
            postsLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
        ])
        self.postsLabel = postsLabel
        
        let descriptionParagraphStyle = NSMutableParagraphStyle()
        descriptionParagraphStyle.lineSpacing = 3
        
        let descriptionLabel = UILabel()
        descriptionLabel.attributedText = NSAttributedString(
            string: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Fusce nibh. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Nunc tincidunt ante vitae massa.",
            attributes: [.paragraphStyle: descriptionParagraphStyle]
        )
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        self.descriptionLabel = descriptionLabel
        
        let horizontalStackView1 = UIStackView(arrangedSubviews: [
            thumbnailImageView(image: UIImage(named: "image")),
            thumbnailImageView(image: UIImage(named: "image")),
            thumbnailImageView(image: UIImage(named: "image"))
        ])
        horizontalStackView1.axis = .horizontal
        horizontalStackView1.distribution = .fillEqually
        
        let horizontalStackView2 = UIStackView(arrangedSubviews: [
            thumbnailImageView(image: UIImage(named: "image")),
            thumbnailImageView(image: UIImage(named: "image")),
            thumbnailImageView(image: UIImage(named: "image"))
        ])
        horizontalStackView2.axis = .horizontal
        horizontalStackView2.distribution = .fillEqually
        
        let verticalStackView = UIStackView(arrangedSubviews: [horizontalStackView1, horizontalStackView2])
        verticalStackView.axis = .vertical
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editUsernameAction = UIAction { [weak self] _ in
            let alert = UIAlertController(
                title: "Change username",
                message: "Changing username will sign you in as a different user.",
                preferredStyle: .alert
            )
            alert.addTextField { [weak self] textField in
                textField.text = self?.username
                textField.placeholder = "Username"
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self?.username = alert.textFields?.first?.text
            })
            self?.present(alert, animated: true)
        }
        editUsernameButton.addAction(editUsernameAction, for: .touchUpInside)
    }
    
    // MARK: - Helpers
    
    private func thumbnailImageView(image: UIImage?) -> UIImageView {
        let thumbnailImageView = UIImageView(image: image)
        thumbnailImageView.backgroundColor = .lightGray
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.darkGray.cgColor
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor)
        ])
        
        return thumbnailImageView
    }
}

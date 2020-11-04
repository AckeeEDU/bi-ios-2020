//
//  FeedViewController.swift
//  FITstagram
//
//  Created by Jakub Olejník on 01.10.2020.
//

import UIKit

struct Post: Hashable {
    let author: String
    let isFollowed: Bool
    let location: String
    let image: UIImage
    let likes: Int
    let description: String
}

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Int, Post>!
    
    private var posts: [Post] = [] {
        didSet {
            applySnapshot()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, post in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.post = post
            cell.personTapped = { [weak self] in self?.personTapped(in: post) }
            return cell
        }
    
        navigationItem.title = "Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationController?.navigationBar.isTranslucent = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.posts.append(
                Post(
                    author: "olejnjak",
                    isFollowed: false,
                    location: "Praha",
                    image: UIImage(named: "image")!,
                    likes: 87,
                    description: "Lorem ipsum dolor sit amet"
                )
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.posts.append(
                Post(
                    author: "lukas",
                    isFollowed: false,
                    location: "Praha",
                    image: UIImage(named: "image2")!,
                    likes: 86,
                    description: "Lorem ipsum dolor sit amet"
                )
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.posts = []
        }
    }
    
    private func personTapped(in post: Post) {
        let controller = DummyViewController(color: .red)
        controller.title = post.author

        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "AddPhotoNavigationController")
        present(controller, animated: true)
    }
    
    // MARK: - Private helpers

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Post>()
        snapshot.appendSections([0])
        snapshot.appendItems(posts)
        dataSource.apply(snapshot)
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TableView selected row")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let post = dataSource.itemIdentifier(for: indexPath) else { return }
        
        print("[POST_SELECTED]", post.author)
    }
}

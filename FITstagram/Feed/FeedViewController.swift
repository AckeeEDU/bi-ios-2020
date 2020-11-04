//
//  FeedViewController.swift
//  FITstagram
//
//  Created by Jakub Olejník on 01.10.2020.
//

import UIKit

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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = URL(string: "https://ackeeedu.000webhostapp.com/api.php/records/posts")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("[ERROR]", error.localizedDescription)
                return
            }
            
            guard let data = data else { assertionFailure(); return }
            
            let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
            self?.posts = decoded.posts
        }
        task.resume()
    }
    
    // MARK: - Actions
    
    private func personTapped(in post: Post) {
        let controller = DummyViewController(color: .red)
        controller.title = post.username

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
        
        print("[POST_SELECTED]", post.username)
    }
}

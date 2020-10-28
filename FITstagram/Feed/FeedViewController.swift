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
        
        DispatchQueue.main.async { [weak self] in
            self?.addData()
        }
    
        navigationItem.title = "Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func personTapped(in post: Post) {
        let controller = DummyViewController(color: .red)
        controller.title = post.author
//        present(controller, animated: true)

        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "AddPhotoNavigationController")
        present(controller, animated: true)
    }
    
    // MARK: - Private helpers
    
    private func addData() {
        let description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla dolor augue, efficitur sed venenatis non, tristique vitae risus. Proin mattis pretium pellentesque. Pellentesque malesuada nisi eleifend magna condimentum, id dignissim metus aliquet. Quisque turpis dolor, condimentum ut malesuada non, finibus a mi. Cras pulvinar laoreet accumsan. Quisque in porttitor neque. Vestibulum in risus id lectus semper porttitor. Sed non velit aliquam sem tempor dictum. Aliquam euismod dui magna, in pellentesque lectus lobortis id. Praesent nibh mi, ultricies at justo sed, aliquet facilisis felis. Quisque finibus euismod bibendum. Etiam quam nibh, tincidunt eu gravida vel, aliquam aliquet dui. Integer pretium ipsum non dui tempor molestie. Morbi non ipsum tempus, pulvinar arcu id, tristique mi. Nullam eget elit tempus, mattis leo sed, lobortis diam. Etiam ac sem et elit consectetur pretium."
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Post>()
        snapshot.appendSections([0])
        snapshot.appendItems([
            Post(author: "olejnjak", isFollowed: false, location: "Praha", image: UIImage(named: "image")!, likes: 87, description: description),
            Post(author: "lukas", isFollowed: false, location: "Praha", image: UIImage(named: "image2")!, likes: 86, description: description),
            Post(author: "honza", isFollowed: false, location: "Praha", image: UIImage(named: "image3")!, likes: 85, description: description),
            Post(author: "marek", isFollowed: false, location: "Praha", image: UIImage(named: "image4")!, likes: 84, description: description),
        ])
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

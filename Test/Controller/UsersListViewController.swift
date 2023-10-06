//
//  ViewController.swift
//  Test
//
//  Created by Деним Мержан on 04.10.23.
//

import UIKit
import SnapKit


class UsersListViewController: UIViewController, ConstraintRelatableTarget {
    
    private let networkManager = NetworkService.shared
    private var users: [User]?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        setupView()
        
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error with fetch users \(error)")
            }
        }
    }
    
    func setupView() {
        tableView.snp.makeConstraints { make in
            tableView.snp.makeConstraints { make in
                make.left.top.right.bottom.equalTo(self.view)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.title = "Chat"
        
    }
    
    
    @objc func addTapped() {
        let newUserController = NewUserController()
        newUserController.title = "Create New User"
        navigationController?.pushViewController(newUserController, animated: true)
    }
    
}

// MARK: - TableView

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell,
              let user = users?[indexPath.row] else {return UITableViewCell() }
        
        cell.label.text = user.firstName
        networkManager.fetchAvatar(from: user.avatar) { data in
            cell.avatar.image = UIImage(data: data)
        }
        
        return cell
    }
    
    
}

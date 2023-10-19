//
//  ViewController.swift
//  Test
//
//  Created by Деним Мержан on 04.10.23.
//

import UIKit
import SnapKit


class UsersController: UIViewController, ConstraintRelatableTarget {
    
    private let networkManager =  UserListNetworService()
    private var users: [User]?
    private var selectedUser: User?
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
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
        setupView()
        setupConstraints()
    }
    
    func setupView() {

        self.view.addSubview(tableView)
        self.view.addSubview(spinner)
        self.view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.title = "Chat"
        
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.tableView.reloadData()
                self?.spinner.stopAnimating()
            case .failure(let error):
                self?.showAlert(with: error)
            }
        }
        
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            tableView.snp.makeConstraints { make in
                make.left.top.right.bottom.equalTo(self.view)
            }
        }
        
        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.view)
        }
    }
    
    func showAlert(with error: NetworkError) {
        let alert = UIAlertController(title: error.description, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    @objc func addTapped() {
        let newUserController = AddUserController()
        newUserController.delegate = self
        newUserController.title = "Create New User"
        navigationController?.pushViewController(newUserController, animated: true)
    }
    
}

// MARK: - TableView

extension UsersController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell,
              let user = users?[indexPath.row] else {return UITableViewCell() }
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = users?[indexPath.row] else {return}
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailController()
        detailVC.user = user
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = users?[indexPath.row].id else {return}
            deleteUser(id: id, at: indexPath)
        }
    }
}

// MARK: - UserAdded

extension UsersController: AddUserDelegate {
    func userSuccessAdded(user: User) {
        self.users?.append(user)
        tableView.reloadData()
    }
}

extension UsersController {
    func deleteUser(id: Int, at indexPath: IndexPath) {
        networkManager.deleteUser(id: id) { [weak self] success in
            if success {
                self?.users?.remove(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                self?.showAlert(with: .deletingError)
            }
        }
    }
}

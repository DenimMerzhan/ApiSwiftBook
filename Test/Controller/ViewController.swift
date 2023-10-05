//
//  ViewController.swift
//  Test
//
//  Created by Деним Мержан on 04.10.23.
//

import UIKit
import SnapKit


class ViewController: UIViewController, ConstraintRelatableTarget {
    
    private let networkManager = NetworkService.shared
    
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell else {return UITableViewCell() }
        
        cell.label.text = "Mops"
        if let url = URL(string: "https://reqres.in/img/faces/7-image.jpg") {
            networkManager.fetchAvatar(from: url) { data in
                cell.avatar.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    
}

//
//  ViewController.swift
//  Test
//
//  Created by Деним Мержан on 04.10.23.
//

import UIKit
import SnapKit


class ViewController: UIViewController, ConstraintRelatableTarget {

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


    @objc func addTapped(){
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell {
            cell.label.text = "Mops"
            return cell
        }
        return UITableViewCell()
    }
    
    
}

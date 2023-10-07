//
//  UserViewController.swift
//  Test
//
//  Created by Деним Мержан on 07.10.23.
//

import Foundation
import UIKit

class DetailController: UIViewController {
    
    var user: User!
    private let networkService = NetworkService.shared
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = user.firstName + " " + user.lastName
        label.textAlignment = .center
        return label
    }()
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(avatar)
        self.view.addSubview(label)
        self.view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        avatar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.view.frame.width)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(20)
            make.left.right.equalTo(self.view)
        }
        
        networkService.fetchAvatar(from: user.avatar) { [weak self] data in
            self?.avatar.image = UIImage(data: data)
        }
    }
    
}

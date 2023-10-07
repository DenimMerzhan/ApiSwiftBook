//
//  UserCell.swift
//  Test
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation
import UIKit
import SnapKit

class UserCell: UITableViewCell {
    
    static let identifier = "UserCell"
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mops")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        stackView.addArrangedSubview(avatar)
        stackView.addArrangedSubview(label)
        
        stackView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        avatar.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
    }
    
}
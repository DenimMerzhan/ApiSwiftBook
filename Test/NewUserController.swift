//
//  NewUserController.swift
//  Test
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation
import UIKit

class NewUserController: UIViewController {
    
    var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "blalaflfal fl  laf"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "dwwddwd dw wd "
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(firstNameTextField)
        self.view.addSubview(lastNameTextField)
        setupView()
    }
    
    func setupView() {
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            make.height.equalTo(50)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(10)
            make.left.right.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            make.height.equalTo(50)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
    }
    
    @objc func donePressed() {
        navigationController?.popViewController(animated: true)
    }
}

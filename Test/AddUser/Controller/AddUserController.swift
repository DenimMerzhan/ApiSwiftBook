//
//  NewUserController.swift
//  Test
//
//  Created by Деним Мержан on 05.10.23.
//

import Foundation
import UIKit

protocol AddUserDelegate: AnyObject {
    func userSuccessAdded(user: User)
}

final class AddUserController: UIViewController {
    
    private var networkService = AddUserNetworkService()
    
    weak var delegate: AddUserDelegate?
    
    var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(firstNameTextField)
        self.view.addSubview(lastNameTextField)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        
    }
    
    func setupConstraints(){
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
    }
    
    @objc func donePressed() {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text else {return}
        let user = User(firstName: firstName, lastName: lastName)
        addUser(user: user)
    }
}


// MARK: - AddUser, ShowAlert

extension AddUserController {
    func addUser(user: User) {
    
        networkService.addUserToServer(user: user) { [weak self] result in
            switch result {
            case .success(let postUser):
                self?.delegate?.userSuccessAdded(user: User(postUserQuery: postUser))
                self?.showAlert(with: "Пользователь успешно добавлен") {
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                self?.showAlert(with: error.description)
            }
        }
    }
    
    func showAlert(with text: String, completion: (() -> Void)? = {}) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

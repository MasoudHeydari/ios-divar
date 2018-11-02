//
//  LoginAndRegisterController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/22/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class LoginAndRegisterViewController: UIViewController {
    
    private let viewTapGestureRecognizer = UITapGestureRecognizer()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Const.PlaceHolder.userName
        textField.textAlignment = .right
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.Gray.light0
        textField.clipsToBounds = true
        textField.keyboardType = .default
        
        let rightpadingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightView = rightpadingView
        textField.rightViewMode = .always
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Const.PlaceHolder.password
        textField.textAlignment = .right
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.Gray.light0
        textField.clipsToBounds = true
        textField.keyboardType = .default
        
        let rightpadingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightView = rightpadingView
        textField.rightViewMode = .always
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let btnLoginTapped: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Const.BtnTitle.login, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = .darkRedLight
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 0
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 6
        btn.setBackgroundColor(color: .darkRedLight, forState: .normal)
        btn.setBackgroundColor(color: .darkRedDark, forState: .highlighted)
        btn.addTarget(self, action: #selector(btnLoginTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = Const.TempText.loginUser
        label.textColor = .darkRedLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        
        addViews()
        addSubViewsConstraints()
        addObservers()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .white
        
    }
    
    
    private func addViews() {
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(btnLoginTapped)
    }
    
    private func addSubViewsConstraints(){
        userNameTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        userNameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        userNameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameTextField.delegate = self
        
        passwordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: self.userNameTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor).isActive = true
        passwordTextField.delegate = self
        
        btnLoginTapped.leftAnchor.constraint(equalTo: self.passwordTextField.leftAnchor, constant: 56).isActive = true
        btnLoginTapped.rightAnchor.constraint(equalTo: self.passwordTextField.rightAnchor, constant: -56).isActive = true
        btnLoginTapped.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20).isActive = true
        btnLoginTapped.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
    }
    
    private func setupNavBar(){
        navigationItem.title = Const.NavTitle.loginUser
    }
    
    @objc private func btnLoginTapped(_ sender: UIButton) {
        let userName = userNameTextField.text
        let password = passwordTextField.text
        
        if let userName = userName, let password = password {
            if !userName.isEmpty && !password.isEmpty {
                print("all text field in full!")
                
            }else {
                print("oooops! some text field is nil! fill in the blanck.")
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func viewDidTapped(){
        self.view.endEditing(true)
    }
    
    
}

/* ===================================================================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* =================== *   TEXT FIELD EXTENSION  * ===================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* ===================================================================== */

extension LoginAndRegisterViewController: UITextFieldDelegate {
    
    private func addObservers(){
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardShowing(_:)), name: UIWindow.keyboardDidShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardHiding(_:)), name: UIWindow.keyboardDidHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkRedLight.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
    }
    
    @objc private func keyboardShowing(_ notification: NotificationCenter){
        viewTapGestureRecognizer.addTarget(self, action: #selector(viewDidTapped))
        self.view.addGestureRecognizer(viewTapGestureRecognizer)
    }
    
    @objc private func keyboardHiding(_ notification: NotificationCenter) {
        self.view.removeGestureRecognizer(viewTapGestureRecognizer)
        
    }
}

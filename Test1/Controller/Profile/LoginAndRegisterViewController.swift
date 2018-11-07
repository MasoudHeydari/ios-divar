//
//  LoginAndRegisterController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/22/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginAndRegisterViewController: UIViewController {
    
    var isLogginMode = true
    private let viewTapGestureRecognizer = UITapGestureRecognizer()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Const.PlaceHolder.userName
        textField.textAlignment = .right
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.Gray.light1
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
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Const.PlaceHolder.fullName
        textField.textAlignment = .right
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.Gray.light1
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
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.Gray.light1
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
    
    let loginOrRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = Const.Pages.LoginAndRegister.notRegister
        label.textColor = UIColor.Gray.light10
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 13.5)
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
        view.addSubview(loginOrRegisterLabel)
    }
    
    private func clearMainView(){
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func addSubViewsConstraints(){
        if isLogginMode {
            clearMainView()
            clearTextFields()
            
            view.addSubview(userNameTextField)
            view.addSubview(passwordTextField)
            view.addSubview(btnLoginTapped)
            view.addSubview(loginOrRegisterLabel)
            
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
            
            btnLoginTapped.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 56).isActive = true
            btnLoginTapped.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -56).isActive = true
            btnLoginTapped.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20).isActive = true
            btnLoginTapped.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor).isActive = true
            btnLoginTapped.setTitle(Const.BtnTitle.login, for: .normal)
            
            loginOrRegisterLabel.topAnchor.constraint(equalTo: self.btnLoginTapped.bottomAnchor, constant: 12).isActive = true
            loginOrRegisterLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
            loginOrRegisterLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
            loginOrRegisterLabel.text = Const.Pages.LoginAndRegister.notRegister
            
            let loginLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.loginLabelTapped(_:)))
            self.loginOrRegisterLabel.addGestureRecognizer(loginLabelTapGesture)
            
        } else {
            clearMainView()
            clearTextFields()
            
            view.addSubview(userNameTextField)
            view.addSubview(passwordTextField)
            view.addSubview(btnLoginTapped)
            view.addSubview(loginOrRegisterLabel)
            view.addSubview(fullNameTextField)
            
            fullNameTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
            fullNameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
            fullNameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            fullNameTextField.delegate = self
            
            userNameTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
            userNameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
            userNameTextField.topAnchor.constraint(equalTo: self.fullNameTextField.bottomAnchor, constant: 20).isActive = true
            userNameTextField.heightAnchor.constraint(equalTo: fullNameTextField.heightAnchor).isActive = true
            userNameTextField.delegate = self
            
            passwordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
            passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
            passwordTextField.topAnchor.constraint(equalTo: self.userNameTextField.bottomAnchor, constant: 20).isActive = true
            passwordTextField.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor).isActive = true
            passwordTextField.delegate = self
            
            btnLoginTapped.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 56).isActive = true
            btnLoginTapped.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -56).isActive = true
            btnLoginTapped.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20).isActive = true
            btnLoginTapped.heightAnchor.constraint(equalTo: userNameTextField.heightAnchor).isActive = true
            btnLoginTapped.setTitle(Const.BtnTitle.registerNewUser, for: .normal)
            
            loginOrRegisterLabel.topAnchor.constraint(equalTo: self.btnLoginTapped.bottomAnchor, constant: 12).isActive = true
            loginOrRegisterLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
            loginOrRegisterLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
            loginOrRegisterLabel.text = Const.Pages.LoginAndRegister.alreadyRegistered
            
            let loginLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.loginLabelTapped(_:)))
            self.loginOrRegisterLabel.addGestureRecognizer(loginLabelTapGesture)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        fullNameTextField.layer.cornerRadius = fullNameTextField.frame.height / 2
    }
    
    private func setupNavBar(){
        navigationItem.title = Const.NavTitle.loginUser
    }
    
    @objc private func btnLoginTapped(_ sender: UIButton) {
        viewDidTapped()
        let userName = userNameTextField.text
        let password = passwordTextField.text
        let fullName = fullNameTextField.text
        
        if let userName = userName, let password = password {
            if !userName.isEmpty && !password.isEmpty {
                print("all text field in full!")
                let api = APIService()
                if isLogginMode {
                    api.loginUser(userName: userName, password: password) { [weak self] (response) in
                        if let json = response as? JSON {
                            var style = ToastStyle()
                            style.verticalPadding = 10
                            style.bottomMargin = 30
                            ToastManager.shared.style = style
                            ToastManager.shared.duration = 1.0
                            self?.view.makeToast(json["response"].string) { (didTap) in
                                if json[Const.API.isSuccessful].bool ?? false {
                                    self?.navigationController?.popViewController(animated: true)
                            }
                            }
                        }
                    }
                    clearTextFields()
                } else {
                    if let fullName = fullName {
                        if !fullName.isEmpty {
                            api.registerNewUser(fullName: fullName, userName: userName, password: password){ [weak self] (response) in
                                if let json = response as? JSON {
                                    self?.clearTextFields()
                                    var style = ToastStyle()
                                    style.verticalPadding = 10
                                    style.bottomMargin = 30
                                    ToastManager.shared.style = style
                                    ToastManager.shared.duration = 1.0
                                    self?.view.makeToast(json["response"].string) { (didTap) in
                                        if json[Const.API.isSuccessful].bool ?? false {
                                            self?.navigationController?.popViewController(animated: true)
                                    }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                
            }else {
                print("oooops! some text field is nil! fill in the blanck.")
                var style = ToastStyle()
                
                style.verticalPadding = 10
                style.bottomMargin = 30
                ToastManager.shared.style = style
                ToastManager.shared.duration = 1.5
                self.view.makeToast(Const.Toast.fillInTheBlank)
            }
        }
    }
    
    private func clearTextFields(){
        self.fullNameTextField.text = ""
        self.passwordTextField.text = ""
        self.userNameTextField.text = ""
    }
    
    @objc private func loginLabelTapped(_ sender: UILabel) {
        print("login label tapped!")
        isLogginMode = !isLogginMode
        self.addSubViewsConstraints()
        self.view.layoutIfNeeded()
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
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
    }
    
    @objc private func keyboardShowing(_ notification: NotificationCenter){
        viewTapGestureRecognizer.addTarget(self, action: #selector(viewDidTapped))
        self.view.addGestureRecognizer(viewTapGestureRecognizer)
    }
    
    @objc private func keyboardHiding(_ notification: NotificationCenter) {
        self.view.removeGestureRecognizer(viewTapGestureRecognizer)
        
    }
}

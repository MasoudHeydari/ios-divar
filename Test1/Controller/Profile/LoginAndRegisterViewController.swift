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
    
    let tfFullName = "full_name"
    let tfUserName = "user_name"
    let tfPassword = "password"
    
    var allTextFields = [UITextField]()
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
        textField.backgroundColor = UIColor.Gray.light1
        textField.isSecureTextEntry = true
        textField.textAlignment = .right
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.systemFont(ofSize: 16)
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
        clearTextOfTextFields()
        
        if isLogginMode {
            clearMainView()
            
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
        
        // first of all, set backgroundcolor and border color of all text fields to default. added by: Masoud Heydari 12 NOV 2018   10:01 AM
        userNameTextField.layer.borderColor = UIColor.Gray.light2.cgColor
        userNameTextField.backgroundColor = UIColor.Gray.light1
        
        passwordTextField.layer.borderColor = UIColor.Gray.light2.cgColor
        passwordTextField.backgroundColor = UIColor.Gray.light1
        
        fullNameTextField.layer.borderColor = UIColor.Gray.light2.cgColor
        fullNameTextField.backgroundColor = UIColor.Gray.light1
        
        if isLogginMode {
            // user is in loggin mode, so we have only two textfileds: userName and password textfields. added by: Masoud Heydari. 12 NOV 2018   09:20  AM
            
            if let userName = userName, let password = password {
                // inputs of two text fields unwrapped. added by: Masoud Heydari  12 NOV 2018  09:23  AM
                if !userName.isEmpty && !password.isEmpty {
                    // all text fields (in loggin mode) is full but not validate yet. added by: Masoud Heydari  12 NOV 2018  09:31  AM
                    // validate user inputs. added by: Masoud Heydari  12  NOV 2018  10:11 AM
                    let boolsDic = validateInputOfTextFields(textFields: [self.userNameTextField, self.passwordTextField])
                    
                    if boolsDic[self.tfPassword]! && boolsDic[self.tfUserName]! {
                        // ( in loggin mode ) all two text fields are valid inputs. let's dive in loggin proccess. added by: Masoud Heydari   12 NOV 2018   10:15  AM
                        
                        // check internet connection
                        if Utils.checkInternetConnection() {
                            // all things is ready for loggin proccess. added by:  Masoud Heydari  12 NOV 2018   11:24  AM
                            APIService.shared.loginUser(userName: userName, password: password) { [weak self] (response) in
                                if let json = response as? JSON {
                                    self?.makeDefualtToast(string: json["response"].string!, completion: { (didTap) in
                                        if json[Const.API.isSuccessful].bool ?? false {
                                            // if user successfully logged in, pop the view and back to profile controller. added by: Masoud Heydari  12 NOV 2018   10:54  AM
                                            self?.navigationController?.popViewController(animated: true)
                                            self?.clearTextOfTextFields()
                                            
                                        }
                                    })
                                }
                            }
                            
                        } else {
                            // all things is ready for loggin proccess, but there is no internet connection.   added by: Masoud Heydari   12 NOV 2018   11:22  AM
                            self.makeDefualtToast(string: Const.Toast.checkInternetConnection)
                        }
                    } else {
                        // ( in loggin mode ) all text fields have value but not validate yet, show a toast and tell it to user. added by: Masoud Heydari  12 NOV 2018   10:20  AM
                        self.makeDefualtToast(string: Const.Toast.shortCharacter)
                    }
                } else {
                    // ( in login mode ) one or more text fields are empty. make a toast an tell to user to fill in the blanck. adde by : Masoud Heydari   12 NOV 2018  10:24 AM
                    self.makeDefualtToast(string: Const.Toast.fillInTheBlank)
                    // change the background color and border color of empty text fields. added by: Masoud heydari  12 NOV 2018   10:51  AM
                    self.validateTextFields(textFields: [self.userNameTextField, self.passwordTextField])
                }
            }
        }
        else {
            // user is in register mode, so we have three textfields: fulname, userName and password. added by: Masoud Heydari 12 NPV 2018  09:28 AM
            if let userName = userName, let password = password, let fullName = fullName {
                // inputs of three text fields unwrapped. added by: Masoud Heydari  12 NOV 2018  09:36 AM
                if !userName.isEmpty && !fullName.isEmpty && !password.isEmpty {
                    // all three text fields are blanck, tell user to fill theme but not validate yet. added by: Masoud Heyadri  12 NOV 2018  09:39 AM
                    
                    // validate inputs of text fields. added by: Masoud Heydari  12 NOV 2018 09:56 AM
                    let boolsDic = validateInputOfTextFields(textFields: [self.fullNameTextField, self.userNameTextField, self.passwordTextField])
                    
                    if boolsDic[self.tfFullName]! && boolsDic[self.tfUserName]! && boolsDic[self.tfPassword]! {
                        // ( in register mode ) all text fields are fill and also have valid input but you must check internet connection befor register proccess , added by: Masoud Heydari  12 NOV 2018  09:58 AM
                        
                        // check internet connection
                        if Utils.checkInternetConnection() {
                            // all things is ready for registeration proccess. added by:  Masoud Heydari  12 NOV 2018   11:24  AM
                            APIService.shared.registerNewUser(fullName: fullName, userName: userName, password: password){ [weak self] (response) in
                                if let json = response as? JSON {
                                    
                                    self?.makeDefualtToast(string: json["response"].string!, completion: { (didTap) in
                                        if json[Const.API.isSuccessful].bool ?? false {
                                            self?.navigationController?.popViewController(animated: true)
                                            self?.clearTextOfTextFields()
                                        }
                                    })
                                }
                            }
                            
                        } else {
                            // all things is ready for registeration proccess, but there is no internet connection.   added by: Masoud Heydari   12 NOV 2018   11:28  AM
                            self.makeDefualtToast(string: Const.Toast.checkInternetConnection)
                        }
                    }
                    else {
                        // one of text fields is not valid input, added by: Masoud Heydari 12 NOV 2018  09:58  AM
                        self.makeDefualtToast(string: Const.Toast.shortCharacter)
                    }
                } else {
                    // ( in register mode ) some of text fields is blanck, tell user to fill them. added by: Masoud Heydari. 12 NOV 2018   10:08  AM
                    self.makeDefualtToast(string: Const.Toast.fillInTheBlank)
                }
            }
        }
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
    
    func makeDefualtToast(string: String, duration: TimeInterval = 1.0, completion: ((_ didTap: Bool) -> Void)? = nil) {
        var style = ToastStyle()
        ToastManager.shared.position = .bottom
        style.verticalPadding = 10
        style.bottomMargin = 50
        ToastManager.shared.style = style
        ToastManager.shared.duration = duration
        if completion == nil {
            self.view.makeToast(string, style: style)
        } else {
            self.view.makeToast(string, style: style) { (didTap) in
                completion!(didTap)
            }
        }
    }
    
    
}

/* ===================================================================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* =================== *   TEXT FIELD EXTENSION  * ===================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* ===================================================================== */

extension LoginAndRegisterViewController: UITextFieldDelegate {
    
    private func addObservers() {
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
    
    func validateTextFields(textFields: [UITextField]) {
        for textField in textFields {
            if let text = textField.text {
                if text.isEmpty {
                    textField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
                    textField.backgroundColor =  UIColor.darkRedLight.withAlphaComponent(0.2)
                }
            }
        }
    }
    
    func validateInputOfTextFields(textFields: [UITextField]) -> [String : Bool] {
        var boolsDic = [
            self.tfUserName : true,
            self.tfPassword : true,
            self.tfFullName : true
        ]
        
        for textField in textFields {
            switch textField {
            case userNameTextField:
                let text = userNameTextField.text
                if text?.count ?? 0 < 5 {
                    boolsDic[self.tfUserName] = false
                    userNameTextField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
                    userNameTextField.backgroundColor =  UIColor.darkRedLight.withAlphaComponent(0.2)
                }
                
            case passwordTextField:
                let text = passwordTextField.text
                
                if (text?.count)! < 5 {
                    boolsDic[self.tfPassword] = false
                    passwordTextField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
                    passwordTextField.backgroundColor =  UIColor.darkRedLight.withAlphaComponent(0.2)
                }
                
            case fullNameTextField:
                let text = fullNameTextField.text
                
                if (text?.count)! < 5 {
                    boolsDic[self.tfFullName] = false
                    fullNameTextField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
                    fullNameTextField.backgroundColor =  UIColor.darkRedLight.withAlphaComponent(0.2)
                }
            default: break
                
            }
        }
        
        return boolsDic
    }
    
    private func resetTextFields(){
        // change back color of border color an background color of textfields, added by: Masoud Heydari  12 NOV 2018 AM
        
        //        self.userNameTextField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
        self.userNameTextField.backgroundColor = UIColor.darkRedLight.withAlphaComponent(0.2)
        
        self.passwordTextField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
        self.passwordTextField.backgroundColor = UIColor.darkRedLight.withAlphaComponent(0.2)
        
        self.fullNameTextField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
        self.fullNameTextField.backgroundColor = UIColor.darkRedLight.withAlphaComponent(0.2)
        
        clearTextOfTextFields()
    }
    
    private func clearTextOfTextFields() {
        // clear input text of text field, added by: Masoud Heydari  12 NOV 2018 AM  11:47  AM
        self.fullNameTextField.text = ""
        self.passwordTextField.text = ""
        self.userNameTextField.text = ""
    }
}

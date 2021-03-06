//
//  NewTabController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class ProfileTabController: UIViewController {
    
    let btnLogin: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(Const.BtnTitle.login, for: .normal)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnLoginTapped(_:)), for: .touchUpInside)
        btn.setBackgroundColor(color: .darkRedLight, forState: .normal)
        btn.setBackgroundColor(color: .darkRedDark, forState: .highlighted)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 0
        return btn
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Const.Pages.ProfilePage.loginToAccount
        label.numberOfLines = 2
        label.textColor = UIColor.Gray.textGrayDark
        return label
    }()
    
    let btnMyAdvertisings: UIButton = {
        let btn = UIButton(type: .custom)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.contentHorizontalAlignment = .right
        btn.contentVerticalAlignment = .center
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 15)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        btn.setTitleColor(UIColor.Gray.textGrayDark, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage.resizeImage(image: UIImage(named: Const.Image.userProfileSolid), targetSize: CGSize(width: 25, height: 25)), for: .normal)
        btn.setTitle(Const.Pages.ProfilePage.myAdvertisings, for: .normal)
        btn.setBackgroundColor(color: UIColor.Gray.light1, forState: .highlighted)
        btn.addTarget(self, action: #selector(btnMyAdvertisingsTapped(_ :)), for: .touchUpInside)
        return btn
    }()
    
    let btnFavAdertisings: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Const.Pages.ProfilePage.favAdvertisings, for: .normal)
        btn.setTitleColor(UIColor.Gray.textGrayDark, for: .normal)
        btn.setImage(UIImage.resizeImage(image: UIImage(named: Const.Image.favorite), targetSize: CGSize(width: 25, height: 25)), for: .normal)
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .right
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 15)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setBackgroundColor(color: UIColor.Gray.light1, forState: .highlighted)
        btn.addTarget(self, action: #selector(btnFavAdertisingsTapped(_ :)), for: .touchUpInside)
        return btn
    }()
    
    let divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Gray.light1
        return view
    }()
    
    let btnAboutDivar: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Const.Pages.ProfilePage.aboutDivar, for: .normal)
        btn.setTitleColor(UIColor.Gray.textGrayDark, for: .normal)
        btn.setImage(UIImage.resizeImage(image: UIImage(named: Const.Image.aboutDivar), targetSize: CGSize(width: 25, height: 25)), for: .normal)
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .right
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 15)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setBackgroundColor(color: UIColor.Gray.light1, forState: .highlighted)
        btn.addTarget(self, action: #selector(btnAboutDivarTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    let btnAboutUs: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Const.Pages.ProfilePage.aboutUs, for: .normal)
        btn.setTitleColor(UIColor.Gray.textGrayDark, for: .normal)
        btn.setImage(UIImage.resizeImage(image: UIImage(named: Const.Image.aboutUs), targetSize: CGSize(width: 25, height: 25)), for: .normal)
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .right
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 15)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setBackgroundColor(color: UIColor.Gray.light1, forState: .highlighted)
        btn.addTarget(self, action: #selector(btnAboutUsTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(btnLogin)
        view.addSubview(loginLabel)
        view.addSubview(btnMyAdvertisings)
        view.addSubview(btnFavAdertisings)
        view.addSubview(divider1)
        view.addSubview(btnAboutDivar)
        view.addSubview(btnAboutUs)
        
        btnLogin.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        btnLogin.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnLogin.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 12/40).isActive = true
        
        loginLabel.leftAnchor.constraint(equalTo: self.btnLogin.rightAnchor, constant: 12).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        loginLabel.topAnchor.constraint(equalTo: self.btnLogin.topAnchor, constant: 4).isActive = true
        
        btnMyAdvertisings.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        btnMyAdvertisings.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        btnMyAdvertisings.topAnchor.constraint(equalTo: self.btnLogin.bottomAnchor, constant: 8).isActive = true
        btnMyAdvertisings.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        btnFavAdertisings.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        btnFavAdertisings.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        btnFavAdertisings.topAnchor.constraint(equalTo: self.btnMyAdvertisings.bottomAnchor, constant: 4).isActive = true
        btnFavAdertisings.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        divider1.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        divider1.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        divider1.topAnchor.constraint(equalTo: self.btnFavAdertisings.bottomAnchor, constant: 4).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        btnAboutDivar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        btnAboutDivar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        btnAboutDivar.topAnchor.constraint(equalTo: self.divider1.bottomAnchor, constant: 4).isActive = true
        btnAboutDivar.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        btnAboutUs.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        btnAboutUs.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -12).isActive = true
        btnAboutUs.topAnchor.constraint(equalTo: self.btnAboutDivar.bottomAnchor, constant: 4).isActive = true
        btnAboutUs.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
    }
    
    private func setupNavBar(){
        navigationItem.title = Const.NavTitle.myProfile
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Const.empty, style: .plain, target: self, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("profile appeard!")
        changeBtnLogginTitle()
        changeLoginLabelTitle()
    }
    
    @objc private func btnLoginTapped(_ sender: UIButton){
        print("btn login tapped!")
        if let title = sender.titleLabel?.text {
            if title == Const.BtnTitle.login {
                navigationController?.pushViewController(LoginAndRegisterViewController(), animated: true)
                
            }else if title == Const.BtnTitle.logout {
                KeychainWrapper.standard.removeObject(forKey: Const.API.isLoggedIn)
                changeBtnLogginTitle()
                changeLoginLabelTitle()
            }
        }
    }
    
    private func changeBtnLogginTitle(){
        print("API: \(APIService.shared.isLoggedIn())")
        if APIService.shared.isLoggedIn() {
            btnLogin.setTitle(Const.BtnTitle.logout, for: .normal)
        } else {
            btnLogin.setTitle(Const.BtnTitle.login, for: .normal)
        }
    }
    
    private func changeLoginLabelTitle(){
        if APIService.shared.isLoggedIn() {
            loginLabel.text = Const.Pages.ProfilePage.welcomeUser
        } else {
            loginLabel.text = Const.Pages.ProfilePage.loginToAccount
            
        }
    }
    
    @objc private func btnMyAdvertisingsTapped(_ sender: UIButton) {
        print("btn my advertisings tapped!")
        // check wheaser user already registered/logged in or not.   added by: Masoud Heydari  15 NOV 2018  08:54  AM
        if APIService.shared.isLoggedIn() {
            navigationController?.pushViewController(MyAdvertisingsViewController(), animated: true)
        }else {
            // user not loggin or registered. added by: Masoud Heydari  15 NOV 2018  08:55 AM
            self.makeDefualtToast(string: Const.Toast.notLoggedIn)
        }
    }
    
    @objc private func btnFavAdertisingsTapped(_ sender: UIButton) {
        print("btn favorite advertisings tapped!")
        // check wheather user already logged in or not. added by: Masoud Heydari 15 NOV 2018   08:52
        if APIService.shared.isLoggedIn() {
            let layout = UICollectionViewFlowLayout()
            navigationController?.pushViewController(MyFavAdvertisingsViewController(collectionViewLayout: layout), animated: true)
            
        }else {
            // user not logged in, tell it to user. added by: Masoud heydari  15 NOV 2018   08:53   AM
            self.makeDefualtToast(string: Const.Toast.notLoggedIn)
        }
    }
    
    @objc private func btnAboutDivarTapped(_ sender: UIButton) {
        print("btn about divar tapped!")
        navigationController?.pushViewController(AboutDivarViewController(), animated: true)
    }
    
    @objc private func btnAboutUsTapped(_ sender: UIButton) {
        print("btn about us tapped!")
        navigationController?.pushViewController(AboutUsViewController(), animated: true)
    }
    
    func makeDefualtToast(string: String, duration: TimeInterval = 1.0) {
        var style = ToastStyle()
        ToastManager.shared.position = .bottom
        style.verticalPadding = 10
        style.bottomMargin = 100
        ToastManager.shared.style = style
        ToastManager.shared.duration = duration
        self.view.makeToast(string, style: style)
    }
    
    
}

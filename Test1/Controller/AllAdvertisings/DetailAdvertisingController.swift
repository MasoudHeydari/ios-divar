//
//  DetailViewController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

let darkRedLight = UIColor(red: 153/255, green: 49/255, blue: 44/255, alpha: 1/10)
let darkRed = UIColor(red: 153/255, green: 49/255, blue: 44/255, alpha: 1)

class DetailAdvertisingController: UIViewController {
    
    public var advertisingId: UInt?
    
    private var detailsOfAdvertising: DetailAdvertisingModel? {
        didSet {
            if let detailsOfAdvertising = detailsOfAdvertising {
                if let isFavorite = detailsOfAdvertising.isFavorite {
                    
                    print("is liked: \(isFavorite)")
                    if isFavorite {
                        let img = UIImage(named: Const.Image.favoriteBorder)
                        self.btnFavorite.setImage(img, for: .normal)
                        
                    }
                }
                self.advertisingTitleLabel.text = detailsOfAdvertising.title
                self.advertisinDescriptionLabel.text = detailsOfAdvertising.description
                self.timeLabel.text = detailsOfAdvertising.date
                self.location.text = detailsOfAdvertising.location
                self.price.text = detailsOfAdvertising.price
            }
        }
    }
    
    private var isFavorite = false
    private var allViews = [UIView]()
    private var mainConstraintBottomConstraint = NSLayoutConstraint()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let imageBanner: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = darkRedLight
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let btnFavorite: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: Const.Image.favoriteBorder)
        btn.setImage(img, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(btnFavoriteTapped(_ :)), for: .touchUpInside)
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnShare: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: Const.Image.share)
        btn.setImage(img, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(btnShareTapped(_ :)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnCallToSeller: UIButton = {
        let btn = UIButton()
        btn.setTitle(Const.BtnTitle.callToSeller, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.backgroundColor = darkRed
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(btnCallToSellerTapped(_ :)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let advertisingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Const.Pages.AdvertisingDetails.fakeAdvertisingTitle
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 3/255, green: 3/255, blue: 3/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.backgroundColor = .white
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = Const.Pages.AdvertisingDetails.fakeTime
        label.backgroundColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        label.text = Const.Pages.AdvertisingDetails.location
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = Const.Pages.AdvertisingDetails.fakeLocation
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = Const.Pages.AdvertisingDetails.price
        label.textAlignment = .left
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = Const.Pages.AdvertisingDetails.fakePrice
        label.textAlignment = .right
        return label
    }()
    
    let dividerLine1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 231/255, green: 234/255, blue: 236/255, alpha: 1)
        return view
    }()
    
    let dividerLine2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Gray.dividerBackground
        return view
    }()
    
    let advertisinDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(r: 37, g: 37, b: 37)
        label.backgroundColor = .white
        let text = Const.Pages.AdvertisingDetails.fakeAdvertisingDescription
        
        label.addSpaceBetweenLines(string: text, spacing: 4.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load called")
        setupView()
        addViews()
        addConstraints()
        
        // get detail of advertising
        // added by: Masoud Heydari.    10 NOV 2018   11:24 AM
        self.getDetailsOfAdvertising()
        
    }
    
    private func getDetailsOfAdvertising() {
        if Utils.checkInternetConnection() {
            // unwrap the advertising_id
            // added by Masoud Heydari.   10 NOV 2018  09:33  AM
            print(1)
            if let advertisingId = self.advertisingId {
                print(2)
                // check if user is logged in or not.
                // added by Masou heydari.   10 NOV 2018   09:36  AM
                if APIService.shared.isLoggedIn() {
                    print(3)
                    // all thing ready to load details of advertising from server.
                    // added by Masoud Heydari.   10 NOV 2018   09:34
                    if let userId = KeychainWrapper.standard.integer(forKey: Const.API.userId) {
                        print(4)
                        // user is logged in and advertising id is not nil, it's time to get data from dserver. Let's dive into it :)
                        // added by: Masoud Heydari.    10 NOV 2018  09:55 AM
                        APIService.shared.getDetailsOfAdvertisingByUserId(advertisingId: advertisingId, userId: UInt(userId)) { (done, detailsOfAdvertising) in
                            if done {
                                print(5)
                                // server is available and response recived.
                                // added by: Masoud Heydari   10 NOV 2018   10:06  AM
                                self.detailsOfAdvertising = detailsOfAdvertising
                                print(detailsOfAdvertising)
                            }
                        }
                    }
                    
                } else {
                    // user not logged in and we have no any user_id from this user, this user is unknown for us.
                    // added by Masoud Heydari.   10 NOV 2018  09:48  AM
                    APIService.shared.getDetailsOfAdvertising(advertisingId: advertisingId) { (done, detailsOfAdvertising) in
                        if done {
                            // server is available and response is recived.
                            // added by Masoud Heydari.    10 NOV 2018   10:13  AM
                            self.detailsOfAdvertising = detailsOfAdvertising
                            print(detailsOfAdvertising)
                            
                        }
                    }
                }
            }
            
        } else {
            // there no internet connection , make a toast and this to user and her connection to internet
            // added by Masoud Heydari.   10 NOV 2018  09:31  AM
            self.view.makeToast(Const.Toast.checkInternetConnection)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .yellow
        navigationItem.title = Const.NavTitle.AdvertisingDetails
    }
    
    @objc private func btnFavoriteTapped(_ sender: UIButton){
        print("btn fav tapped!")
        if APIService.shared.isLoggedIn() {
            //user already logged in.
            // added by Masoud Heydari.  8 NOV 2018  9:21 PM
            if let advertisingId = advertisingId, let userId = KeychainWrapper.standard.integer(forKey: Const.API.userId) {
                APIService.shared.likeAdvertising(advertisingId: advertisingId, userId: UInt(userId)) { (done, response) in
                    if done {
                        if let response = response {
                            self.makeDefualtToast(string: response)
                            self.isFavorite = !self.isFavorite
                            print(self.isFavorite)
                            if self.isFavorite {
                                sender.setImage(UIImage(named: Const.Image.favorite), for: .normal)
                                sender.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                            }else {
                                sender.setImage(UIImage(named: Const.Image.favoriteBorder), for: .normal)
                                sender.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                            }
                        }
                    }
                }
            }
            
        } else {
            // user not logged in or registered. tell user 'you must loggin or register to be able to like a advertising'.
            //  added by: Masoud Heydari.    8 NOV 2018  9:21 PM
            
            self.makeDefualtToast(string: Const.Pages.AdvertisingDetails.youNotLoggedIn)
        }
        
        
    }
    
    @objc private func btnShareTapped(_ sender: UIButton){
        print("btn share tapped!")
    }
    
    @objc private func btnCallToSellerTapped(_ sender: UIButton){
        print("btn call to seller tapped!")
        // unwrap phone number
        // added by; Masoud Heydari.   10 NOV 2018   10:50 AM
        if let phoneNum = self.detailsOfAdvertising?.phoneNumber {
            // call to celler with given phone number
            // added by: Masoud Heydari.    10 NOV 2018   10:54  AM
            Utils.callToPhoneNumber(phoneNumber: phoneNum)
        } else {
            // the phone number is not available, tell it to user that there is a problem.
            // added by: Masoud Heydari.    10 NOV 2018   10:55  AM
            self.makeDefualtToast(string: Const.Toast.thereIsProblem)
        }
    }
}


/* =================================================================== */
/* ===================== * * * * * * * * * * * * ===================== */
/* ===================== *    MAIN EXTENSION   * ===================== */
/* ===================== * * * * * * * * * * * * ===================== */
/* =================================================================== */
extension DetailAdvertisingController {
    
    private func addViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(mainContainer)
        
        mainContainer.addSubview(imageBanner)
        mainContainer.addSubview(btnFavorite)
        mainContainer.addSubview(btnShare)
        mainContainer.addSubview(btnCallToSeller)
        mainContainer.addSubview(advertisingTitleLabel)
        mainContainer.addSubview(timeLabel)
        mainContainer.addSubview(locationLabel)
        mainContainer.addSubview(dividerLine1)
        mainContainer.addSubview(dividerLine2)
        mainContainer.addSubview(advertisinDescriptionLabel)
        
        mainContainer.addSubview(location)
        mainContainer.addSubview(priceLabel)
        mainContainer.addSubview(price)
    }
    
    private func addConstraints() {
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainContainer.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        mainContainer.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        mainConstraintBottomConstraint = mainContainer.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -(tabBarController?.tabBar.frame.height)!)
        mainConstraintBottomConstraint.isActive = true
        
        imageBanner.leftAnchor.constraint(equalTo: mainContainer.leftAnchor).isActive = true
        imageBanner.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        imageBanner.widthAnchor.constraint(equalTo: mainContainer.widthAnchor).isActive = true
        imageBanner.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        btnFavorite.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        btnFavorite.topAnchor.constraint(equalTo: self.imageBanner.bottomAnchor, constant: 16).isActive = true
        btnFavorite.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnFavorite.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        btnShare.leftAnchor.constraint(equalTo: self.btnFavorite.rightAnchor).isActive = true
        btnShare.topAnchor.constraint(equalTo: self.btnFavorite.topAnchor).isActive = true
        btnShare.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnShare.heightAnchor.constraint(equalTo: self.btnFavorite.heightAnchor).isActive = true
        
        btnCallToSeller.leftAnchor.constraint(equalTo: self.btnShare.rightAnchor, constant: 12).isActive = true
        btnCallToSeller.topAnchor.constraint(equalTo: self.btnFavorite.topAnchor).isActive = true
        btnCallToSeller.rightAnchor.constraint(equalTo: imageBanner.rightAnchor, constant: -16).isActive = true
        btnCallToSeller.heightAnchor.constraint(equalTo: self.btnFavorite.heightAnchor).isActive = true
        
        advertisingTitleLabel.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        advertisingTitleLabel.topAnchor.constraint(equalTo: self.btnFavorite.bottomAnchor, constant: 12).isActive = true
        advertisingTitleLabel.rightAnchor.constraint(equalTo: self.btnCallToSeller.rightAnchor).isActive = true
        
        timeLabel.leftAnchor.constraint(equalTo: self.advertisingTitleLabel.leftAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.advertisingTitleLabel.bottomAnchor, constant: 8).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: self.advertisingTitleLabel.rightAnchor).isActive = true
        
        dividerLine1.leftAnchor.constraint(equalTo: self.advertisingTitleLabel.leftAnchor).isActive = true
        dividerLine1.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8).isActive = true
        dividerLine1.rightAnchor.constraint(equalTo: self.advertisingTitleLabel.rightAnchor).isActive = true
        dividerLine1.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        locationLabel.rightAnchor.constraint(equalTo: self.advertisingTitleLabel.rightAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: self.dividerLine1.bottomAnchor, constant: 8).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        location.leftAnchor.constraint(equalTo: self.advertisingTitleLabel.leftAnchor).isActive = true
        location.rightAnchor.constraint(equalTo: self.locationLabel.leftAnchor, constant: -12).isActive = true
        location.topAnchor.constraint(equalTo: self.dividerLine1.bottomAnchor, constant: 8).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.locationLabel.rightAnchor).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.locationLabel.leftAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 8).isActive = true
        
        price.rightAnchor.constraint(equalTo: self.location.rightAnchor).isActive = true
        price.leftAnchor.constraint(equalTo: self.location.leftAnchor).isActive = true
        price.topAnchor.constraint(equalTo: self.priceLabel.topAnchor).isActive = true
        
        dividerLine2.leftAnchor.constraint(equalTo: self.advertisingTitleLabel.leftAnchor).isActive = true
        dividerLine2.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 8).isActive = true
        dividerLine2.rightAnchor.constraint(equalTo: self.advertisingTitleLabel.rightAnchor).isActive = true
        dividerLine2.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        advertisinDescriptionLabel.leftAnchor.constraint(equalTo: self.advertisingTitleLabel.leftAnchor).isActive = true
        advertisinDescriptionLabel.rightAnchor.constraint(equalTo: self.advertisingTitleLabel.rightAnchor).isActive = true
        advertisinDescriptionLabel.topAnchor.constraint(equalTo: self.dividerLine2.bottomAnchor, constant: 8).isActive = true
        advertisinDescriptionLabel.bottomAnchor.constraint(equalTo: self.mainContainer.bottomAnchor).isActive = true
    }
    
    func makeDefualtToast(string: String) {
        var style = ToastStyle()
        ToastManager.shared.position = .bottom
        style.verticalPadding = 10
        style.bottomMargin = 100
        ToastManager.shared.style = style
        ToastManager.shared.duration = 1.0
        self.view.makeToast(string, style: style)
    }
}

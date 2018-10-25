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
    
    //    private let data =
    
    private var isFavorite = false
    private var allViews = [UIView]()
    
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
        btn.setTitle("تماس با فروشنده", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.backgroundColor = darkRed
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(btnCallToSellerTapped(_ :)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let stackViewBtns: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let advertisingLabel: UILabel = {
        let label = UILabel()
        label.text = "فروش ویلای شمال (نقد - اقساط) یا معاوضه با آپارتمان برای مشاوره با کادر مجرب ما میتوانید با یکی از شماره یزر تماس بگیرید مشاور املاک حیدری"
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
        label.text = "دقایقی پیش"
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
        label.text = "محل: "
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "تهران جنت آباد مرکزی"
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
        label.text = "قیمت: "
        label.textAlignment = .left
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "۷۲۰۰۰۰۰۰۰ تومان"
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
        label.textColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1)
        label.backgroundColor = .white
        let text = "سیبانه یک استاندارد جدید برای استفاده از پیشرفته ترین اسمارت فون جهان تعریف کرده است. این استاندارد جدید باعث شده است که کاربران ایرانی توانایی بیشتری برای استفاده از محصولات اپل داشته باشند. سیبانه اپ استور اپل را بصورت هوشمندانه و براساس نیازهای کاربران ایرانی بازطراحی کرده و در قالب اپ استور ایرانی نرم افزارهای اورجینال iOS در اختیار کاربران ایرانی قرار داده است."
        
        label.addSpaceBetweenLines(string: text, spacing: 4.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageBanner)
        scrollView.addSubview(stackViewBtns)
        stackViewBtns.addSubview(btnFavorite)
        stackViewBtns.addSubview(btnShare)
        stackViewBtns.addSubview(btnCallToSeller)
        scrollView.addSubview(advertisingLabel)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(dividerLine1)
        scrollView.addSubview(dividerLine2)
        scrollView.addSubview(advertisinDescriptionLabel)
        
        scrollView.addSubview(location)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(price)
        
        
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageBanner.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        imageBanner.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageBanner.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageBanner.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        
        stackViewBtns.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25).isActive = true
        stackViewBtns.topAnchor.constraint(equalTo: self.imageBanner.bottomAnchor, constant: 16).isActive = true
        stackViewBtns.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        stackViewBtns.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        btnFavorite.leftAnchor.constraint(equalTo: self.stackViewBtns.leftAnchor).isActive = true
        btnFavorite.topAnchor.constraint(equalTo: self.stackViewBtns.topAnchor).isActive = true
        btnFavorite.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnFavorite.heightAnchor.constraint(equalTo: self.stackViewBtns.heightAnchor).isActive = true
        
        btnShare.leftAnchor.constraint(equalTo: self.btnFavorite.rightAnchor).isActive = true
        btnShare.topAnchor.constraint(equalTo: self.stackViewBtns.topAnchor).isActive = true
        btnShare.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btnShare.heightAnchor.constraint(equalTo: self.stackViewBtns.heightAnchor).isActive = true
        
        btnCallToSeller.rightAnchor.constraint(equalTo: stackViewBtns.rightAnchor).isActive = true
        btnCallToSeller.topAnchor.constraint(equalTo: self.stackViewBtns.topAnchor).isActive = true
        btnCallToSeller.leftAnchor.constraint(equalTo: self.btnShare.rightAnchor, constant: 12).isActive = true
        btnCallToSeller.heightAnchor.constraint(equalTo: self.stackViewBtns.heightAnchor).isActive = true
        
        advertisingLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        advertisingLabel.topAnchor.constraint(equalTo: self.stackViewBtns.bottomAnchor, constant: 12).isActive = true
        advertisingLabel.rightAnchor.constraint(equalTo: self.btnCallToSeller.rightAnchor).isActive = true
        
        timeLabel.leftAnchor.constraint(equalTo: self.advertisingLabel.leftAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.advertisingLabel.bottomAnchor, constant: 8).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: self.advertisingLabel.rightAnchor).isActive = true
        
        dividerLine1.leftAnchor.constraint(equalTo: self.advertisingLabel.leftAnchor).isActive = true
        dividerLine1.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8).isActive = true
        dividerLine1.rightAnchor.constraint(equalTo: self.advertisingLabel.rightAnchor).isActive = true
        dividerLine1.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        locationLabel.rightAnchor.constraint(equalTo: self.advertisingLabel.rightAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: self.dividerLine1.bottomAnchor, constant: 8).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1/3).isActive = true
        
        location.leftAnchor.constraint(equalTo: self.advertisingLabel.leftAnchor).isActive = true
        location.rightAnchor.constraint(equalTo: self.locationLabel.leftAnchor, constant: -12).isActive = true
        location.topAnchor.constraint(equalTo: self.dividerLine1.bottomAnchor, constant: 8).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.locationLabel.rightAnchor).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.locationLabel.leftAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 8).isActive = true
        
        price.rightAnchor.constraint(equalTo: self.location.rightAnchor).isActive = true
        price.leftAnchor.constraint(equalTo: self.location.leftAnchor).isActive = true
        price.topAnchor.constraint(equalTo: self.priceLabel.topAnchor).isActive = true
        
        dividerLine2.leftAnchor.constraint(equalTo: self.advertisingLabel.leftAnchor).isActive = true
        dividerLine2.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 8).isActive = true
        dividerLine2.rightAnchor.constraint(equalTo: self.advertisingLabel.rightAnchor).isActive = true
        dividerLine2.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        advertisinDescriptionLabel.leftAnchor.constraint(equalTo: self.advertisingLabel.leftAnchor).isActive = true
        advertisinDescriptionLabel.rightAnchor.constraint(equalTo: self.advertisingLabel.rightAnchor).isActive = true
        advertisinDescriptionLabel.topAnchor.constraint(equalTo: self.dividerLine2.bottomAnchor, constant: 8).isActive = true
        
        addView()
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: UIView.getHeightOfAllViews( self, views: allViews, extraHeight: 65))
        
    }
    
    private func addView(){
        allViews.append(imageBanner)
        allViews.append(btnCallToSeller)
        allViews.append(stackViewBtns)
        allViews.append(advertisingLabel)
        allViews.append(timeLabel)
        allViews.append(locationLabel)
        allViews.append(dividerLine1)
        allViews.append(dividerLine2)
        allViews.append(advertisinDescriptionLabel)
        allViews.append(priceLabel)
    }
    
    private func setupView(){
        view.backgroundColor = .yellow
        navigationItem.title = "جزییات آگهی"
    }
    
    @objc private func btnFavoriteTapped(_ sender: UIButton){
        print("btn fav tapped!")
        isFavorite = !isFavorite
        print(isFavorite)
        if isFavorite {
            sender.setImage(UIImage(named: Const.Image.favorite), for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        }else {
            sender.setImage(UIImage(named: Const.Image.favoriteBorder), for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
    }
    
    @objc private func btnShareTapped(_ sender: UIButton){
        print("btn share tapped!")
    }
    
    @objc private func btnCallToSellerTapped(_ sender: UIButton){
        print("btn call to seller tapped!")
        Utils.callToPhoneNumber(phoneNumber: "09195474883")
        
    }
}

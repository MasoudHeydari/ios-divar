//
//  NewAdvertisingController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class NewAdvertisingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    let viewTapRecognizer = UITapGestureRecognizer()
    var scrollViewOffSet: CGFloat = 0
    
    let extraHeight: CGFloat = 180
    let imgCell = "image_cell"
    let imgEmptyCell = "image_empty_cell"
    
    var imageCollectionViewHeightConstraint = NSLayoutConstraint()
    var imageList: [UIImage] = [UIImage()]
    var allViews = [UIView]()
    
    var isViewDisapear = true
    
    var activeTextField: UITextField!
    
    var mainContainerBottomConstraint = NSLayoutConstraint()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkRedLight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "بخش 'آگهی جدید' بزودی کامل می شود"
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "محل آگهی"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let btnChooseLocation: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("انتخاب محل", for: .normal)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnChooseLocationTapped(_:)), for: .touchUpInside)
        btn.setBackgroundColor(color: .darkRedLight, forState: .normal)
        btn.setBackgroundColor(color: .darkRedDark, forState: .highlighted)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 0
        return btn
    }()
    
    let divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Gray.dividerBackground
        return view
    }()
    
    let imageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        let attributedTitle = NSMutableAttributedString(string: "عکس آگهی", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        let paragraphStyleTitle = NSMutableParagraphStyle()
        paragraphStyleTitle.lineSpacing = 10
        let paragraphRangeTitle = NSRange(location: 0, length: attributedTitle.length)
        paragraphStyleTitle.alignment = .right
        attributedTitle.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyleTitle, range: paragraphRangeTitle)
        
        let attributedDescription = NSMutableAttributedString(string: "\n" + "افزودن عکس، بازدید آگهی شما را تا ۳ برابر افزیش می‌دهد" + "\n" + "حداکثر ۵ عکس انتخاب کنید.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let paragraphStyleDescription = NSMutableParagraphStyle()
        paragraphStyleDescription.alignment = .right
        let paragraphRangeDescription = NSRange(location: 0, length: attributedDescription.length)
        attributedDescription.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyleDescription, range: paragraphRangeDescription)
        
        attributedTitle.append(attributedDescription)
        
        textView.attributedText = attributedTitle
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.sizeToFit()
        return textView
    }()
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    let imageBanner: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let divider2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Gray.dividerBackground
        return view
    }()
    
    let advertisingPhoneNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "شماره تماس"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let phoneNumTextFiled: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.Gray.light0
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.textAlignment = .right
        textField.placeholder = "شماره تماس شما"
        textField.layer.borderWidth = 2
        textField.keyboardType = .asciiCapableNumberPad
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
        textField.font = UIFont.systemFont(ofSize: 14)
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        return textField
    }()
    
    let pricaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "قیمت"
        return label
    }()
    
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
        textField.layer.borderWidth = 2
        textField.backgroundColor = UIColor.Gray.light0
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.keyboardType = .asciiCapableNumberPad
        textField.placeholder = "قیمت (تومان)"
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let advertisingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "عنوان آگهی"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let advertisingTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.Gray.light0
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.keyboardType = .default
        textField.placeholder = "عنوان آگهی خود را بنویسید"
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let divider3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Gray.dividerBackground
        return view
    }()
    
    let advertisingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "توضیحات آگهی"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let advertisingDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.Gray.light0
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.keyboardType = .default
        textField.placeholder = "توضیحات آگهی خود را بنویسید"
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let advertisingDescriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "تمام جزییات و نکات قابل توجه آگهی خود را یه صورت کامل در اینجا ذکر کنید. توجه با این مورد به طور قابل توجهی ابهامات کاربران را برطرف خواهد کرد و شانس موفقیت آگهی شما را افزایش می‌دهد."
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 10
        label.textColor = UIColor.gray
        label.sizeToFit()
        return label
    }()
    
    let btnRegisterAdvertising: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.darkRedLight
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 6
        btn.setTitle("ثبت آگهی", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(btnRegisterAdTapped(_ :)), for: .touchUpInside)
        btn.setBackgroundColor(color: UIColor.darkRedLight, forState: .normal)
        btn.setBackgroundColor(color: UIColor.darkRedDark, forState: .highlighted)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 0
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        setupImageCollectionView()
        addObserverToViewGustureRecognizer()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addObserverToViewGustureRecognizer(){
        let notifier = NotificationCenter.default
        notifier.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        notifier.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
    func setupViews() {
        view.backgroundColor = .red
        view.addSubview(scrollView)
        
        scrollView.addSubview(mainContainer)
        
        mainContainer.addSubview(locationLabel)
        mainContainer.addSubview(btnChooseLocation)
        mainContainer.addSubview(divider1)
        mainContainer.addSubview(imageTextView)
        mainContainer.addSubview(imageCollectionView)
        mainContainer.addSubview(divider2)
        mainContainer.addSubview(advertisingPhoneNumLabel)
        mainContainer.addSubview(phoneNumTextFiled)
        mainContainer.addSubview(pricaLabel)
        mainContainer.addSubview(priceTextField)
        mainContainer.addSubview(advertisingTitleLabel)
        mainContainer.addSubview(advertisingTitleTextField)
        mainContainer.addSubview(divider3)
        mainContainer.addSubview(advertisingDescriptionLabel)
        mainContainer.addSubview(advertisingDescriptionTextField)
        mainContainer.addSubview(btnRegisterAdvertising)
        mainContainer.addSubview(advertisingDescriptionText)
        
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        mainContainer.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        mainContainer.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        mainContainerBottomConstraint = mainContainer.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -(tabBarController?.tabBar.frame.height)!)
        mainContainerBottomConstraint.isActive = true
        
        locationLabel.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        locationLabel.topAnchor.constraint(equalTo: self.mainContainer.topAnchor, constant: 8).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor, constant: -24).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        btnChooseLocation.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 8).isActive = true
        btnChooseLocation.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        btnChooseLocation.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor, multiplier: 16/40).isActive = true
        btnChooseLocation.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        divider1.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        divider1.topAnchor.constraint(equalTo: self.btnChooseLocation.bottomAnchor, constant: 8).isActive = true
        divider1.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor, constant: -24).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        imageTextView.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        imageTextView.topAnchor.constraint(equalTo: self.divider1.bottomAnchor, constant: 8).isActive = true
        imageTextView.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor, constant: -24).isActive = true
        imageTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        imageCollectionView.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor).isActive = true
        imageCollectionView.topAnchor.constraint(equalTo: self.imageTextView.bottomAnchor, constant: 1).isActive = true
        imageCollectionView.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor).isActive = true
        imageCollectionViewHeightConstraint = imageCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        NSLayoutConstraint.activate([self.imageCollectionViewHeightConstraint])
        reloadImageCollectionView()
        
        divider2.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        divider2.topAnchor.constraint(equalTo: self.imageCollectionView.bottomAnchor, constant: 8).isActive = true
        divider2.widthAnchor.constraint(equalTo: self.mainContainer.widthAnchor, constant: -24).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        advertisingPhoneNumLabel.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        advertisingPhoneNumLabel.topAnchor.constraint(equalTo: self.divider2.bottomAnchor, constant: 8).isActive = true
        advertisingPhoneNumLabel.rightAnchor.constraint(equalTo: self.divider2.rightAnchor).isActive = true
        advertisingPhoneNumLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        phoneNumTextFiled.leftAnchor.constraint(equalTo: self.mainContainer.leftAnchor, constant: 12).isActive = true
        phoneNumTextFiled.topAnchor.constraint(equalTo: self.advertisingPhoneNumLabel.bottomAnchor).isActive = true
        phoneNumTextFiled.rightAnchor.constraint(equalTo: self.divider2.rightAnchor).isActive = true
        phoneNumTextFiled.heightAnchor.constraint(equalToConstant: 45).isActive = true
        phoneNumTextFiled.delegate = self
        
        pricaLabel.leftAnchor.constraint(equalTo: self.divider2.leftAnchor).isActive = true
        pricaLabel.rightAnchor.constraint(equalTo: self.divider2.rightAnchor).isActive = true
        pricaLabel.topAnchor.constraint(equalTo: self.phoneNumTextFiled.bottomAnchor, constant: 8).isActive = true
        pricaLabel.heightAnchor.constraint(equalTo: self.advertisingPhoneNumLabel.heightAnchor).isActive = true
        
        priceTextField.leftAnchor.constraint(equalTo: self.phoneNumTextFiled.leftAnchor).isActive = true
        priceTextField.rightAnchor.constraint(equalTo: self.phoneNumTextFiled.rightAnchor).isActive = true
        priceTextField.topAnchor.constraint(equalTo: self.pricaLabel.bottomAnchor).isActive = true
        priceTextField.heightAnchor.constraint(equalTo: self.phoneNumTextFiled.heightAnchor).isActive = true
        priceTextField.delegate = self
        
        divider3.leftAnchor.constraint(equalTo: self.divider2.leftAnchor).isActive = true
        divider3.topAnchor.constraint(equalTo: self.priceTextField.bottomAnchor, constant: 16).isActive = true
        divider3.rightAnchor.constraint(equalTo: self.divider2.rightAnchor).isActive = true
        divider3.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        advertisingTitleLabel.rightAnchor.constraint(equalTo: self.pricaLabel.rightAnchor).isActive = true
        advertisingTitleLabel.leftAnchor.constraint(equalTo: self.pricaLabel.leftAnchor).isActive = true
        advertisingTitleLabel.topAnchor.constraint(equalTo: self.divider3.bottomAnchor, constant: 10).isActive = true
        advertisingTitleLabel.heightAnchor.constraint(equalTo: self.pricaLabel.heightAnchor).isActive = true
        
        advertisingTitleTextField.topAnchor.constraint(equalTo: self.advertisingTitleLabel.bottomAnchor).isActive = true
        advertisingTitleTextField.leftAnchor.constraint(equalTo: self.priceTextField.leftAnchor).isActive = true
        advertisingTitleTextField.rightAnchor.constraint(equalTo: self.priceTextField.rightAnchor).isActive = true
        advertisingTitleTextField.heightAnchor.constraint(equalTo: self.priceTextField.heightAnchor).isActive = true
        advertisingTitleTextField.delegate = self
        
        advertisingDescriptionLabel.rightAnchor.constraint(equalTo: self.pricaLabel.rightAnchor).isActive = true
        advertisingDescriptionLabel.leftAnchor.constraint(equalTo: self.pricaLabel.leftAnchor).isActive = true
        advertisingDescriptionLabel.topAnchor.constraint(equalTo: self.advertisingTitleTextField.bottomAnchor, constant: 8).isActive = true
        advertisingDescriptionLabel.heightAnchor.constraint(equalTo: self.pricaLabel.heightAnchor).isActive = true
        
        advertisingDescriptionTextField.topAnchor.constraint(equalTo: self.advertisingDescriptionLabel.bottomAnchor).isActive = true
        advertisingDescriptionTextField.leftAnchor.constraint(equalTo: self.priceTextField.leftAnchor).isActive = true
        advertisingDescriptionTextField.rightAnchor.constraint(equalTo: self.priceTextField.rightAnchor).isActive = true
        advertisingDescriptionTextField.heightAnchor.constraint(equalTo: self.priceTextField.heightAnchor).isActive = true
        advertisingDescriptionTextField.delegate = self
        
        advertisingDescriptionText.rightAnchor.constraint(equalTo: self.pricaLabel.rightAnchor, constant: -8).isActive = true
        advertisingDescriptionText.leftAnchor.constraint(equalTo: self.pricaLabel.leftAnchor, constant: 8).isActive = true
        advertisingDescriptionText.topAnchor.constraint(equalTo: self.advertisingDescriptionTextField.bottomAnchor, constant: 14).isActive = true
        
        btnRegisterAdvertising.rightAnchor.constraint(equalTo: self.pricaLabel.rightAnchor).isActive = true
        btnRegisterAdvertising.leftAnchor.constraint(equalTo: self.pricaLabel.leftAnchor).isActive = true
        btnRegisterAdvertising.topAnchor.constraint(equalTo: self.advertisingDescriptionText.bottomAnchor, constant: 20).isActive = true
        btnRegisterAdvertising.heightAnchor.constraint(equalTo: self.pricaLabel.heightAnchor).isActive = true
        
        btnRegisterAdvertising.bottomAnchor.constraint(equalTo: self.mainContainer.bottomAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        reloadImageCollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isViewDisapear && imageList.count >= 2 {
            let lastIndexOfImageList = imageList.count - 1
            let range = 1...lastIndexOfImageList
            imageList.removeSubrange(range)
            reloadImageCollectionView()
            clearTextOfTextFields()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isViewDisapear = true
    }
    
    @objc func didTapView(){
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkRedLight.cgColor
    }
    
    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        self.view.removeGestureRecognizer(viewTapRecognizer)
    }
    
    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        viewTapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(viewTapRecognizer)
    }
}

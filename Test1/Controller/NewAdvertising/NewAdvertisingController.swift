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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        setupImageCollectionView()
        addObserverToViewGustureRecognizer()
    }
    
    func setupViews() {
        view.backgroundColor = .red
        addViews()
        addConstraints()
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
    
    @objc   func btnChooseLocationTapped(_ sender: UIButton){
        print("btn choose location tapped!")
    }
    
    
    @objc   func btnRegisterAdTapped(_ sender: UIButton) {
        let phoneNumber = self.phoneNumTextFiled.text
        let price = self.priceTextField.text
        let advertisingTitle = self.advertisingTitleTextField.text
        let advertisingDescription = self.advertisingDescriptionTextField.text
        
        if let phoneNumber = phoneNumber, let price = price, let advertisingTitle = advertisingTitle, let advertisingDescription = advertisingDescription {
            if phoneNumber.isEmpty || price.isEmpty || advertisingTitle.isEmpty || advertisingDescription.isEmpty {
                print("fill in the blank!")
            } else {
                print("all text field is full!")
            }
        }
    }

}

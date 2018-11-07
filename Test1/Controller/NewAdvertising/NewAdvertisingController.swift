//
//  NewAdvertisingController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class NewAdvertisingController: UIViewController {
    
    var allTextFields = [UIView]()
    var emptyTextFields = [UITextField]()
    var imagePickerController: UIImagePickerController?
    
    var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    let viewTapRecognizer = UITapGestureRecognizer()
    var scrollViewOffSet: CGFloat = 0
    
    let extraHeight: CGFloat = 180
    var selectedLocation = ""
    
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
        label.text = Const.TempText.newAdvertising
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Const.Pages.NewADPage.advertisingLocation
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let btnChooseLocation: UIButton = {
        let btn = UIButton(type: .custom)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnChooseLocationTapped(_:)), for: .touchUpInside)
        btn.setBackgroundColor(color: .darkRedLight, forState: .normal)
        btn.setBackgroundColor(color: .darkRedDark, forState: .highlighted)
        btn.setTitle(Const.BtnTitle.chooseLocation, for: .normal)
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
        let attributedTitle = NSMutableAttributedString(string: Const.Pages.NewADPage.advertisingImage , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        let paragraphStyleTitle = NSMutableParagraphStyle()
        paragraphStyleTitle.lineSpacing = 10
        let paragraphRangeTitle = NSRange(location: 0, length: attributedTitle.length)
        paragraphStyleTitle.alignment = .right
        attributedTitle.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyleTitle, range: paragraphRangeTitle)
        
        let attributedDescription = NSMutableAttributedString(string: Const.Pages.NewADPage.advertisingImageDescription, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
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
        label.text = Const.Pages.NewADPage.phoneNumber
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let phoneNumTextFiled: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.Gray.light1
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.textAlignment = .right
        textField.placeholder = Const.PlaceHolder.phoneNumber
        textField.layer.borderWidth = 2
        textField.keyboardType = .asciiCapableNumberPad
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
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
        label.text = Const.Pages.NewADPage.price
        return label
    }()
    
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.backgroundColor = UIColor.Gray.light1
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.keyboardType = .asciiCapableNumberPad
        textField.placeholder = Const.PlaceHolder.price
        
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
        label.text = Const.Pages.NewADPage.advertisingTitle
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let advertisingTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.Gray.light1
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.keyboardType = .default
        textField.placeholder = Const.PlaceHolder.advertisingTitle
        
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
        label.text = Const.Pages.NewADPage.advertisingDescription
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let advertisingDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.Gray.light1
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 22.5
        textField.clipsToBounds = true
        textField.keyboardType = .default
        textField.placeholder = Const.PlaceHolder.advertisingDescription
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightView = paddingViewRight
        textField.rightViewMode = .always
        
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingViewLeft
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let advertisingDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.Gray.light1
        textView.textAlignment = .right
        textView.text = Const.PlaceHolder.advertisingDescription
        textView.textColor = UIColor.Gray.light5
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderColor = UIColor.Gray.light2.cgColor
        textView.layer.cornerRadius = 22.5
        textView.layer.borderWidth = 2
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        textView.clipsToBounds = true
        textView.keyboardType = .default
        return textView
    }()
    
    let advertisingDescriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Const.Pages.NewADPage.newAdvertisingDescription
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
        btn.setTitle(Const.BtnTitle.registerLocation, for: .normal)
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
        self.advertisingDescriptionTextView.centerVertically()
        setupViews()
        setupNavBar()
        setupImageCollectionView()
        addObserverToViewGustureRecognizer()
    }
    
    func setupViews() {
        view.backgroundColor = .white
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
        
        if isViewDisapear {
            clearTextOfTextFields()
            self.btnChooseLocation.setTitle(Const.BtnTitle.chooseLocation, for: .normal)
        }
        
        self.btnChooseLocation.setTitle(Const.BtnTitle.chooseLocation, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.selectedLocation != Const.empty && !isViewDisapear {
            self.btnChooseLocation.setTitle(self.selectedLocation, for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isViewDisapear = true
        if self.imagePickerController == nil {
            self.imagePickerController = UIImagePickerController()
        }
    }
    
    @objc   func btnChooseLocationTapped(_ sender: UIButton){
        print("btn choose location tapped!")
        
        let chooseLocationVC = PopupChooseLocationViewController()
        chooseLocationVC.delegate = self
        
        let popupVC = CustomPopupViewController(contentController: chooseLocationVC, popupWidth: (22 / 30) * view.frame.width, popupHeight: (25 / 30) * view.frame.height)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 10
        popupVC.shadowEnabled = true
        
        present(popupVC, animated: true)
    }
    
    
    @objc func btnRegisterAdTapped(_ sender: UIButton) {
        let phoneNumber = self.phoneNumTextFiled.text
        let price = self.priceTextField.text
        let advertisingTitle = self.advertisingTitleTextField.text
        let advertisingDescription = self.advertisingDescriptionTextView.text
        
        if let phoneNumber = phoneNumber, let price = price, let advertisingTitle = advertisingTitle, let advertisingDescription = advertisingDescription {
            if phoneNumber.isEmpty || price.isEmpty || advertisingTitle.isEmpty || advertisingDescription == Const.PlaceHolder.advertisingDescription {
                // one or more textfield is empty, say user to fill them
                print("fill in the blank!")
                
                for textField in allTextFields {
                    print(textField)
                    if let tf = textField as? UITextView {
                        print("one objetc found")
                        if tf.text.isEmpty || tf.text == Const.PlaceHolder.advertisingDescription {
                            tf.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
                            tf.backgroundColor =  UIColor.darkRedLight.withAlphaComponent(0.2)
                        }
                        
                    } else if let tf = textField as? UITextField {
                        if tf.text!.isEmpty {
                            tf.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
                            tf.backgroundColor =  UIColor.darkRedLight.withAlphaComponent(0.2)
                        }
                    }
                    
                }
                
                var style = ToastStyle()
                ToastManager.shared.position = .bottom
                style.verticalPadding = 10
                style.bottomMargin = 100
                ToastManager.shared.style = style
                ToastManager.shared.duration = 1.0
                self.view.makeToast(Const.Toast.fillInTheBlank, style: style)
                
            } else if selectedLocation == Const.empty {
                // choose a province
                var style = ToastStyle()
                ToastManager.shared.position = .bottom
                style.verticalPadding = 10
                style.bottomMargin = 100
                ToastManager.shared.style = style
                ToastManager.shared.duration = 1.0
                self.view.makeToast(Const.Toast.chooseLocation, style: style)
            } else {
                // all text field and other things are ready for registering new Advertising to server
                print("all text field is full!")
                // close the keyboard, if is open.
                didTapView()
                if Utils.checkInternetConnection() {
                    if APIService.shared.isLoggedIn() {
                        if imageList.count > 1 {
                            // create new advertising model according to the user inputs in text fields
                            let newAdvertising = NewAdvertisingModel(title: advertisingTitle, description: advertisingDescription, phoneNumber: phoneNumber, location: self.selectedLocation, price: price)
                            
                            // when cursor arrive here, there is no problem for uploading data to server, all conditions are OK, let's upload new advertising!
                            
                            // befor uploading, it is best practice to show a toas activity and when registeration finished, cancel it!
                            
                            ToastManager.shared.style.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                            self.view.makeToastActivity(.center)
                            APIService.shared.registerNewAdvertising(newAdvertising: newAdvertising) {[weak self](done, response) in
                                if done {
                                    if let response = response {
                                        print("register new advertising response: \(response)")
                                    }
                                    // dimiss the active toast activity.
                                    DispatchQueue.main.async {
                                        self?.view.hideToastActivity()
                                        // toast for say to user that new advertising successfully registered in server.
                                        var style = ToastStyle()
                                        ToastManager.shared.position = .bottom
                                        style.verticalPadding = 10
                                        style.bottomMargin = 100
                                        ToastManager.shared.style = style
                                        ToastManager.shared.duration = 1.0
                                        self?.view.makeToast(Const.Toast.newAdvertisingRegisteredSuccessfully, style: style)
                                        
                                        // remove all images from imageList and reload collection view
                                        self?.imageList.removeAll()
                                        self?.reloadImageCollectionView()
                                        
                                        // erase text field's inputs
                                        self?.clearTextOfTextFields()
                                        
                                        // set title of choose location button to default
                                        self?.btnChooseLocation.setTitle(Const.BtnTitle.chooseLocation, for: .normal)
                                        
                                    }
                                } else {
                                    // tell user that there is some problem on registering new advertising to server, maybe server not responding or ther problems ...
                                    // added 7 NOV 2018 -> 01:13 PM
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                        // delay for 0.2 second
                                        self?.view.hideAllToasts()
                                        var style = ToastStyle()
                                        ToastManager.shared.position = .bottom
                                        style.verticalPadding = 10
                                        style.bottomMargin = 100
                                        ToastManager.shared.style = style
                                        ToastManager.shared.duration = 1.0
                                        self?.view.makeToast(Const.Toast.serverNotResponding, style: style)
                                        self?.view.hideToastActivity()
                                    }
                                }
                            }
                        } else {
                            // image list is not enough for uploading them to server.
                            print("image list in not enough")
                            var style = ToastStyle()
                            ToastManager.shared.position = .bottom
                            style.verticalPadding = 10
                            style.bottomMargin = 100
                            ToastManager.shared.style = style
                            ToastManager.shared.duration = 1.0
                            self.view.makeToast(Const.Toast.imageListNotEnough, style: style)
                        }
                    } else {
                        // user not logged in
                        var style = ToastStyle()
                        ToastManager.shared.position = .bottom
                        style.verticalPadding = 10
                        style.bottomMargin = 100
                        ToastManager.shared.style = style
                        ToastManager.shared.duration = 1.0
                        self.view.makeToast(Const.Toast.notLoggedIn, style: style)
                    }
                } else {
                    // there is no internet connection
                    // added: 2018/10/29 : 9:14 AM
                    self.view.makeToast(Const.Toast.checkInternetConnection)
                }
            }
        }
    }
    
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

/* =================================================================== */
/* ===================== * * * * * * * * * * * * ===================== */
/* ===================== *    MAIN EXTENSION   * ===================== */
/* ===================== * * * * * * * * * * * * ===================== */
/* =================================================================== */

extension NewAdvertisingController {
    func setupNavBar() {
        navigationItem.title = Const.NavTitle.newAdvertising
    }
    
    func addViews(){
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
        //        mainContainer.addSubview(advertisingDescriptionTextField)
        mainContainer.addSubview(advertisingDescriptionTextView)
        mainContainer.addSubview(btnRegisterAdvertising)
        mainContainer.addSubview(advertisingDescriptionText)
        
        self.allTextFields.append(phoneNumTextFiled)
        self.allTextFields.append(priceTextField)
        self.allTextFields.append(advertisingTitleTextField)
        self.allTextFields.append(advertisingDescriptionTextView)
    }
    
    func addConstraints() {
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
        
        advertisingDescriptionTextView.leftAnchor.constraint(equalTo: self.priceTextField.leftAnchor).isActive = true
        advertisingDescriptionTextView.rightAnchor.constraint(equalTo: self.priceTextField.rightAnchor).isActive = true
        advertisingDescriptionTextView.topAnchor.constraint(equalTo: self.advertisingDescriptionLabel.bottomAnchor).isActive = true
        advertisingDescriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 90).isActive = true
        advertisingDescriptionTextView.delegate = self
        
        advertisingDescriptionText.rightAnchor.constraint(equalTo: self.pricaLabel.rightAnchor, constant: -8).isActive = true
        advertisingDescriptionText.leftAnchor.constraint(equalTo: self.pricaLabel.leftAnchor, constant: 8).isActive = true
        advertisingDescriptionText.topAnchor.constraint(equalTo: self.advertisingDescriptionTextView.bottomAnchor, constant: 14).isActive = true
        advertisingDescriptionText.sizeToFit()
        
        btnRegisterAdvertising.rightAnchor.constraint(equalTo: self.pricaLabel.rightAnchor).isActive = true
        btnRegisterAdvertising.leftAnchor.constraint(equalTo: self.pricaLabel.leftAnchor).isActive = true
        btnRegisterAdvertising.topAnchor.constraint(equalTo: self.advertisingDescriptionText.bottomAnchor, constant: 20).isActive = true
        btnRegisterAdvertising.heightAnchor.constraint(equalTo: self.pricaLabel.heightAnchor).isActive = true
        
        btnRegisterAdvertising.bottomAnchor.constraint(equalTo: self.mainContainer.bottomAnchor).isActive = true
    }
    
    func addObserverToViewGustureRecognizer(){
        let notifier = NotificationCenter.default
        notifier.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        notifier.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
    }
    
}

/* ========================================================================= */
/* ===================== * * * * * * * * * * * * * * * ===================== */
/* ===================== *  IMAGE PICKER EXTENSION   * ===================== */
/* ===================== * * * * * * * * * * * * * * * ===================== */
/* ========================================================================= */

extension NewAdvertisingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func chooseImage(){
        if let imagePickerController = imagePickerController {
            
            
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            
            let actionSheet = UIAlertController(title: Const.popupText.imageGalleryTitle, message: Const.popupText.imageGalleryMessage, preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: Const.popupText.camera, style: .default, handler: { (action: UIAlertAction) in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Const.popupText.gallery, style: .default, handler: { (action: UIAlertAction) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Const.popupText.cancel, style: .cancel, handler: nil))
            
            DispatchQueue.main.async {
                self.present(actionSheet, animated: true) {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
                    actionSheet.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
                }
            }
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isViewDisapear = false
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            print("this is edited image")
            if let pickedImage = pickedImage.resized(toWidth: 150) {
                imageList.append(pickedImage)
                print(imageList.count)
                reloadImageCollectionView()
            }
        }
        picker.dismiss(animated: true) {
            self.isViewDisapear = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.isViewDisapear = true
        }
        
    }
    
}

/* ============================================================================= */
/* ===================== * * * * * * * * * * * * * * * * * ===================== */
/* ===================== *   COLLECTION VIEW EXTENSION   * ===================== */
/* ===================== * * * * * * * * * * * * * * * * * ===================== */
/* ============================================================================= */

extension NewAdvertisingController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NewAdvertisingImageCollectionViewDelegate {
    
    func deletImageTapped(indexPath: IndexPath) {
        imageList.remove(at: indexPath.row + 1)
        reloadImageCollectionView()
    }
    
    func setupImageCollectionView(){
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.semanticContentAttribute = .forceRightToLeft
        imageCollectionView.register(NewAdvertisingImageCell.self, forCellWithReuseIdentifier: Const.Id.imageCell)
        imageCollectionView.register(NewAdvertisingEmptyImageCell.self, forCellWithReuseIdentifier: Const.Id.imageEmptyCell)
    }
    
    func reloadImageCollectionView(){
        imageCollectionView.reloadData()
        let height = imageCollectionView.collectionViewLayout.collectionViewContentSize.height
        imageCollectionViewHeightConstraint.constant = height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // do in main thread
        if indexPath.row == (self.imageList.count - 1) && self.imageList.count <= 5 {
            self.chooseImage()
            self.isViewDisapear = false
        }else {
            print("index path: \(indexPath.row)")
        }
        print("image collectionView selected \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthAndHeight = self.view.frame.width / 3
        return CGSize(width: widthAndHeight, height: widthAndHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == (imageList.count - 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Id.imageEmptyCell, for: indexPath) as! NewAdvertisingEmptyImageCell
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Id.imageCell, for: indexPath) as! NewAdvertisingImageCell
        cell.imageBanner = imageList[indexPath.row + 1]
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
}

/* ===================================================================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* =================== *   TEXT FIELD EXTENSION  * ===================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* ===================================================================== */

extension NewAdvertisingController: UITextFieldDelegate {
    
    func clearTextOfTextFields() {
        self.phoneNumTextFiled.text = Const.empty
        self.priceTextField.text = Const.empty
        self.advertisingTitleTextField.text = Const.empty
        self.advertisingDescriptionTextView.text = Const.PlaceHolder.advertisingDescription
        self.advertisingDescriptionTextView.textColor = UIColor.Gray.light4
        
        // right aligment of text fields
        self.phoneNumTextFiled.textAlignment = .right
        self.priceTextField.textAlignment = .right
    }
    
    @objc func didTapView(){
        self.view.endEditing(true)
        print("did tap view")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkRedLight.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.Gray.light2.cgColor
        //        if let text = textField.text {
        //            if !text.isEmpty {
        //                textField.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
        //            }
        //        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.backgroundColor = UIColor.Gray.light1
        let textFieldRange = NSRange(location: 0, length: (textField.text?.count)!)
        // Check If textField is empty. If empty align your text field to right, so that placeholder text will show right aligned
        print(range)
        if (NSEqualRanges(range, textFieldRange) && string.count == 0) {
            if textField == self.phoneNumTextFiled || textField == self.priceTextField || textField == self.advertisingTitleTextField{
                textField.textAlignment = .right
            }else {
                textField.textAlignment = .left
            }
        } else {
            //else align textfield to left.
            if textField == self.phoneNumTextFiled || textField == self.priceTextField {
                textField.textAlignment = .left
            } else {
                textField.textAlignment = .right
            }
        }
        
        if textField == self.priceTextField {
            let cs = NSCharacterSet(charactersIn: "0123456789").inverted
            let filtered = string.components(separatedBy: cs)
            let component = filtered.joined(separator: "")
            let isNumeric = string == component
            
            // check for input string is numeric value or either a number not a string or character.
            if isNumeric {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 10
                
                let newString: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
                let numberWithOutCommas = newString.replacingOccurrences(of: ",", with: "")
                let number = formatter.number(from: numberWithOutCommas)
                if number != nil {
                    let formattedString = formatter.string(from: number!)
                    //                    print(number)
                    //                    print(formattedString)
                    textField.text = formattedString
                } else {
                    textField.text = nil
                }
            }
        }
        
        return textField != self.priceTextField;
    }
    
    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        self.view.removeGestureRecognizer(viewTapRecognizer)
    }
    
    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        viewTapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(viewTapRecognizer)
    }
    
}

/* ===================================================================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* =================== *   TEXT VIEW EXTENSION  * ===================== */
/* =================== * * * * * * * * * * * * * * ===================== */
/* ===================================================================== */
extension NewAdvertisingController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.darkRedLight.cgColor
        
        if textView.textColor == UIColor.Gray.light5 {
            textView.textColor = .black
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.Gray.light4.cgColor
        
        if textView.text.isEmpty {
            textView.textColor = UIColor.Gray.light5
            //            textView.layer.borderColor = UIColor.darkRedLight.withAlphaComponent(0.5).cgColor
            textView.text = Const.PlaceHolder.advertisingDescription
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.backgroundColor = UIColor.Gray.light1
        print("advertising description text view changed!")
    }
}

extension NewAdvertisingController: TableViewItemSelectionDelegate {
    func tableViewClicked(indexPath: IndexPath, province: String) {
        print("province: \(province)")
        btnChooseLocation.setTitle(province, for: .normal)
        self.selectedLocation = province
    }
}


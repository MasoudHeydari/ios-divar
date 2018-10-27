//
//  NewAdvertisingViewController+Hekper.swift
//  Test1
//
//  Created by Masoud Heydari on 10/26/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

extension NewAdvertisingController {
    
    func addObserverToViewGustureRecognizer(){
        let notifier = NotificationCenter.default
        notifier.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        notifier.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
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
        mainContainer.addSubview(advertisingDescriptionTextField)
        mainContainer.addSubview(btnRegisterAdvertising)
        mainContainer.addSubview(advertisingDescriptionText)
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
    
    
    func setupImageCollectionView(){
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.semanticContentAttribute = .forceRightToLeft
        imageCollectionView.register(NewAdvertisingImageCell.self, forCellWithReuseIdentifier: imgCell)
        imageCollectionView.register(NewAdvertisingEmptyImageCell.self, forCellWithReuseIdentifier: imgEmptyCell)
    }
    
    func reloadImageCollectionView(){
        imageCollectionView.reloadData()
        let height = imageCollectionView.collectionViewLayout.collectionViewContentSize.height
        imageCollectionViewHeightConstraint.constant = height
    }
    
    func setupNavBar() {
        navigationItem.title = "آگهی جدید"
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isViewDisapear = false
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
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
    
    func clearTextOfTextFields() {
        self.phoneNumTextFiled.text = ""
        self.priceTextField.text = ""
        self.advertisingTitleTextField.text = ""
        self.advertisingDescriptionTextField.text = ""
    }
    
    @objc func didTapView(){
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkRedLight.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.Gray.light1.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // if let stringLength = self.phoneNumTextFiled.text?.count {
        let textFieldRange = NSRange(location: 0, length: (textField.text?.count)!)
        // Check If textField is empty. If empty align your text field to center, so that placeholder text will show center aligned
        print(range)
        if (NSEqualRanges(range, textFieldRange) && string.count == 0) {
            if textField == self.phoneNumTextFiled || textField == self.priceTextField {
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
        return true;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == (imageList.count - 1) && imageList.count <= 5 {
            chooseImage()
            isViewDisapear = false
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imgEmptyCell, for: indexPath) as! NewAdvertisingEmptyImageCell
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imgCell, for: indexPath) as! NewAdvertisingImageCell
        cell.imageBanner = imageList[indexPath.row + 1]
        return cell
    }
    
    public func chooseImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Libraty", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        self.view.removeGestureRecognizer(viewTapRecognizer)
    }
    
    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        viewTapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(viewTapRecognizer)
    }
    
    
}

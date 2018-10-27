//
//  NewAdvertisingViewController+Hekper.swift
//  Test1
//
//  Created by Masoud Heydari on 10/26/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

extension NewAdvertisingController {
    
    
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
    
    
    func clearTextOfTextFields() {
        self.phoneNumTextFiled.text = ""
        self.priceTextField.text = ""
        self.advertisingTitleTextField.text = ""
        self.advertisingDescriptionTextField.text = ""
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
    
    
}

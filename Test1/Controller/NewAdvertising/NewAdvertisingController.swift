//
//  NewAdvertisingController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class NewAdvertisingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let imgCell = "image_cell"
    private let imgEmptyCell = "image_empty_cell"
    private var imageCollectionViewHeightConstraint = NSLayoutConstraint()
    private var imageList: [UIImage] = [UIImage()]
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkRedLight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "بخش 'آگهی جدید' بزودی کامل می شود"
        return label
    }()
    
    let advertisingLocationLabel: UILabel = {
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
    
    let advertisingImageTextView: UITextView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        setupImageCollectionView()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(advertisingLocationLabel)
        scrollView.addSubview(btnChooseLocation)
        scrollView.addSubview(divider1)
        scrollView.addSubview(advertisingImageTextView)
        scrollView.addSubview(imageCollectionView)
        view.addSubview(divider2)
        view.addSubview(advertisingPhoneNumLabel)
        
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        advertisingLocationLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        advertisingLocationLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 8).isActive = true
        advertisingLocationLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -24).isActive = true
        advertisingLocationLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        btnChooseLocation.topAnchor.constraint(equalTo: self.advertisingLocationLabel.bottomAnchor, constant: 8).isActive = true
        btnChooseLocation.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        btnChooseLocation.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 16/40).isActive = true
        btnChooseLocation.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        divider1.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        divider1.topAnchor.constraint(equalTo: self.btnChooseLocation.bottomAnchor, constant: 8).isActive = true
        divider1.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -24).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        advertisingImageTextView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        advertisingImageTextView.topAnchor.constraint(equalTo: self.divider1.bottomAnchor, constant: 8).isActive = true
        advertisingImageTextView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -24).isActive = true
        advertisingImageTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        imageCollectionView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor).isActive = true
        imageCollectionView.topAnchor.constraint(equalTo: self.advertisingImageTextView.bottomAnchor, constant: 1).isActive = true
        imageCollectionView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        imageCollectionViewHeightConstraint = imageCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        NSLayoutConstraint.activate([self.imageCollectionViewHeightConstraint])
        reloadImageCollectionView()
        
        divider2.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        divider2.topAnchor.constraint(equalTo: self.imageCollectionView.bottomAnchor, constant: 8).isActive = true
        divider2.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -24).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        advertisingPhoneNumLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 12).isActive = true
        advertisingPhoneNumLabel.topAnchor.constraint(equalTo: self.divider2.bottomAnchor, constant: 8).isActive = true
        advertisingPhoneNumLabel.rightAnchor.constraint(equalTo: self.divider2.rightAnchor).isActive = true
        advertisingPhoneNumLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        
    }
    override func viewDidLayoutSubviews() {
        reloadImageCollectionView()
        
    }
    private func setupImageCollectionView(){
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.semanticContentAttribute = .forceRightToLeft
        imageCollectionView.register(NewAdvertisingImageCell.self, forCellWithReuseIdentifier: imgCell)
        imageCollectionView.register(NewAdvertisingEmptyImageCell.self, forCellWithReuseIdentifier: imgEmptyCell)
    }
    
    private func reloadImageCollectionView(){
        imageCollectionView.reloadData()
        let height = imageCollectionView.collectionViewLayout.collectionViewContentSize.height
        imageCollectionViewHeightConstraint.constant = height
    }
    
    private func setupNavBar() {
        navigationItem.title = "آگهی جدید"
    }
    
    private func chooseImage(){
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
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let pickedImage = pickedImage.resized(toWidth: 150) {
                imageList.append(pickedImage)
                print(imageList.count)
                reloadImageCollectionView()
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc private func btnChooseLocationTapped(_ sender: UIButton){
        print("btn choose location tapped!")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == (imageList.count - 1) && imageList.count <= 5 {
            chooseImage()
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
}

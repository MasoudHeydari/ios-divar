//
//  NewAdvertisingImageCell.swift
//  Test1
//
//  Created by Masoud Heydari on 10/23/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class NewAdvertisingImageCell: UICollectionViewCell {
    
    var imageBanner: UIImage? {
        didSet{
            if let image = imageBanner {
                self.image.image = image
                print(image)
            }
        }
    }
    
    var indexPath: IndexPath?
    
    weak var delegate : NewAdvertisingImageCollectionViewDelegate?
    
    let btnDelete: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: Const.Image.delete)
        btn.setBackgroundColor(color: UIColor.Gray.light4, forState: .normal)
        btn.setBackgroundColor(color: UIColor.Gray.light3, forState: .highlighted)
        btn.setImage(img?.imageWithInsets(insetDimen: 16), for: .normal)
        return btn
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .cyan
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.backgroundColor = .white
        
        addSubview(image)
        addSubview(btnDelete)
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        btnDelete.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        btnDelete.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        btnDelete.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnDelete.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnDelete.addTarget(self, action: #selector(btnDeleteTapped(_:)), for: .touchUpInside)

        
    }
    
    @objc private func btnDeleteTapped(_ sender: UIButton) {
        print("btn delete tapped!")
        if let indexPath = indexPath {
            delegate?.deletImageTapped(indexPath: indexPath)
        }
    }
}

class NewAdvertisingEmptyImageCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        var img = UIImage.resizeImage(image: UIImage(named: Const.Image.addPhoto), targetSize: CGSize(width: 25, height: 25))
        img = img.imageWithInsets(insetDimen: 25)
        image.image = img
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .white
        addSubview(image)
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
    }
    
}


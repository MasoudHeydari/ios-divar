//
//  FriendController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class AllAdvertisingsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellId = "advertising_cell_id"
    private var advertisingList = [String]()
    
    lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "خطا در اتصال به سرور"
        label.textAlignment = .center
        label.backgroundColor = .yellow
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_ :)))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    @objc private func tapped(_ sender: UILabel){
        showAdvertisings()
        print("label tapped!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavController()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view apeared!")
        showAdvertisings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // do sth here
    }
    
    private func showAdvertisings() {
        if Utils.checkInternetConnection() {
            noInternetLabel.removeFromSuperview()
            if advertisingList.isEmpty {
                advertisingList.append("masoud")
                collectionView.reloadData()
            }
        } else {
            view.addSubview(noInternetLabel)
            noInternetLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            noInternetLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            noInternetLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 4).isActive = true
            noInternetLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            advertisingList.removeAll()
            collectionView.reloadData()
        }
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    private func setupCollectionView(){
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(AdvertisingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupNavController(){
        self.navigationItem.backBarButtonItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.title = "همه آگهی ها"
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisingList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailAdvertisingController(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func checkInternetConnection() -> Bool{
        return true
    }
}

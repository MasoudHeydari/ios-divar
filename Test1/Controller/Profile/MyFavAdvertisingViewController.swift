//
//  MyFavAdvertisingController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/22/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class MyFavAdvertisingsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var advertisingList = [AdvertisingModel]()
    
    
    let favLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkRedLight
        label.text = Const.Pages.MyFavAdvertisings.thereNoFavAdvertising
        return label
    }()
    
    lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Const.Pages.AllADPage.noInternetConnection
        label.textAlignment = .center
        label.backgroundColor = UIColor.Yellow.dark1
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
        showAdvertisings()
        
        
        print("device kind : \(UIDevice.getKind())")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view apeared!")
    }
    
    private func showAdvertisings() {
        if Utils.checkInternetConnection() {
            noInternetLabel.removeFromSuperview()
            if advertisingList.isEmpty {
                getFavoriteAdvertisingFromServer()
            }
        } else {
            setupNoInternetConnectionLabel()
        }
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    private func setupCollectionView(){
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(AdvertisingCell.self, forCellWithReuseIdentifier: Const.Id.favAdvertisingCell)
    }
    
    private func setupNavController(){
        self.navigationItem.backBarButtonItem?.title = Const.empty
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Const.empty, style: .plain, target: self, action: nil)
        navigationItem.title = Const.NavTitle.allAdvertisings
        
    }
    
    private func getFavoriteAdvertisingFromServer(){
        print(0)
        APIService.shared.getFavoriteAdvertisingByUserId(completion: { [weak self] (advertisingList) in
            // util loading data from server it is one of the best practice to show toast activiy for user.
            // added by: Masoud Heydari.   15 NOV 2018    09:40 AM
            print("1 + \(advertisingList?.count)")
            
            
            self?.view.makeToastActivity(.center)
            
            if advertisingList == nil {
                self?.view.hideToastActivity()
                // serever in avaibale but the user has no any favorite advertising. added by: Masoud Heydari   15 NOV 2018   09:41 AM
                self?.setupNoFavAdvertising()
            } else if let advertisingList = advertisingList {
                self?.view.hideToastActivity()
                // there some fav advertisings, so show them to user. added by: Masoud Heydari  15 NOV 2018  09:45 AM
                self?.advertisingList = advertisingList
                self?.collectionView.reloadData()
            } else {
                print(5)
                // server not responding. added by: Masoud Heydari    15 NOV 2018   09:58 AM
                self?.makeDefualtToast(string: Const.Toast.serverNotResponding, duration: 1.75)
                // hide the showing toast activity from view with 1.1 seconds delay.
                // added by: Masoud Hetdari, 15 NOV 2018  09:49 AM
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1, execute: {
                    self?.view.hideToastActivity()
                })
                // tell to user that thee is a problem in loading data from internet.
                // added by: Masoud Heydari, 15 NOV 2018  09:50 AM
                self?.setupNoInternetConnectionLabel()
            }
        })
    }
    
    private func setupNoFavAdvertising() {
        noInternetLabel.removeFromSuperview()
        self.view.addSubview(self.favLabel)
        favLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        favLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func setupNoInternetConnectionLabel() {
        self.favLabel.removeFromSuperview()
        view.addSubview(noInternetLabel)
        
        noInternetLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        noInternetLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        noInternetLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 4).isActive = true
        noInternetLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        advertisingList.removeAll()
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisingList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Utils.checkInternetConnection() {
            let detailAdvertisingController = DetailAdvertisingController()
            detailAdvertisingController.advertisingId = advertisingList[indexPath.row].advertising_id
            navigationController?.pushViewController(detailAdvertisingController, animated: true)
        } else {
            // when courser arrive here, the internet connection is not available and must toast and tell it to user.
            // added by masoud heydari.   10 NOV 2018   07:55 AM
            self.makeDefualtToast(string: Const.Toast.checkInternetConnection)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Id.favAdvertisingCell, for: indexPath) as! AdvertisingCell
        cell.advertisingModel = advertisingList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func makeDefualtToast(string: String, duration: TimeInterval = 1.0) {
        var style = ToastStyle()
        ToastManager.shared.position = .bottom
        style.verticalPadding = 10
        style.bottomMargin = 100
        ToastManager.shared.style = style
        ToastManager.shared.duration = duration
        self.view.makeToast(string, style: style)
    }
    
}




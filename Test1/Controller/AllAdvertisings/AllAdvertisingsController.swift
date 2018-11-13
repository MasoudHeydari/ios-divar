//
//  FriendController.swift
//  Test1
//
//  Created by Masoud Heydari on 10/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class AllAdvertisingsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var advertisingList = [AdvertisingModel]()
    
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
                getAllAdvertisingFromServer()
            }
        } else {
            setupNoInternetConnectionLabel()
        }
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .white
    }
    
    func setupNoInternetConnectionLabel() {
        view.addSubview(noInternetLabel)
        noInternetLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        noInternetLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        noInternetLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 4).isActive = true
        noInternetLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        advertisingList.removeAll()
        collectionView.reloadData()
    }
    
    private func setupCollectionView(){
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(AdvertisingCell.self, forCellWithReuseIdentifier: Const.Id.allAdvertisingCell)
    }
    
    private func setupNavController(){
        self.navigationItem.backBarButtonItem?.title = Const.empty
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Const.empty, style: .plain, target: self, action: nil)
        navigationItem.title = Const.NavTitle.allAdvertisings
        
    }
    
    private func getAllAdvertisingFromServer(){
        APIService.shared.getAllAdvertisingsFromServer { [weak self] (done, advertisingList) in
            // util loading data from server it is one opf the best practice to show toast activiy to user.
            // added by: Masoud Heydari     10 NOV 2018    08:02 AM
            self?.view.makeToastActivity(.center)
            if done {
                if let advertisingList = advertisingList {
                    // when courser arrive here, all advertsings was loaded to collectio view successfully, so dismiss the shown toast activity from screen.
                    // added by:    Masoud Heydari  10 NOV 2018     08:04  AM
                    self?.view.hideToastActivity()
                    self?.advertisingList = advertisingList
                    self?.collectionView.reloadData()
                }
            } else {
                // server not responding , added: 7 NOV 2018 -> 7:02 PM :: masoud heydari
                self?.makeDefualtToast(string: Const.Toast.serverNotResponding, duration: 1.75)
                // hide the showing toast activity from view with 1.1 seconds delay.
                // added by: Masoud Hetdari, 12 NOV 2018  07:49 AM
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1, execute: {
                    self?.view.hideToastActivity()
                })
                // tell to user that thee is a problem in loading data from internet.
                // added by: Masoud Heydari, 12 NOV 2018  07:50 AM
                self?.setupNoInternetConnectionLabel()
            }
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Id.allAdvertisingCell, for: indexPath) as! AdvertisingCell
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




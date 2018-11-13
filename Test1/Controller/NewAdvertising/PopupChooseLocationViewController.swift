//
//  PopupChooseLocationViewController.swift
//  Test1
//
//  Created by Masoud Heydari on 11/1/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

class PopupChooseLocationViewController: UIViewController {
    //    var parentViewController: UIViewController?
    
    var provinceList = [String]()
    private(set) var currentProvince = ""
    
    weak var delegate: TableViewItemSelectionDelegate?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupTableView()
        createFakeDataForTableView()
        setupNavBar()
    }
    private func setupNavBar() {
        self.navigationItem.title = Const.BtnTitle.chooseLocation
        
    }
}

/* ========================================================================= */
/* ===================== * * * * * * * * * * * * * * * ===================== */
/* ===================== *    TABLE VIEW EXTENSION   * ===================== */
/* ===================== * * * * * * * * * * * * * * * ===================== */
/* ========================================================================= */
extension PopupChooseLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(PopupChooseLocationTableViewCell.self, forCellReuseIdentifier: Const.Id.popChooseLocationCellId)
        
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func createFakeDataForTableView(){
        for province in Const.Province.provincesList {
            self.provinceList.append(province)
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.Id.popChooseLocationCellId, for: indexPath) as! PopupChooseLocationTableViewCell
        cell.province = provinceList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentProvince = provinceList[indexPath.row]
        print("table tapped")
        
        delegate?.tableViewClicked(indexPath: indexPath, province: currentProvince)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: true)
    }
    
}

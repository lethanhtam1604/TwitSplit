//
//  MessagesViewController.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

class MessagesViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Variable
    fileprivate let messagesPresenter = MessagesPresenter()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setupSearchBar()
        setupTableView()
        messagesPresenter.attachView(view: self)
    }
    
    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Mark: - Split Message Cycle
extension MessagesViewController: MessagesView {
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func splitMessage() {
        
    }
}

// Mark: - Setup ViewController
extension MessagesViewController {
    
    fileprivate func initCommon() {
        title = "messages".uppercased()
    }
    
    fileprivate func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = "Search for messages"
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.clear
        searchBar.barTintColor = UIColor.clear
        searchBar.tintColor = Global.colorMain
        searchBar.endEditing(true)
        
        for view in searchBar.subviews {
            for subview in view.subviews {
                if subview.isKind(of: UITextField.self) {
                    let textField: UITextField = subview as! UITextField //swiftlint:disable:this force_cast
                    textField.backgroundColor = UIColor.clear
                    break
                }
            }
        }
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = Global.colorSeparator
        let cellNib = UINib(nibName: MessageTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MessageTableViewCell.kCellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
    }
}

// Mark: - TableViewDataSource
extension MessagesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.kCellId, for: indexPath) as! MessageTableViewCell //swiftlint:disable:this force_cast
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        
        cell.bindingData()
        
        return cell
    }
}

// Mark: - TableViewDelegate
extension MessagesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.kCellId) as! MessageTableViewCell  //swiftlint:disable:this force_cast
        cell.bindingDataHeightForCell()
        
        return cell.heightForCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// Mark: - SearchBarDelegate
extension MessagesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

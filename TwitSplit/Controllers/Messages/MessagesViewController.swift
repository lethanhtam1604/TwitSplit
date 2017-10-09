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
    @IBOutlet fileprivate weak var indicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var messageInputBarView: MessageInputBarView!
    @IBOutlet fileprivate weak var inputBarViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variable
    fileprivate let messagesPresenter = MessagesPresenter()
    fileprivate var twitters: [Twitter] = []
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setupSearchBar()
        setupTableView()
    }
    
    // Mark: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Mark: - MessageInputBarDelegate
extension MessagesViewController: MessageInputBarDelegate {
    
    func actionTapToSendButton() {
        messagesPresenter.splitMessage(messageInputBarView.getMessage())
        messageInputBarView.setEmptyMessage()
    }
}

// Mark: - Split Message Cycle
extension MessagesViewController: MessagesView {
    
    func startLoading() {
        indicator.startAnimating()
    }
    
    func finishLoading() {
        indicator.stopAnimating()
    }
    
    func splitMessageCompleted(_ twitterResult: TwitterResult) {
        switch twitterResult {
        case .error(let error):
            // Rhe message can't split -> Show error
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            showDetailViewController(alert, sender: nil)
        case .success(let messages):
            // Reload data for tableview
            twitters.append(contentsOf: messages.map { Twitter(User("Thanh-Tam Le", "lethanhtam1604@gmail.com", "0984002084", "https://raw.githubusercontent.com/lethanhtam1604/TwitSplit/master/TwitSplit/Resources/Avatar/MyAvatar.jpg"), $0) })
            self.tableView.reloadData()
            
            // Move to bottom of tableview
            let indexPath = NSIndexPath(row: twitters.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
        }
    }
}

// Mark: - Setup ViewController
extension MessagesViewController {
    
    fileprivate func initCommon() {
        messagesPresenter.attachView(view: self)
        messageInputBarView.delegate = self
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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.preservesSuperviewLayoutMargins = true

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
        tableView.separatorColor = Global.colorLine
        let cellNib = UINib(nibName: MessageTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MessageTableViewCell.kCellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
}

// Mark: - TableViewDataSource
extension MessagesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.kCellId, for: indexPath) as! MessageTableViewCell //swiftlint:disable:this force_cast
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        
        cell.bindingData(twitters[indexPath.row])
        
        return cell
    }
}

// Mark: - TableViewDelegate
extension MessagesViewController: UITableViewDelegate {
    
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
        searchMessage()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchMessage()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// Mark: Search messsage
extension MessagesViewController {

    fileprivate func searchMessage() {
        
    }
    
    func getTableView() -> UITableView? {
        if tableView != nil {
            return tableView
        }
        return nil
    }
}

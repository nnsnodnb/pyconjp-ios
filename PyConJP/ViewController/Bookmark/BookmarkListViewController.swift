//
//  BookmarkListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class BookmarkListViewController: UIViewController, UITableViewDelegate, StoryboardIdentifiable, ErrorAlertProtocol {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib  = UINib(nibName: bookmarkListDataSource.reuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: bookmarkListDataSource.reuseIdentifier)
            tableView.dataSource = bookmarkListDataSource
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = TalkTableViewCell.estimatedRowHeight
        }
    }
    
    private let bookmarkListDataSource = BookmarkListDataSource()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    static func build() -> BookmarkListViewController {
        let bookmarkListViewController: BookmarkListViewController = UIStoryboard(storyboard: .bookmark).instantiateViewController()
        return bookmarkListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(BookmarkListViewController.refreshNotification(_:)), name: NSNotification.Name(rawValue: PCJNotificationConfig.completeFetchDataNotification), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        refresh()
    }
    
    @objc func refreshNotification(_ notification: Notification) {
        refresh()
    }
    
    func refresh() {
        bookmarkListDataSource.refreshData { [weak self](result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                 guard let weakSelf = self else { return }
                DispatchQueue.main.async {
                    self?.showErrorAlart(with: error, parent: weakSelf)
                }
            }
        }

    }
    
    // MARK: - Table View Controller Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let talkObject = bookmarkListDataSource.timelines[indexPath.section].talks[indexPath.row]
        let talkDetailViewController = TalkDetailViewController.build(id: talkObject.id)
        self.navigationController?.pushViewController(talkDetailViewController, animated: true)
    }
    
}

//
//  SubModelsListViewController.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

//MARK: Protocol.
protocol SubModelListViewControllerProtocol: class {
    func show(subModels: [RealmSubModel])
    var interactor: SubModelListInteractorProtocol? {set get}
}

//MARK: Delegate.
protocol SubModelListSelectionDelegate: class {
    func selected(subModel: RealmSubModel)
}

//MARK: Class.
class SubModelListViewController: UIViewController {
    
    @IBOutlet weak var subModelsTableView: UITableView!
    
    private var subModels:[RealmSubModel]? {
        didSet{
            self.subModelsTableView.reloadData()
        }
    }
    
    var interactor: SubModelListInteractorProtocol?
    weak var delegate: SubModelListSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadSubModels()
    }
    
    
    
}

//MARK: Datasource methods.
extension SubModelListViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.30*Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let model = subModels?[indexPath.item] {
            cell.textLabel?.text = model.name
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

//MARK: Delegate methods.
extension SubModelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let subModel = self.subModels?[indexPath.row] else {
            return
        }
        self.delegate?.selected(subModel: subModel)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SubModelListViewController: SubModelListViewControllerProtocol {
    func show(subModels: [RealmSubModel]) {
        self.subModels = subModels
    }
}

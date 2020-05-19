//
//  ModelListViewController.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import UIKit
import RealmSwift

protocol ModelListViewControllerProtocol: class {
    func show(models: List<RealmModel>)
    var interactor: ModelListInteractorProtocol? {set get}
}

protocol ModelListSelectionDelegate: class {
    func selected(model: RealmModel)
}


class ModelListViewController: UIViewController {
    
    @IBOutlet weak var modelListTableView: UITableView!
    
    var models:List<RealmModel>? {
        didSet {
            self.modelListTableView.reloadData()
        }
    }
    var interactor: ModelListInteractorProtocol?
    
    weak var delegate: ModelListSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadModels()
    }
    
}

extension ModelListViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.05, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let model = models?[indexPath.item] {
            cell.textLabel?.text = model.name
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension ModelListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = models?[indexPath.item] else {
            return
        }
        self.delegate?.selected(model: model)
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension ModelListViewController: ModelListViewControllerProtocol {
    func show(models: List<RealmModel>) {
        self.models = models
    }
}


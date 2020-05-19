//
//  ViewController.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import UIKit
import RealmSwift


//MARK: Protocol.
protocol MakeViewControllerProtocol: class {
    func show(makes:[RealmMake])
    var interactor: MakeInteractorProtocol? {set get}
}

//MARK: Delegate.
protocol MakeSelectionDelegate: class {
    func selected(make: RealmMake)
}

//MARK: Class.
class MakeViewController: UIViewController {
    
    @IBOutlet weak var makeTableView: UITableView!
    private var makes: [RealmMake]?
    var interactor: MakeInteractorProtocol?
    
    weak var delegate: MakeSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose make"
        interactor?.fetchMakes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

//MARK: Datasource methods.
extension MakeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.05, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MakeTableViewCell", for: indexPath) as? MakeTableViewCell,
            let make = makes?[indexPath.item] else {
                return UITableViewCell()
        }
        cell.setData(make: make)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

//MARK: Delegate methods.
extension MakeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let make = makes?[indexPath.item] {
            self.delegate?.selected(make: make)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: Protocol methods.
extension MakeViewController: MakeViewControllerProtocol{
    
    func show(makes:[RealmMake]) {
        self.makes = makes
    }
}


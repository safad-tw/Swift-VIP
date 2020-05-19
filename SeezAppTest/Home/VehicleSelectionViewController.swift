//
//  VehicleSelectionViewController.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import UIKit
import RealmSwift

//MARK: Protocol
protocol VehicleSelectionViewControllerProtocol:class {
    func vehicleSpecsFetched()
    func showMakesScreen(with makes: [RealmMake])
    func showModelsScreen(with models: List<RealmModel>)
    func showSubModelsScreen(with subModels: [RealmSubModel])
    var router: VehicleSelectionRouterProtocol? {get set}
    var interactor: VehicleSelectionInteractorProtocol? {set get}
}

//MARK: Class
class VehicleSelectionViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var subModelLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    
    //MARK: variables
    var router: VehicleSelectionRouterProtocol?
    var interactor: VehicleSelectionInteractorProtocol?
    
    private var selectedMake: RealmMake?
    private var selectedModel: RealmModel?
    private var selectedSubmodel: RealmSubModel?
    
    //MARK: Lifecycles
    override func loadView() {
        super.loadView()
        VehicleSelectionVCBuilder.buildModule(on: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose a Vehicle"
        
        self.showLoader()
        interactor?.fetchVehicleSpecs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK: Private functions
    private func resetSubModel() {
        self.selectedSubmodel = nil
        self.subModelLabel.text = ""
    }
    
    private func resetModel() {
        self.selectedModel = nil
        self.modelLabel.text = ""
    }
    
    private func resetMake() {
        self.selectedMake = nil
        self.makeLabel.text = ""
    }
    
     //MARK: Button actions.
    @IBAction func selectSubmodel(_ sender: Any) {
        guard let _ = self.selectedMake, let _ = self.selectedModel else {
            AlertUtil.show(on: self, title: "Select Make and Model")
            return
        }
        interactor?.setSubModels()
        
    }
    
    @IBAction func selectModel(_ sender: Any) {
        guard let _ = self.selectedMake else {
            AlertUtil.show(on: self, title: "Select Make")
            return
        }
        interactor?.setModels()
    }
    
    
    @IBAction func selectMake(_ sender: Any) {
        interactor?.setMakes()
    }
    
    @IBAction func goToPricePrediction(_ sender: Any) {
        guard let make = selectedMake,
            let vC = self.router?.showPricePredictionScreen(selectedMake: make, selectedModel: self.selectedModel, selectedSubModel: self.selectedSubmodel)
            else {  AlertUtil.show(on: self, title: "Select Make")
                return
        }
        self.navigationController?.pushViewController(vC, animated: true)
    }
}


 //MARK: Protocol methods.
extension VehicleSelectionViewController:VehicleSelectionViewControllerProtocol{
    
    func vehicleSpecsFetched() {
        DispatchQueue.main.async {
            self.hideLoader()
        }
    }
    
    func showMakesScreen(with makes: [RealmMake]) {
        guard let vC = self.router?.showMakeScreen(makes: makes) as? MakeViewController else { return }
        vC.delegate = self
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    func showModelsScreen(with models: List<RealmModel>) {
        guard let modelVC = self.router?.showModelsScreen(models: models) as? ModelListViewController else {
            return
        }
        modelVC.delegate = self
        self.navigationController?.pushViewController(modelVC, animated: true)
    }
    
    
    func showSubModelsScreen(with subModels: [RealmSubModel]) {
        guard let submodelVC = self.router?.showSubModelsScreen(subModels: subModels) as? SubModelListViewController else {
            return
        }
        submodelVC.delegate = self
        self.navigationController?.pushViewController(submodelVC, animated: true)
        
    }
}

//MARK: Delegate methods.
extension VehicleSelectionViewController:MakeSelectionDelegate{
    func selected(make: RealmMake) {
        self.selectedMake = make
        self.makeLabel.text = "Selected vehicle make: \(make.name) \n last updated at: \(DateFormatterUtil.convertToDateFormatInString(stringDate: make.updatedAt))"
        interactor?.selected(make: make)
        self.resetModel()
        self.resetSubModel()
    }
}


extension VehicleSelectionViewController:ModelListSelectionDelegate{
    func selected(model: RealmModel) {
        self.selectedModel = model
        self.modelLabel.text = "Selected vehicle model: \(model.name)"
        interactor?.selected(model: model)
        self.resetSubModel()
    }
}

extension VehicleSelectionViewController:SubModelListSelectionDelegate{
    func selected(subModel: RealmSubModel) {
        self.selectedSubmodel = subModel
        self.subModelLabel.text = "Selected vehicle sub model: \(subModel.name)"
        interactor?.selected(subModel: subModel)
    }
}

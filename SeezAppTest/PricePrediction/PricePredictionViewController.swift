//
//  PricePredictionViewController.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//
import UIKit

//MARK: Protocol.
protocol PricePredictionViewControllerProtocol:class {
    var interactor: PricePredictionInteractorProtocol? {set get}
    func show(price: Price)
    func failedToFetchPrice()
}

//MARK: Class.
class PricePredictionViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var predictPriceLbl: UILabel!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    var interactor: PricePredictionInteractorProtocol?
    
    private var years:[Int] = [Int]()
    
    //MARK: Lifecycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        self.yearTextField.delegate = self
        
        setYearPickerData()
        setInitialValues()
    }
    
    //MARK: Private methods.
    private func setYearPickerData() {
        let year = getCurrentYear()
        for index in year-50...year+50 {
            years.append(index)
        }
    }
    
    private func setInitialValues() {
        yearPicker.selectRow(50, inComponent: 0, animated: true)
        self.yearTextField.text = String(years[yearPicker.selectedRow(inComponent: 0)])
    }
    
    private func getCurrentYear() -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        return year
    }
    
    @IBAction func predictPrice(_ sender: Any) {
        guard let year = self.yearTextField.text else {
            return
        }
        self.showLoader()
        interactor?.fetchPredictPrice(for: year)
    }
    
}


 //MARK: Delegate methods.
extension PricePredictionViewController:UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(years[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.predictPriceLbl.text = ""
        self.yearTextField.text = String(years[row])
    }
    
}


//MARK: Protocol methods.
extension PricePredictionViewController: PricePredictionViewControllerProtocol{
    
    func show(price: Price){
        self.predictPriceLbl.textColor = UIColor.black
        self.predictPriceLbl.text = "Predicted price is : \(price.result) \(price.currency)"
        DispatchQueue.main.async {
            self.hideLoader()
        }
    }
    
    func failedToFetchPrice() {
        self.predictPriceLbl.textColor = UIColor.red
        self.predictPriceLbl.text = "Error in fetchig prediction price...."
        DispatchQueue.main.async {
            self.hideLoader()
        }
    }
    
}

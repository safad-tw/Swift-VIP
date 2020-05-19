//
//  PricePredictionPresenter.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation


protocol PricePredictionPresenterProtocol {
    func show(price: Price)
    func failedToFetchPrice()
}

class PricePredictionPresenter {
    
    weak var view: PricePredictionViewControllerProtocol?
    
    init(view:PricePredictionViewControllerProtocol) {
        self.view = view
    }

}

extension PricePredictionPresenter:PricePredictionPresenterProtocol {
    func show(price: Price) {
        self.view?.show(price: price)
    }
    
    func failedToFetchPrice() {
         self.view?.failedToFetchPrice()
    }

}


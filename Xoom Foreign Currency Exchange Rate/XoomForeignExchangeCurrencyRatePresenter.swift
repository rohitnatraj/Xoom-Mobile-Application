//
//  XoomForeignExchangeCurrencyRatePresenter.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/18/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import Foundation


class XoomForeignExchangeCurrencyRatePresenter : NSObject, XoomForeignExchangeCurrencyRateInteractorToPresenterInterface, XoomForeignExchangeCurrencyRateViewToPresenterInterface, XoomForeignExchangeCurrencyRateWireframeToPresenterInterface {
        
        // MARK: - VIPER Stack
        var interactor : XoomForeignExchangeCurrencyRatePresenterToInteractorInterface!
        var view : XoomForeignExchangeCurrencyRatePresenterToViewInterface!
        var wireframe : XoomForeignExchangeCurrencyRatePresenterToWireframeInterface!
        
        // MARK: - Interactor to Presenter Interface
        func listOfCountriesSuccessfullyFetched(countries: arrayOfDictionaries) {
                view.showListOf(countries: countries)
        }
        
        func foreignExchangeRateSuccessfullyFetchedWith(data: [String : Any]) {
                if let data = data["data"] as? [String:Any] {
                        let fx = data["fx"]
                        let country = data["country"]
                        let fxDetails = ForeignExchangeRateDetailsObject()
                        
                        if let fx = fx as? [[String : Any]] {
                                if let receiveCurrencyCode = fx[0]["receiveCurrencyCode"], let sendFxRate = fx[0]["sendFxRate"] {
                                        fxDetails.currencyCode = receiveCurrencyCode as! String
                                        fxDetails.fxRate  = sendFxRate as! Double
                                        
                                }
                        }
                        
                        if let country = country as? [String : Any] {
                                if let countryCode = country["countryCode"], let feesChanged = country["feesChanged"]  {
                                        fxDetails.countryCode = countryCode as! String
                                        fxDetails.feesChanged = feesChanged as! String
                                }
                        }
                        
                        self.view.showForeignExchangeRateFor(country: fxDetails)
                }
        }
        
        func foreignExchangeRateFetchFailedWith(error: Error) {
                self.view.showError(error: error)
        }
        
        // MARK: - View to Presenter Interface
        func fetchForeignExchangeRateFor(country:String) {
                self.interactor.fetchForeignCurrencyExchangeRateFor(country: country)
        }
        
        // MARK: - Wireframe to Presenter Interface
        func presentingListOfCountries() {
                interactor.fetchListOfCountries()
        }
        
}

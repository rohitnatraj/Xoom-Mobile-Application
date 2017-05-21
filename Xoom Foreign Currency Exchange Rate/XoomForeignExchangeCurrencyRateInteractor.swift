//
//  XoomForeignExchangeCurrencyRateInteractor.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/18/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import Foundation

class XoomForeignExchangeCurrencyRateInteractor: NSObject, XoomForeignExchangeCurrencyRatePresenterToInteractorInterface {
        
        // MARK: - VIPER Stack
        var presenter : XoomForeignExchangeCurrencyRateInteractorToPresenterInterface!
        
        // MARK: - Instance Variables
        
        var countriesDictionary = NSDictionary()
        var countriesArray = arrayOfDictionaries()
        
        lazy var service: XoomForeignExchangeRateService = {
                return XoomForeignExchangeRateService()
        }()
        
        // MARK: - Presenter To Interactor Interface
        
        func fetchListOfCountries() {
                countriesDictionary =  NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Countries", ofType: "plist")!)!
                countriesArray = countriesDictionary["Countries"] as! arrayOfDictionaries
                presenter.listOfCountriesSuccessfullyFetched(countries: countriesArray)
        }
        
        func fetchForeignCurrencyExchangeRateFor(country:String) {
                service.fetchForeignExchangeRatesForCountryWith(CountryCode: country, onSuccess: { (data) in
                        self.presenter.foreignExchangeRateSuccessfullyFetchedWith(data: data)
                }, onFailure: { (error) in
                        self.presenter.foreignExchangeRateFetchFailedWith(error: error)
                })
        }
}

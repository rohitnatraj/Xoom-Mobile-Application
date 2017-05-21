//
//  XoomForeignExchangeCurrencyRateProtocols.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/18/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import UIKit
import Foundation

let kXoomForeignExchangeCurrencyRateNavigationControllerIdentifier = "XoomForeignExchangeCurrencyRateNavigationController"
let kXoomForeignExchangeCurrencyRateStoryboardIdentifier = "XoomForeignExchangeCurrencyRate"

typealias arrayOfDictionaries = [[String:String]]

// Messages outgoing from the module
@objc protocol XoomForeignExchangeCurrencyRateDelegate : class {
        
}

// VIPER Interface for communication from Wireframe -> Presenter
@objc protocol XoomForeignExchangeCurrencyRateWireframeToPresenterInterface : class {
        func presentingListOfCountries()
}

// VIPER Interface for communication from Presenter -> Wireframe
@objc protocol XoomForeignExchangeCurrencyRatePresenterToWireframeInterface : class {

}

// VIPER Interface for communication from Interactor -> Presenter
@objc protocol XoomForeignExchangeCurrencyRateInteractorToPresenterInterface : class {
        func listOfCountriesSuccessfullyFetched(countries:arrayOfDictionaries)
        func foreignExchangeRateSuccessfullyFetchedWith(data:[String:Any])
        func foreignExchangeRateFetchFailedWith(error:Error)
}

// VIPER Interface for communication from Presenter -> Interactor
@objc protocol XoomForeignExchangeCurrencyRatePresenterToInteractorInterface : class {
        func fetchListOfCountries()
        func fetchForeignCurrencyExchangeRateFor(country:String)
}

// VIPER Interface for communication from Presenter -> View
@objc protocol XoomForeignExchangeCurrencyRatePresenterToViewInterface : class {
        func showListOf(countries:arrayOfDictionaries)
        func showForeignExchangeRateFor(country:ForeignExchangeRateDetailsObject)
        func showError(error:Error)
}

// VIPER Interface for communication from View -> Presenter
@objc protocol XoomForeignExchangeCurrencyRateViewToPresenterInterface : class {
        func fetchForeignExchangeRateFor(country:String)
}

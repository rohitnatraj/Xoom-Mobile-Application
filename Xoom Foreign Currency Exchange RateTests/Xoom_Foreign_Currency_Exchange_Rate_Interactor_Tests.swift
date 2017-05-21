//
//  Xoom_Foreign_Currency_Exchange_Rate_Wireframe_Tests.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/21/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import XCTest
@testable import Xoom_Foreign_Currency_Exchange_Rate

class Xoom_Foreign_Currency_Exchange_Rate_Interactor: XCTestCase, XoomForeignExchangeCurrencyRateInteractorToPresenterInterface {
        
        var expectation : XCTestExpectation?
        var interactor = XoomForeignExchangeCurrencyRateInteractor()
        
        override func setUp() {
                super.setUp()
                interactor.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
                self.expectation = nil
        }
        
        func testFetchListOfCountriesShouldCallPresentersListOfCountriesSuccessfullyFetchedWithCountries() {
                expectation = expectation(description: "Presenter's ListOfCountriesSuccessfullyFetched should be called")
                interactor.fetchListOfCountries()
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("Presenter's ListOfCountriesSuccessfullyFetched was not called")
                        }
                }
        }
        
        func testFetchForeignCurrencyExchangeRateForCountry() {
                
                class MockSuccessForeignCurrencyExchangeRateFetch:XoomForeignExchangeRateService {
                        override func fetchForeignExchangeRatesForCountryWith(CountryCode: String, onSuccess succes: @escaping ([String : Any]) -> (), onFailure failure: @escaping (Error) -> ()) {
                                succes([String : Any]())
                        }
                }
                
                class MockFailureForeignCurrencyExchangeRateFetch : XoomForeignExchangeRateService {
                         override func fetchForeignExchangeRatesForCountryWith(CountryCode: String, onSuccess succes: @escaping ([String : Any]) -> (), onFailure failure: @escaping (Error) -> ()) {
                                failure(NSError(domain: String(), code: 404, userInfo: nil))
                        }
                }
                
                //success
                expectation = self.expectation(description: "Presenter's foreignExchangeRateSuccessfullyFetchedWith was called")
                interactor.service = MockSuccessForeignCurrencyExchangeRateFetch()
                interactor.fetchForeignCurrencyExchangeRateFor(country: "IN")
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("Presenters foreignExchangeRateSuccessfullyFetchedWith was not called")
                        }
                }
                
                //failure
                expectation = self.expectation(description: "Presenter's foreignExchangeRateFetchFailedWith was called")
                interactor.service = MockFailureForeignCurrencyExchangeRateFetch()
                interactor.fetchForeignCurrencyExchangeRateFor(country: "IN")
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("Presenters foreignExchangeRateFetchFailedWith was not called")
                        }
                }
        }
        
        //MARK:- XoomForeignExchangeCurrencyRateInteractorToPresenterInterface Methods
        
        func listOfCountriesSuccessfullyFetched(countries: arrayOfDictionaries) {
                if expectation?.description == "Presenter's ListOfCountriesSuccessfullyFetched should be called" {
                        expectation?.fulfill()
                }
        }
        
        func foreignExchangeRateFetchFailedWith(error: Error) {
                if expectation?.description == "Presenter's foreignExchangeRateFetchFailedWith was called" {
                        expectation?.fulfill()
                }
        }
        
        func foreignExchangeRateSuccessfullyFetchedWith(data: [String : Any]) {
                if expectation?.description == "Presenter's foreignExchangeRateSuccessfullyFetchedWith was called" {
                        expectation?.fulfill()
                }
        }
        
}

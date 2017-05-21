//
//  Xoom_Foreign_Currency_Exchange_RateTests.swift
//  Xoom Foreign Currency Exchange RateTests
//
//  Created by Rohit Natraj on 5/17/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import XCTest
@testable import Xoom_Foreign_Currency_Exchange_Rate

class Xoom_Foreign_Currency_Exchange_Rate_Presenter_Tests: XCTestCase, XoomForeignExchangeCurrencyRatePresenterToInteractorInterface,XoomForeignExchangeCurrencyRatePresenterToViewInterface {
        
        var expectation:XCTestExpectation?
        var presenter = XoomForeignExchangeCurrencyRatePresenter()
    
    override func setUp() {
        super.setUp()
        
        presenter.interactor = self
        presenter.view = self
    }
    
    override func tearDown() {
        self.expectation = nil
        super.tearDown()
    }
        

        func testPresentingListOFCountriesShouldCallInteractorsFetchListOfCountries() {
                expectation = expectation(description: "Interactor's fetchListOfCountries Was Called")
                presenter.presentingListOfCountries()
                
                waitForExpectations(timeout: 5) { (error) in
                        if error != nil {
                                XCTFail("Interactor's fetchListOfCountries was not called")
                        }
                }
        }
        
        func testFetchForeignExchangeRateForCountryShouldCallInteractorsFetchForeignCurrencyExchangeRate() {
                expectation = expectation(description: "Interactor's fetchForeignCurrencyExchangeRate was called")
                presenter.fetchForeignExchangeRateFor(country: "IN")
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("Interactor's fetchForeignCurrencyExchangeRate was not called")
                        }
                }
        }
        
        func testForeignExchangeRateFetchFailedWithErrorShouldCallViewsShowErrorMethod() {
                expectation = expectation(description: "View's showError was called")
                presenter.foreignExchangeRateFetchFailedWith(error: NSError(domain: "ABC", code: 404, userInfo: nil))
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("View's showError was not called")
                        }
                }
        }
        
        func testListOfCountrieSuccessfullyFetchedShouldCallViewsShowListOfCountriesMethod() {
                expectation = expectation(description: "View's ShowListOf was Called")
                presenter.listOfCountriesSuccessfullyFetched(countries: arrayOfDictionaries())
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("View's showListOf was not called")
                        }
                }
        }
        
        func testForeignExchangeRateSuccessfullyFetchedWithDataShouldCallViewsShowForeignExchangeRateForMethod() {
                
                var country = [String:Any]()
                country["countryCode"] = "RN"
                country["feesChanged"] = "2015-12-20"
                
                var fx = [String:Any]()
                fx["receiveCurrencyCode"] = "RNS"
                fx["sendFxRate"] = 17.6
                
                var data1 = [String:Any]()
                data1["country"] = country
                data1["fx"] = [fx]
                
                var data = [String:Any]()
                data["data"] = data1
                
                expectation = expectation(description: "View's showForeignExchangeRateFor was called")
                presenter.foreignExchangeRateSuccessfullyFetchedWith(data: data)
                waitForExpectations(timeout: 4) { (error) in
                        if error != nil {
                                XCTFail("View's showForeignExchangeRateFor was not called")
                        }
                }
                
        }
        
        //MARK:- XoomForeignExchangeCurrencyRateInteractorToPresenterInterface Methods
        
        func fetchListOfCountries() {
                if expectation?.description == "Interactor's fetchListOfCountries Was Called" {
                        expectation?.fulfill()
                }
        }
        
        func fetchForeignCurrencyExchangeRateFor(country: String) {
                if expectation?.description == "Interactor's fetchForeignCurrencyExchangeRate was called" {
                        expectation?.fulfill()
                        XCTAssertEqual("IN", country)
                }
        }
        
        //MARK:- XoomForeignExchangeCurrencyRatePresenterToViewInterface Methods
        
        func showError(error: Error) {
                if expectation?.description == "View's showError was called" {
                        expectation?.fulfill()
                }
        }
        
        func showForeignExchangeRateFor(country: ForeignExchangeRateDetailsObject) {
                if expectation?.description == "View's showForeignExchangeRateFor was called" {
                        expectation?.fulfill()
                        XCTAssertEqual(country.countryCode, "RN")
                        XCTAssertEqual(country.feesChanged, "2015-12-20")
                        XCTAssertEqual(country.currencyCode, "RNS")
                        XCTAssertEqual(country.fxRate, 17.6)
                }
        }
        
        func showListOf(countries: arrayOfDictionaries) {
                if expectation?.description == "View's ShowListOf was Called" {
                        expectation?.fulfill()
                }
        }
        
    
    
}

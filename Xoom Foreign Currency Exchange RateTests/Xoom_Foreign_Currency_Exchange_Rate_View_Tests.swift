//
//  Xoom_Foreign_Currency_Exchange_Rate_View_Tests.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/21/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import XCTest
@testable import Xoom_Foreign_Currency_Exchange_Rate


class Xoom_Foreign_Currency_Exchange_Rate_View_Tests : XCTestCase,XoomForeignExchangeCurrencyRateViewToPresenterInterface {
        
        var expectation : XCTestExpectation?
        var view = XoomForeignExchangeCurrencyRateView()
        var window = UIWindow()
        
        override func setUp() {
                super.setUp()
                view.presenter = self
        }
        
        override func tearDown() {
                super.tearDown()
                self.expectation = nil
        }
        
        func testTableViewDidSelectRowForFilteredListOfCountries() {
                expectation = expectation(description: "Presenter Was Informed to fetchForeignExchangeRate for filteredListOfCountries")
                let indexPath = IndexPath(row: 0, section: 0)
                let tableView = UITableView()
                view.tableView = tableView
                view.isSearching = true
                var dictionary = [String:Any]()
                dictionary["CountryName"] = "India"
                dictionary["CountryCode"] = "IN"
                view.filteredListOfCountries =
                        [dictionary as! Dictionary<String, String>]
                view.tableView(tableView, didSelectRowAt: indexPath)
                
                waitForExpectations(timeout: 5) { (error) in
                        if error != nil {
                                XCTFail("Presenter was not informed to fetchForeignExchangeRate for filteredListOfCountries")
                        }
                }
                
        }
        
        func testTableViewDidSelectRowForListOfCountries() {
                expectation = expectation(description: "Presenter Was Informed to fetchForeignExchangeRate for ListOfCountries")
                let indexPath = IndexPath(row: 0, section: 0)
                let tableView = UITableView()
                view.tableView = tableView
                view.isSearching = false
                var dictionary = [String:Any]()
                dictionary["CountryName"] = "India"
                dictionary["CountryCode"] = "IN"
                view.listOfCountries =
                        [dictionary as! Dictionary<String, String>]
                view.tableView(tableView, didSelectRowAt: indexPath)
                
                waitForExpectations(timeout: 5) { (error) in
                        if error != nil {
                                XCTFail("Presenter was not informed to fetchForeignExchangeRate for ListOfCountries")
                        }
                }
                
        }
        
        func testSearchBarTextDidBeginEditingShouldReturnTrue() {
                let searchBar = UISearchBar()
                view.searchBar = searchBar
                view.searchBarTextDidBeginEditing(searchBar)
                XCTAssertTrue(view.isSearching)
        }
        
        func testSearchBarTextDidEndEditingShouldReturnFalse() {
                let searchBar = UISearchBar()
                view.searchBar = searchBar
                view.searchBarTextDidEndEditing(searchBar)
                XCTAssertFalse(view.isSearching)
        }
        
        func testSearchBarCancelButtonClickedShouldReturnFalse() {
                let searchBar = UISearchBar()
                view.searchBar = searchBar
                view.searchBarCancelButtonClicked(searchBar)
                XCTAssertFalse(view.isSearching)
        }
        
        func testSearchBarButtonClickedShouldReturnFalse() {
                let searchBar = UISearchBar()
                view.searchBar = searchBar
                view.searchBarCancelButtonClicked(searchBar)
                XCTAssertFalse(view.isSearching)
        }
        
        func testSearchBarTextDidChangeShouldReturnTrueIfSearchTextContinsCountryName() {
                let searchBar = UISearchBar()
                view.searchBar = searchBar
                var dictionary = [String:Any]()
                dictionary["CountryName"] = "India"
                dictionary["CountryCode"] = "IN"
                view.listOfCountries =
                        [dictionary as! Dictionary<String, String>]
                
                view.searchBar(searchBar, textDidChange: "In")
                
                XCTAssertTrue(view.isSearching)
        }
        
        func testSearchBarTextDidChangeShouldReturnFalseIfSearchTextDoesNotContinCountryName() {
                let searchBar = UISearchBar()
                view.searchBar = searchBar
                var dictionary = [String:Any]()
                dictionary["CountryName"] = "India"
                dictionary["CountryCode"] = "IN"
                view.listOfCountries =
                        [dictionary as! Dictionary<String, String>]
                
                view.searchBar(searchBar, textDidChange: "FN")
                
                XCTAssertFalse(view.isSearching)
        }
        
        func testShowListOfCoutriesShouldSetViewsListOfCountries() {
                var dictionary = [String:Any]()
                dictionary["CountryName"] = "India"
                dictionary["CountryCode"] = "IN"
                let listOfCountries =
                        [dictionary as! Dictionary<String, String>]
                view.showListOf(countries: listOfCountries)
                XCTAssertNotNil(view.listOfCountries)
                
        }
        
        func testShowForeignExchangeRateForCountryShouldSetLocalPropertiesOfViewCorrectly() {
                let fxDetails = ForeignExchangeRateDetailsObject()
                fxDetails.countryCode = "IN"
                fxDetails.fxRate = 54.6
                fxDetails.currencyCode = "INR"
                fxDetails.feesChanged = "2015-23-12 04:04:00+00"
                view.showForeignExchangeRateFor(country: fxDetails)
                
                XCTAssertEqual(view.countryCode, "IN")
                XCTAssertEqual(view.foreignExchangeRate, 54.6)
                XCTAssertEqual(view.currencyCode, "INR")
                XCTAssertEqual(view.feesChanged, "2015-23-12")
        }
        
        //MARK:- XoomForeignExchangeCurrencyRateViewToPresenterInterface Methods
        
        func fetchForeignExchangeRateFor(country: String) {
                if expectation?.description ==  "Presenter Was Informed to fetchForeignExchangeRate for filteredListOfCountries" {
                        expectation?.fulfill()
                        XCTAssertEqual("IN", country)
                }
                
                if expectation?.description == "Presenter Was Informed to fetchForeignExchangeRate for ListOfCountries" {
                        expectation?.fulfill()
                        XCTAssertEqual("IN", country)
                }
        }

}

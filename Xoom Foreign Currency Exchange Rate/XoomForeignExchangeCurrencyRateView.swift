//
//  XoomForeignExchangeCurrencyRateView.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/18/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import UIKit

class XoomForeignExchangeCurrencyRateView : UITableViewController, XoomForeignExchangeCurrencyRatePresenterToViewInterface, UISearchBarDelegate {
        
        // MARK: - VIPER Stack
        var presenter : XoomForeignExchangeCurrencyRateViewToPresenterInterface!
        
        // MARK: - Instance Variables
        
        var listOfCountries = arrayOfDictionaries()
        var filteredListOfCountries = arrayOfDictionaries()
        var isSearching = Bool()
        
        var currencyCode = ""
        var foreignExchangeRate = Double()
        var countryCode = ""
        var feesChanged = ""
        
        lazy var foreignExchangeRateView: ForeignExchangeRate = {
                return ForeignExchangeRate()
        }()
        
        lazy var service: XoomForeignExchangeRateService = {
                return XoomForeignExchangeRateService()
        }()

        // MARK: - Outlets
        @IBOutlet weak var searchBar: UISearchBar!
        
        // MARK: - Operational
        override func viewDidLoad() {
                super.viewDidLoad()
                searchBar.delegate = self
                self.navigationItem.title = "Countries"
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "segue" {
                        let destination = segue.destination as? ForeignExchangeRate
                        destination?.currencyCode = self.currencyCode
                        destination?.foreignExchangeRate = self.foreignExchangeRate
                        destination?.countryCode = self.countryCode
                        destination?.feesChanged = self.feesChanged
                }
                
        }
        
        // MARK: - Presenter to View Interface
        func showListOf(countries: arrayOfDictionaries) {
                self.listOfCountries = countries
        }
        
        func showForeignExchangeRateFor(country: ForeignExchangeRateDetailsObject) {
                self.currencyCode = country.currencyCode 
                self.foreignExchangeRate = country.fxRate
                self.countryCode = country.countryCode
               
                let index = country.feesChanged.index(country.feesChanged.startIndex, offsetBy: 10)
                self.feesChanged = country.feesChanged.substring(to: index)
                
                DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "segue", sender: nil)
                }
                
        }
        
        func showError(error: Error) {
                _ = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        }
        
        
        //MARK: - TableView Methods
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView .dequeueReusableCell(withIdentifier: "cell")
                if(!isSearching) {
                        cell?.textLabel?.text = listOfCountries[indexPath.row]["CountryName"]
                        cell?.detailTextLabel?.text = listOfCountries[indexPath.row]["CountryCode"]
                } else {
                        cell?.textLabel?.text = filteredListOfCountries[indexPath.row]["CountryName"]
                        cell?.detailTextLabel?.text = filteredListOfCountries[indexPath.row]["CountryCode"]
                }
                
                return cell!
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if isSearching {
                        return filteredListOfCountries.count
                }else {
                        return (self.listOfCountries.count)
                }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                if isSearching && !filteredListOfCountries.isEmpty {
                        self.presenter.fetchForeignExchangeRateFor(country: filteredListOfCountries[indexPath.row]["CountryCode"]!)
                } else  {
                        self.presenter.fetchForeignExchangeRateFor(country: listOfCountries[indexPath.row]["CountryCode"]!)
                }
        }
        
        //MARK: - Search Methods
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
                isSearching = true
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
                isSearching = false
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
                isSearching = false
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                isSearching = false
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
                filteredListOfCountries = listOfCountries.filter {
                        dictionary in return (dictionary["CountryName"]?.contains(searchText))!
                }
                
                if (filteredListOfCountries.count == 0) {
                        isSearching = false
                } else {
                        isSearching = true
                }
                
                tableView.reloadData()
        }
}

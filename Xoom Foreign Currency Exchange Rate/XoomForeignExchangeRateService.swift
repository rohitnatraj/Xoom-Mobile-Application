//
//  XoomForeignExchangeRateService.swift
//  Xoom Foreign Currency Exchange Rate
//
//  Created by Rohit Natraj on 5/19/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import Foundation

class XoomForeignExchangeRateService : NSObject {
        func fetchForeignExchangeRatesForCountryWith(CountryCode:String, onSuccess succes:@escaping ([String:Any]) -> (), onFailure failure:@escaping (Error) -> ()) {
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let string = "https://www.xoom.com/mapi/v1/countries/"
                let url = URL(string: string+CountryCode)!
                
                let task = session.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                                failure(error!)
                        } else {
                                do {
                                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any] {
                                                succes(json)
                                        }
                                }
                                catch {
                                        //
                                }
                        }
                }
                
                task.resume()
        }
        
}

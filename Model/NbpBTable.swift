//
//  File.swift
//  CodableNetworkingh
//
//  Created by Jacek Kosiński G on 27/11/2022.
//

import Foundation

struct NbpBTable: Codable {

    

  var table         : String?  = nil
  var id            : String?  = nil
  var effectiveDate : String?  = nil
  var rates         : [CurrencyBRate]? = []

  enum CodingKeys: String, CodingKey {

    case table         = "table"
    case id            = "no"
    case effectiveDate = "effectiveDate"
    case rates         = "rates"
  
  }
    
 


    static let example = NbpBTable(table: "B", id: "047/B/NBP/2022", effectiveDate: "2022-11-23", rates: [CurrencyBRate.example])
}

struct CurrencyBRate: Codable ,Identifiable{

  var currency : String
  var id     : String
  var mid      : Double

  enum CodingKeys: String, CodingKey {

    case currency = "currency"
    case id     = "code"
    case mid      = "mid"
  
  }
    


    static let example = CurrencyBRate(currency: "euro radzieckie",id: "EUR", mid: 4.6579)

}

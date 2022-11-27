//
//  ContentView.swift
//  CodableNetworkingh
//
//  Created by Jacek Kosiński G on 27/11/2022.
//

import SwiftUI
import Foundation



struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Fetch data"){
        
                let nbpUrl = URL(string: "https://api.nbp.pl/api/exchangerates/tables/B/")!
                self.fetch(nbpUrl)
            }
        }
        .padding()
    }
    
    func fetch(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Something wrong while fetching data ")
            } else if let data = data {
                
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode([NbpTableB].self, from: data)
                    print(result)
                } catch {
                    print("Something wrong while decoding data")
                }
            }
        }.resume()
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NbpTableB: Codable {

  var table         : String?  = nil
  var no            : String?  = nil
  var effectiveDate : String?  = nil
  //var rates         : [Rates]? = []

  enum CodingKeys: String, CodingKey {

    case table         = "table"
    case no            = "no"
    case effectiveDate = "effectiveDate"
 //   case rates         = "rates"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    table         = try values.decodeIfPresent(String.self  , forKey: .table         )
    no            = try values.decodeIfPresent(String.self  , forKey: .no            )
    effectiveDate = try values.decodeIfPresent(String.self  , forKey: .effectiveDate )
  //  rates         = try values.decodeIfPresent([Rates].self , forKey: .rates         )
 
  }

  init() {

  }

}

struct Rates: Codable {

  var currency : String? = nil
  var code     : String? = nil
  var mid      : Double? = nil

  enum CodingKeys: String, CodingKey {

    case currency = "currency"
    case code     = "code"
    case mid      = "mid"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    currency = try values.decodeIfPresent(String.self , forKey: .currency )
    code     = try values.decodeIfPresent(String.self , forKey: .code     )
    mid      = try values.decodeIfPresent(Double.self , forKey: .mid      )
 
  }

  init() {

  }

}

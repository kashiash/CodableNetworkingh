//
//  ContentView.swift
//  CodableNetworkingh
//
//  Created by Jacek Kosiński G on 27/11/2022.
//

import SwiftUI
import Combine
import Foundation



struct ContentView: View {
    @State private var requests = Set<AnyCancellable>()
    @State private var rates = [CurrencyBRate]()
    @State private var loadState = LoadState.loading
    
    enum LoadState {
        case loading, success, failed
    }
    
    var body: some View {

                VStack {
                    Image("NBP1")
                        .scaledToFit()
                    Text("Jaszczomp pozdrawia!")
                    
                    
                    List(rates) {rate in
                        NavigationLink {
                         //   CurrencyDetail(rate:rate)
                        } label: {
                            HStack{
                                Text(rate.id).font(.title)
                      
                                Text(rate.currency).font(.callout)
                                
                                Text(String(format: "%.4f", rate.mid))
                                    .foregroundColor(.red)
                                    .background{
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .stroke(Color.white.opacity(0.2),lineWidth: 1)
                                    }
                            }
                        }
                        .padding()
                        .font(.callout)
                    }
                }
         

   
    

        .navigationTitle("Kusy Walut NBP")
        .task(downloadCurrencyTable)
        .refreshable(action: downloadCurrencyTable)
    }
    
 

    
    @Sendable func downloadCurrencyTable() async {
        do {
            let nbpUrl = URL(string: "https://api.nbp.pl/api/exchangerates/tables/B/")!
            fetch(nbpUrl, defaultValue: [NbpBTable.example]) {
                
                if ($0[0].rates != nil){
                    rates = $0[0].rates!
                }
                
            }
        }
    }
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()
        
       
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(2)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






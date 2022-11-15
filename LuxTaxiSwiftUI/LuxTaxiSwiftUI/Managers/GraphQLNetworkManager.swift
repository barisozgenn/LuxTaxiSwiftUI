//
//  GraphQLNetworkManager.swift
//  BowlShopSwiftUI
//
//  Created by Baris OZGEN on 1.11.2022.
//

import Foundation
import Combine
import Apollo

class GraphQLNetworkManager {
    
    static let shared = GraphQLNetworkManager()
    lazy var apolloClient : ApolloClient =  ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    
    private init(){
    }
}

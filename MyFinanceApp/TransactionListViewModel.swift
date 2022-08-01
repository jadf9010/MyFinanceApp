//
//  TransactionListViewModel.swift
//  MyFinanceApp
//
//  Created by Javier Alejandro Domínguez Falcón on 1/8/22.
//

import Foundation

final class TransactionListViewModel : ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func getTransactions() {
        
    }
}

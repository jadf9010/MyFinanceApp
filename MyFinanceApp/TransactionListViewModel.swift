//
//  TransactionListViewModel.swift
//  MyFinanceApp
//
//  Created by Javier Alejandro Domínguez Falcón on 1/8/22.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel : ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
       
        guard let url = URL(string: "https://mockend.com/jadf9010/MyFinanceApp/posts") else { fatalError("Missing URL") }

            let urlRequest = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        do {
                            let decodedTransactions = try JSONDecoder().decode([Transaction].self, from: data)
                            self.transactions = decodedTransactions                            
                         } catch let error {
                            print("Error decoding Transactions: ", error)
                        }
                    }
                }
            }

            dataTask.resume()
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:]}
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupedTransactions
    }
    
    func accumulateTransaction() -> TransactionPrefixSum {
        print("Accumulate transactions ")
        guard !transactions.isEmpty else { return [] }
        
        let today = "09/17/2021".dateParse() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("DateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter{ $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum;
    }
}

//
//  MyFinanceAppApp.swift
//  MyFinanceApp
//
//  Created by Javier Alejandro Domínguez Falcón on 1/8/22.
//

import SwiftUI

@main
struct MyFinanceAppApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            //CustomContentView()
              //  .environment(\.managedObjectContext, persistenceController.container.viewContext)
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}

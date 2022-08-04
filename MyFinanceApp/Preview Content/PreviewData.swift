//
//  PreviewData.swift
//  MyFinanceApp
//
//  Created by Javier Alejandro Domínguez Falcón on 1/8/22.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "UCI", account: "Visa UCI", merchant: "Apple", amount: 20.45, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)

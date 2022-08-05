//
//  Extensions.swift
//  MyFinanceApp
//
//  Created by Javier Alejandro Domínguez Falcón on 1/8/22.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systembackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing Date formatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func dateParse() -> Date {
        guard let parseDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parseDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.month().day())
    }
}

extension Double {
    func roundedTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}

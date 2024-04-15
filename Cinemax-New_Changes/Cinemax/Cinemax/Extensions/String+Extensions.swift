//
//  String+Extensions.swift
//  Cinemax
//
//  Created by IPS-161 on 30/01/24.
//

import Foundation

public extension String {
    func isEmailValid() -> Bool {
        let regex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let pattern = NSPredicate(format: "SELF MATCHES %@", regex)
        return pattern.evaluate(with: self)
    }
}

public extension String {
    func isPasswordValid() -> Bool {
        return self.count >= 6
    }
}

public extension String {
    func extractYearFromDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        } else {
            print("Error: Unable to parse date string \(self)")
            return nil
        }
    }
}

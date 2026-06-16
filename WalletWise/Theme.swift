//
//  Theme.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

enum AppColor {
    static let background = Color(hex: "23094E")
    static let cardBackground = Color(hex: "432D69")
    static let secondaryBackground = Color(hex: "ECE8FF")
    static let accent = Color(hex: "C3FF23")
    static let primaryText = Color(hex: "F9F8FF")
    static let darkText = Color(hex: "23094E")
}

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        let scanner = Scanner(string: hexString)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

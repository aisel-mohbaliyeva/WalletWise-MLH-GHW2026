//
//  Currency.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import Foundation

struct AppCurrency: Identifiable, Hashable, Codable {
    var id: String { code }
    let code: String
    let name: String
    let symbol: String
    
    static let all: [AppCurrency] = [
        AppCurrency(code: "AED", name: "UAE Dirham", symbol: "AED"),
        AppCurrency(code: "AUD", name: "Australian Dollar", symbol: "A$"),
        AppCurrency(code: "AZN", name: "Azerbaijani Manat", symbol: "₼"),
        AppCurrency(code: "BRL", name: "Brazilian Real", symbol: "R$"),
        AppCurrency(code: "CAD", name: "Canadian Dollar", symbol: "CA$"),
        AppCurrency(code: "CHF", name: "Swiss Franc", symbol: "CHF"),
        AppCurrency(code: "CNY", name: "Chinese Yuan", symbol: "¥"),
        AppCurrency(code: "EGP", name: "Egyptian Pound", symbol: "E£"),
        AppCurrency(code: "EUR", name: "Euro", symbol: "€"),
        AppCurrency(code: "GBP", name: "British Pound", symbol: "£"),
        AppCurrency(code: "GEL", name: "Georgian Lari", symbol: "₾"),
        AppCurrency(code: "HKD", name: "Hong Kong Dollar", symbol: "HK$"),
        AppCurrency(code: "ILS", name: "Israeli New Shekel", symbol: "₪"),
        AppCurrency(code: "INR", name: "Indian Rupee", symbol: "₹"),
        AppCurrency(code: "JPY", name: "Japanese Yen", symbol: "¥"),
        AppCurrency(code: "KRW", name: "South Korean Won", symbol: "₩"),
        AppCurrency(code: "KZT", name: "Kazakhstani Tenge", symbol: "₸"),
        AppCurrency(code: "MXN", name: "Mexican Peso", symbol: "MX$"),
        AppCurrency(code: "NGN", name: "Nigerian Naira", symbol: "₦"),
        AppCurrency(code: "NOK", name: "Norwegian Krone", symbol: "kr"),
        AppCurrency(code: "PLN", name: "Polish Zloty", symbol: "zł"),
        AppCurrency(code: "RUB", name: "Russian Ruble", symbol: "₽"),
        AppCurrency(code: "SAR", name: "Saudi Riyal", symbol: "SR"),
        AppCurrency(code: "SEK", name: "Swedish Krona", symbol: "kr"),
        AppCurrency(code: "SGD", name: "Singapore Dollar", symbol: "S$"),
        AppCurrency(code: "THB", name: "Thai Baht", symbol: "฿"),
        AppCurrency(code: "TRY", name: "Turkish Lira", symbol: "₺"),
        AppCurrency(code: "UAH", name: "Ukrainian Hryvnia", symbol: "₴"),
        AppCurrency(code: "USD", name: "US Dollar", symbol: "$"),
        AppCurrency(code: "ZAR", name: "South African Rand", symbol: "R"),
    ]

    static let defaultCurrency = all.first { $0.code == "USD" } ?? AppCurrency(code: "USD", name: "US Dollar", symbol: "$")
}

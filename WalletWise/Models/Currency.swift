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
        AppCurrency(code: "USD", name: "US Dollar", symbol: "$"),
        AppCurrency(code: "EUR", name: "Euro", symbol: "€"),
        AppCurrency(code: "AZN", name: "Azerbaijani Manat", symbol: "₼"),
        AppCurrency(code: "TRY", name: "Turkish Lira", symbol: "₺"),
        AppCurrency(code: "GBP", name: "British Pound", symbol: "£"),
        AppCurrency(code: "RUB", name: "Russian Ruble", symbol: "₽"),
        AppCurrency(code: "GEL", name: "Georgian Lari", symbol: "₾"),
        AppCurrency(code: "UAH", name: "Ukrainian Hryvnia", symbol: "₴"),
        AppCurrency(code: "KZT", name: "Kazakhstani Tenge", symbol: "₸"),
        AppCurrency(code: "JPY", name: "Japanese Yen", symbol: "¥"),
        AppCurrency(code: "CNY", name: "Chinese Yuan", symbol: "¥"),
        AppCurrency(code: "KRW", name: "South Korean Won", symbol: "₩"),
        AppCurrency(code: "INR", name: "Indian Rupee", symbol: "₹"),
        AppCurrency(code: "BRL", name: "Brazilian Real", symbol: "R$"),
        AppCurrency(code: "CAD", name: "Canadian Dollar", symbol: "C$"),
        AppCurrency(code: "AUD", name: "Australian Dollar", symbol: "A$"),
        AppCurrency(code: "CHF", name: "Swiss Franc", symbol: "Fr"),
        AppCurrency(code: "SEK", name: "Swedish Krona", symbol: "kr"),
        AppCurrency(code: "NOK", name: "Norwegian Krone", symbol: "kr"),
        AppCurrency(code: "PLN", name: "Polish Zloty", symbol: "zł"),
        AppCurrency(code: "SAR", name: "Saudi Riyal", symbol: "﷼"),
        AppCurrency(code: "AED", name: "UAE Dirham", symbol: "د.إ"),
        AppCurrency(code: "ILS", name: "Israeli Shekel", symbol: "₪"),
        AppCurrency(code: "MXN", name: "Mexican Peso", symbol: "$"),
        AppCurrency(code: "SGD", name: "Singapore Dollar", symbol: "S$"),
        AppCurrency(code: "HKD", name: "Hong Kong Dollar", symbol: "HK$"),
        AppCurrency(code: "THB", name: "Thai Baht", symbol: "฿"),
        AppCurrency(code: "ZAR", name: "South African Rand", symbol: "R"),
        AppCurrency(code: "EGP", name: "Egyptian Pound", symbol: "E£"),
        AppCurrency(code: "NGN", name: "Nigerian Naira", symbol: "₦"),
    ]
    
    static let defaultCurrency = all[0]
}

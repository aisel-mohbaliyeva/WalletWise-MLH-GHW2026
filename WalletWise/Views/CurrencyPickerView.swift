//
//  CurrencyPickerView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct CurrencyPickerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedCurrency: AppCurrency
    @State private var searchText = ""
    
    private var filtered: [AppCurrency] {
        if searchText.isEmpty { return AppCurrency.all }
        return AppCurrency.all.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.code.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.background
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filtered) { currency in
                            Button {
                                selectedCurrency = currency
                                dismiss()
                            } label: {
                                HStack(spacing: 14) {
                                    Text(currency.symbol)
                                        .font(.title2)
                                        .frame(width: 44, height: 44)
                                        .background(selectedCurrency.code == currency.code ? AppColor.accent : AppColor.background)
                                        .foregroundStyle(selectedCurrency.code == currency.code ? AppColor.darkText : AppColor.primaryText)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(currency.code)
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(AppColor.primaryText)
                                        Text(currency.name)
                                            .font(.caption)
                                            .foregroundStyle(AppColor.primaryText.opacity(0.5))
                                    }
                                    
                                    Spacer()
                                    
                                    if selectedCurrency.code == currency.code {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(AppColor.accent)
                                            .fontWeight(.bold)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                            }
                            
                            Divider()
                                .overlay(AppColor.primaryText.opacity(0.06))
                                .padding(.leading, 78)
                        }
                    }
                }
            }
            .navigationTitle("Currency")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $searchText, prompt: "Search currency")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(AppColor.primaryText)
                }
            }
        }
    }
}

#Preview {
    CurrencyPickerView(selectedCurrency: .constant(.defaultCurrency))
}

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
                AppColor.secondaryBackground
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
                                        .background(selectedCurrency.code == currency.code ? AppColor.accent : .white)
                                        .foregroundStyle(selectedCurrency.code == currency.code ? AppColor.darkText : AppColor.background)
                                        .clipShape(Circle())

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(currency.code)
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(AppColor.darkText)
                                        Text(currency.name)
                                            .font(.caption)
                                            .foregroundStyle(AppColor.background.opacity(0.4))
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
                                .overlay(AppColor.background.opacity(0.06))
                                .padding(.leading, 78)
                        }
                    }
                }
            }
            .navigationTitle("Currency")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.light)
            .searchable(text: $searchText, prompt: "Search currency")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(AppColor.background.opacity(0.6))
                }
            }
        }
    }
}

#Preview {
    CurrencyPickerView(selectedCurrency: .constant(.defaultCurrency))
}

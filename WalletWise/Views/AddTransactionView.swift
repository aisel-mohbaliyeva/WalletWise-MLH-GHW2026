//
//  AddTransactionView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    var viewModel: WalletViewModel

    @State private var title = ""
    @State private var amount = ""
    @State private var category: Category = .market
    @State private var isIncome = false

    private var sanitizedAmount: Double? {
        Double(amount.replacingOccurrences(of: ",", with: "."))
    }

    private var isFormValid: Bool {
        guard let value = sanitizedAmount else { return false }
        return !title.trimmingCharacters(in: .whitespaces).isEmpty && value > 0
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.secondaryBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

                        // Amount
                        VStack(spacing: 10) {
                            Text("ENTER AMOUNT")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .tracking(2)
                                .foregroundStyle(AppColor.background.opacity(0.4))

                            ZStack(alignment: .trailing) {
                                TextField("0.00", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .font(.system(size: 48, weight: .black, design: .rounded))
                                    .foregroundStyle(AppColor.background)
                                    .multilineTextAlignment(.center)

                                if !amount.isEmpty {
                                    Button {
                                        amount = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(AppColor.background.opacity(0.2))
                                    }
                                }
                            }
                        }
                        .padding(28)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(AppColor.background.opacity(0.08), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(color: AppColor.background.opacity(0.06), radius: 12, y: 4)
                        .padding(.horizontal)

                        // Details
                        VStack(alignment: .leading, spacing: 16) {
                            ZStack(alignment: .trailing) {
                                TextField("Merchant / Description", text: $title)
                                    .padding(16)
                                    .padding(.trailing, 32)
                                    .background(AppColor.secondaryBackground)
                                    .foregroundStyle(AppColor.darkText)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(AppColor.background.opacity(0.06), lineWidth: 1)
                                    )

                                if !title.isEmpty {
                                    Button {
                                        title = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(AppColor.background.opacity(0.2))
                                    }
                                    .padding(.trailing, 14)
                                }
                            }

                            HStack(spacing: 10) {
                                typeButton(label: "Expense", icon: "arrow.up", isSelected: !isIncome) {
                                    isIncome = false
                                }
                                typeButton(label: "Income", icon: "arrow.down", isSelected: isIncome) {
                                    isIncome = true
                                }
                            }
                        }
                        .padding(20)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(AppColor.background.opacity(0.06), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: AppColor.background.opacity(0.06), radius: 12, y: 4)
                        .padding(.horizontal)

                        // Category
                        VStack(alignment: .leading, spacing: 16) {
                            Text("SELECT CATEGORY")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .tracking(2)
                                .foregroundStyle(AppColor.background.opacity(0.4))

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                                ForEach(Category.allCases, id: \.self) { cat in
                                    categoryItem(cat)
                                }
                            }
                        }
                        .padding(20)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(AppColor.background.opacity(0.06), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: AppColor.background.opacity(0.06), radius: 12, y: 4)
                        .padding(.horizontal)

                        // Save
                        Button {
                            saveTransaction()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                Text("Save Transaction")
                                    .fontWeight(.bold)
                            }
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(isFormValid ? AppColor.accent : AppColor.background.opacity(0.08))
                            .foregroundStyle(isFormValid ? AppColor.darkText : AppColor.background.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: isFormValid ? AppColor.accent.opacity(0.3) : .clear, radius: 12, y: 4)
                        }
                        .disabled(!isFormValid)
                        .padding(.horizontal)
                        .padding(.top, 4)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.light)
            .onChange(of: title) { _, newValue in
                if newValue.count > 40 {
                    title = String(newValue.prefix(40))
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(AppColor.background.opacity(0.6))
                }
            }
        }
    }

    private func typeButton(label: String, icon: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                Text(label)
                    .fontWeight(.bold)
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(isSelected ? AppColor.accent : AppColor.secondaryBackground)
            .foregroundStyle(isSelected ? AppColor.darkText : AppColor.background.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }

    @ViewBuilder
    private func categoryItem(_ cat: Category) -> some View {
        let isSelected = category == cat

        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                category = cat
            }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: cat.icon)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(isSelected ? .white : cat.color)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                isSelected
                                ? LinearGradient(colors: [cat.color, cat.color.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                : LinearGradient(colors: [cat.color.opacity(0.15), cat.color.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [.white.opacity(isSelected ? 0.25 : 0.08), .clear],
                                    startPoint: .top,
                                    endPoint: .center
                                )
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: isSelected ? cat.color.opacity(0.4) : .clear, radius: 8, y: 3)
                    .scaleEffect(isSelected ? 1.1 : 1.0)

                Text(cat.rawValue)
                    .font(.caption2)
                    .fontWeight(isSelected ? .bold : .medium)
                    .foregroundStyle(isSelected ? cat.color : AppColor.background.opacity(0.5))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
    }

    private func saveTransaction() {
        guard let parsedAmount = sanitizedAmount, parsedAmount > 0 else { return }
        let transaction = Transaction(
            title: title.trimmingCharacters(in: .whitespaces),
            amount: parsedAmount,
            category: category,
            isIncome: isIncome
        )
        viewModel.addTransaction(transaction, context: modelContext)
        dismiss()
    }
}

#Preview {
    AddTransactionView(viewModel: WalletViewModel())
        .modelContainer(for: Transaction.self, inMemory: true)
}

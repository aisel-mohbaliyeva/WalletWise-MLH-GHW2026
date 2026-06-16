//
//  CalendarView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct CalendarView: View {

    @Environment(\.dismiss) private var dismiss
    var viewModel: WalletViewModel
    var currencyCode: String

    @State private var selectedDate = Date()
    @State private var displayedMonth = Date()

    private let calendar = Calendar.current

    private var weekdays: [String] {
        let symbols = calendar.shortWeekdaySymbols
        let firstWeekday = calendar.firstWeekday - 1
        return Array(symbols[firstWeekday...]) + Array(symbols[..<firstWeekday])
    }

    private var monthTitle: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }

    private var transactionsForSelectedDate: [Transaction] {
        viewModel.transactions.filter {
            calendar.isDate($0.date, inSameDayAs: selectedDate)
        }
    }

    private var monthDates: [Date?] {
        var components = calendar.dateComponents([.year, .month], from: displayedMonth)
        components.day = 1
        guard let firstDay = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDay) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let offset = (firstWeekday - calendar.firstWeekday + 7) % 7

        var dates: [Date?] = Array(repeating: nil, count: offset)

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                dates.append(date)
            }
        }

        while dates.count % 7 != 0 {
            dates.append(nil)
        }

        return dates
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.secondaryBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        monthNavigationHeader

                        calendarGrid

                        transactionList
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.light)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(AppColor.background.opacity(0.6))
                }
            }
        }
    }

    private var monthNavigationHeader: some View {
        HStack {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColor.background)
            }
            .accessibilityLabel("Previous month")

            Spacer()

            Text(monthTitle.uppercased())
                .font(.subheadline)
                .fontWeight(.bold)
                .tracking(1)
                .foregroundStyle(AppColor.background)

            Spacer()

            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColor.background)
            }
            .accessibilityLabel("Next month")
        }
        .padding(.horizontal, 24)
    }

    private var calendarGrid: some View {
        VStack(spacing: 12) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(AppColor.background.opacity(0.4))
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(Array(monthDates.enumerated()), id: \.offset) { _, date in
                    if let date {
                        dayCell(for: date)
                    } else {
                        Text("")
                            .frame(height: 44)
                    }
                }
            }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColor.background.opacity(0.06), radius: 12, y: 4)
        .padding(.horizontal)
    }

    private var transactionList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(selectedDate.formatted(.dateTime.month(.wide).day().year()).uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .tracking(2)
                .foregroundStyle(AppColor.background.opacity(0.4))
                .padding(.horizontal, 24)

            if transactionsForSelectedDate.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "tray")
                        .font(.title)
                        .foregroundStyle(AppColor.background.opacity(0.15))
                    Text("No transactions on this date")
                        .font(.caption)
                        .foregroundStyle(AppColor.background.opacity(0.3))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(transactionsForSelectedDate.enumerated()), id: \.element.id) { index, transaction in
                        transactionRow(transaction)
                        if index < transactionsForSelectedDate.count - 1 {
                            Divider()
                                .overlay(AppColor.background.opacity(0.06))
                                .padding(.leading, 74)
                        }
                    }
                }
                .padding(.vertical, 8)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: AppColor.background.opacity(0.06), radius: 12, y: 4)
                .padding(.horizontal)
            }
        }
    }

    @ViewBuilder
    private func dayCell(for date: Date) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        let isToday = calendar.isDateInToday(date)
        let hasData = viewModel.transactions.contains { calendar.isDate($0.date, inSameDayAs: date) }

        Button {
            withAnimation(.spring(response: 0.3)) {
                selectedDate = date
            }
        } label: {
            VStack(spacing: 2) {
                Text("\(calendar.component(.day, from: date))")
                    .font(.subheadline)
                    .fontWeight(isSelected || isToday ? .bold : .regular)
                    .foregroundStyle(
                        isSelected ? .white :
                            isToday ? AppColor.accent :
                            AppColor.background
                    )

                Circle()
                    .fill(hasData ? (isSelected ? .white : AppColor.accent) : .clear)
                    .frame(width: 5, height: 5)
            }
            .frame(width: 38, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        isSelected ? AppColor.background :
                            isToday ? AppColor.accent.opacity(0.1) :
                            .clear
                    )
            )
        }
        .accessibilityLabel("\(date.formatted(.dateTime.month(.wide).day()))\(isToday ? ", today" : "")\(hasData ? ", has transactions" : "")")
    }

    private func transactionRow(_ transaction: Transaction) -> some View {
        HStack(spacing: 14) {
            Image(systemName: transaction.category.icon)
                .font(.body)
                .foregroundStyle(transaction.category.color)
                .frame(width: 44, height: 44)
                .background(transaction.category.color.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColor.darkText)
                    .lineLimit(1)
                Text(transaction.category.rawValue)
                    .font(.caption2)
                    .foregroundStyle(AppColor.background.opacity(0.4))
            }

            Spacer()

            Text("\(transaction.isIncome ? "+" : "-")\(transaction.amount, format: .currency(code: currencyCode))")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(transaction.isIncome ? AppColor.accent : .red)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }
}

#Preview {
    CalendarView(viewModel: WalletViewModel(), currencyCode: "USD")
}

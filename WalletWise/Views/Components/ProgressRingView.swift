//
//  ProgressRingView.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct ProgressRingView: View {
    
    var progress: Double
    var totalBudget: Double
    var spent: Double
    var lineWidth: CGFloat = 16
    
    private var remainingBudget: Double {
        max(totalBudget - spent, 0)
    }
    
    private var ringColor: Color {
        if progress < 0.5 {
            return .green
        } else if progress < 0.8 {
            return .orange
        } else {
            return .red
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(ringColor.opacity(0.2), lineWidth: lineWidth)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(ringColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 4) {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                    Text("spent")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 140, height: 140)
            
            VStack(spacing: 4) {
                Text("Monthly Budget")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(remainingBudget, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("remaining")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ProgressRingView(progress: 0.65, totalBudget: 1000, spent: 650)
        .padding()
        .background(Color.black)
}

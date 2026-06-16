//
//  SwipeableRow.swift
//  WalletWise
//
//  Created by Aysel Mohbaliyeva on 16.06.26.
//

import SwiftUI

struct SwipeableRow<Content: View>: View {

    @ViewBuilder let content: () -> Content
    let onDelete: () -> Void

    @State private var baseOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0

    private var totalOffset: CGFloat {
        min(0, max(-80, baseOffset + dragOffset))
    }

    private var isRevealed: Bool {
        totalOffset < -15
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onDelete()
                }
            } label: {
                Image(systemName: "trash")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 46, height: 46)
                    .background(Color.red.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
            }
            .accessibilityLabel("Delete transaction")
            .padding(.trailing, 12)
            .opacity(isRevealed ? 1 : 0)
            .scaleEffect(isRevealed ? 1 : 0.4)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isRevealed)

            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColor.cardBackground)
                .offset(x: totalOffset)
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onChanged { value in
                            if abs(value.translation.width) > abs(value.translation.height) {
                                dragOffset = value.translation.width
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                baseOffset = totalOffset < -35 ? -70 : 0
                                dragOffset = 0
                            }
                        }
                )
                .onTapGesture {
                    if baseOffset < 0 {
                        withAnimation(.spring(response: 0.3)) {
                            baseOffset = 0
                            dragOffset = 0
                        }
                    }
                }
        }
    }
}

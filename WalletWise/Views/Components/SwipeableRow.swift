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

    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        onDelete()
                    }
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundStyle(.white)
                        .font(.body)
                        .frame(width: 70)
                        .frame(maxHeight: .infinity)
                        .background(Color.red)
                }
            }

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
        .clipShape(Rectangle())
    }
}

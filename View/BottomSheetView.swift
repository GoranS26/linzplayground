//
//  BottomSheetView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 30.07.25.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    
    let heightRange: ClosedRange<CGFloat>
    let content: Content

    @GestureState private var dragOffset = CGFloat.zero
    @Binding var currentHeight: CGFloat

    init(height: ClosedRange<CGFloat>, currentHeight: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.heightRange = height
        self._currentHeight = currentHeight
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                content
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity)
            }
            .frame(width: geo.size.width, height: currentHeight, alignment: .top)
            .background(.ultraThinMaterial)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(radius: 6)
            .offset(y: currentHeight == 0
                    ? geo.size.height
                    : geo.size.height - currentHeight + dragOffset)
            .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.8), value: currentHeight)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let newHeight = currentHeight - value.translation.height
                        withAnimation {
                            let midpoint = (heightRange.lowerBound + heightRange.upperBound) / 2
                            if newHeight < midpoint {
                                currentHeight = heightRange.lowerBound
                            } else {
                                currentHeight = heightRange.upperBound
                            }
                        }
                    }
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

fileprivate extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

fileprivate struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

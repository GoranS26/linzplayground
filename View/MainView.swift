import SwiftUI

struct MainView: View {
    
    @State private var animateImage = false
    @State private var animateText = false
    @State private var showButton = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.indigo, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                
                ZStack {
                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: -150, y: -250)
                        .blur(radius: 1)
                    
                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 20, y: -200)
                        .blur(radius: 1)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: -160, y: 100)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 130, y: 370)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 140, y: 60)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 100, y: -350)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: -90, y: 300)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 100, y: -100)
                }
                .blur(radius: 0.4)
                .ignoresSafeArea()

                // Main content
                VStack(spacing: 20) {
                    VStack(spacing: 0) {
                        Text("OFF LEASH")
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                            .opacity(animateText ? 1 : 0)
                            .offset(y: animateText ? 0 : -40)
                            .animation(.easeOut(duration: 1.2), value: animateText)

                        Text("LINZ")
                            .font(.system(size: 40, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                            .opacity(animateText ? 1 : 0)
                            .offset(y: animateText ? 0 : -40)
                            .animation(.easeOut(duration: 1.4).delay(0.2), value: animateText)
                    }

                    Spacer()

                    Image("doglocation")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .shadow(radius: 10)
                        .blur(radius: animateImage ? 0 : 20)
                        .opacity(animateImage ? 1 : 0)
                        .scaleEffect(animateImage ? 1 : 0.9)
                        .animation(.easeOut(duration: 2.0), value: animateImage)

                    Spacer()

                    Text("Find off-leash dog zones nearby")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        .opacity(animateText ? 1 : 0)
                        .offset(y: animateText ? 0 : 20)
                        .animation(.easeInOut(duration: 1.5).delay(0.5), value: animateText)

                    if showButton {
                        NavigationLink(destination: DashboardView()) {
                            Text("GET STARTED")
                                .font(.system(size: 20, weight: .bold, design: .monospaced))
                                .padding()
                                .frame(width: 220)
                                .background(
                                    Color.indigo.opacity(0.7)
                                )
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .shadow(color: .indigo.opacity(0.5), radius: 10, x: 0, y: 10)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }

                    Spacer()
                }
                .padding()
            }
            .onAppear {
                animateImage = true
                animateText = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                        showButton = true
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}

//
//  SplashScreen.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/19.
//

import SwiftUI
import DotLottie

struct SplashScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = SplashViewModel()
    @State private var navigationPath = NavigationPath()
    
    var isDarkMode: Bool {
        colorScheme == .dark
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 200)
            Image(systemName: "cloud.snow.fill")
                .resizable()
                .foregroundColor(Color(.colorFirst))
                .offset(x: 10, y: 10)
                .padding(16)
                .aspectRatio(contentMode: .fill)
                .frame(width: 128, height: 128)
            Spacer()
            DotLottieAnimation(
                fileName: "splash",
                config: AnimationConfig(autoplay: true, loop: true)
            ).view()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        }
        .background(Color.bgSplash)
        .ignoresSafeArea()
        .onAppear {
            viewModel.onLoad()
        }
        .onChange(of: viewModel.uiEvent) { _, newValue in
            if newValue == "main" {
                MainScreen.present()
            }
        }
    }
}

#Preview {
    SplashScreen().environment(\.colorScheme, .light)
}

#Preview {
    SplashScreen().environment(\.colorScheme, .dark)
}


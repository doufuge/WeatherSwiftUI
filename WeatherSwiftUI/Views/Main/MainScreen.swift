//
//  MainScreen.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/20.
//

import SwiftUI
import DotLottie

struct MainScreen: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    static func present() {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController = UIHostingController(rootView: MainScreen())
    }
    
    var body: some View {
        ZStack {
            if viewModel.showTable {
                TableChart(data: $viewModel.data)
            } else {
                LineChart(data: $viewModel.data)
            }
            
            ZStack(alignment: .top) {
                ActionBar(showTable: $viewModel.showTable) { tag in
                    if tag == "reload" {
                        viewModel.fetchWeather()
                    } else {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.toggleViewMode()
                        }
                    }
                }
                Spacer()
                    .frame(maxHeight: .infinity)
                TipBar(tipOptions: $viewModel.tipOptions) {
                    viewModel.onTipShow()
                }
            }
            
            LottieHud(show: $viewModel.loading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.bgPage))
    }
}

struct TipBar: View {
    @Binding var tipOptions: TipOptions
    var onTipShow: () -> Void
    var body: some View {
        if tipOptions.show {
            Text(tipOptions.tip)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 44)
                .background(Color.yellow)
                .transition(.move(edge: .top))
                .onAppear { onTipShow() }
        }
    }
}

struct LottieHud: View {
    @Binding var show: Bool
    var body: some View {
        if show {
            ZStack {
                DotLottieAnimation(
                    fileName: "hud",
                    config: AnimationConfig(autoplay: true, loop: true)
                )
                .view()
                .frame(width: 64, height: 64)
            }
            .frame(width: 128, height: 128)
            .background(Color(.bgPop))
            .cornerRadius(12)
        }
    }
}

struct ActionBar: View {
    @Binding var showTable: Bool
    var action: (_ tag: String) -> Void
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Text("Weather")
                .frame(maxWidth: .infinity, alignment: .center)
           
            HStack {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .foregroundColor(Color(.colorFirst))
                    .padding(8)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        action("reload")
                    }
                Image(systemName: showTable ? "chart.xyaxis.line" : "list.bullet")
                    .resizable()
                    .foregroundColor(Color(.colorFirst))
                    .padding(8)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        action("toggleView")
                    }
            }
            .padding(.trailing, 8)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

#Preview("LottieHud") {
    LottieHud(show: .constant(true))
}

#Preview("TipBar") {
    TipBar(tipOptions: .constant(TipOptions(show: true, tip: "Load Success"))) {
    }
}

#Preview("ActionBar") {
    ActionBar(showTable: .constant(true)) { tag in
    }
    ActionBar(showTable: .constant(false)) { tag in
    }
}

#Preview {
    MainScreen()
}

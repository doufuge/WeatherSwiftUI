//
//  LineChart.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/21.
//

import SwiftUI

struct LineChart: View {
    @Binding var data: [WeatherItem]
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            AxisView(data: data)
            XLabels(data: data.map({ $0.hour }))
            YLabels()
            WeatherPath(data: data.map({ $0.temp }))
        }
        .scaleEffect(scale)
        .offset(x: offset.width, y: offset.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = CGSize(width: lastOffset.width + value.translation.width, height: lastOffset.height + value.translation.height)
                }
                .onEnded { value in
                    lastOffset = offset
                }
        )
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    scale = min(max(value, 0.3), 3.0)
                }
                .onEnded { _ in
                    lastScale = scale
                }
        )
    }
}

struct AxisView: View {
    var data: [WeatherItem]
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: LineChartConfig.startX, y: LineChartConfig.startY - 4 * LineChartConfig.yStep))
            path.addLine(to: CGPoint(x: LineChartConfig.startX, y: LineChartConfig.startY))
            path.addLine(to: CGPoint(x: (data.count + 1) * LineChartConfig.xStep, y: LineChartConfig.startY))
        }
        .stroke(Color.red, lineWidth: 1)
    }
}

struct XLabels: View {
    var data: [String]
    var body: some View {
        Canvas { context, size in
            data.enumerated().forEach { index, item in
                print(item)
                let text = Text(TimeUtil.formatHour(item))
                    .font(.system(size: 12))
                    .foregroundColor(.blue)
                context.draw(text, at: CGPoint(x: 12 + LineChartConfig.startX + index * LineChartConfig.xStep, y: LineChartConfig.startY + 12))
            }
        }
        .frame(width: CGFloat(data.count * LineChartConfig.xStep) + 300)
    }
}

struct YLabels: View {
    var body: some View {
        Canvas { context, size in
            for i in 0..<5 {
                let text = Text("\(i * 10)")
                    .font(.system(size: 12))
                    .foregroundColor(.blue)
                context.draw(text, at: CGPoint(x: LineChartConfig.startX - 12, y: LineChartConfig.startY - i * LineChartConfig.yStep))
            }
        }
    }
}

struct WeatherPath: View {
    var data: [Double]
    var body: some View {
        if !data.isEmpty {
            Path { path in
                path.move(to: CGPoint(x: LineChartConfig.startX, y: LineChartConfig.startY - Int(5 * (data.first ?? 0))))
                data.enumerated().forEach { index, temp in
                    path.addLine(to: CGPoint(x: LineChartConfig.startX + index * LineChartConfig.xStep, y: LineChartConfig.startY - Int(temp * 5)))
                }
            }
            .stroke(Color.green, lineWidth: 1)
        } else {
            EmptyView()
        }
        
    }
}

struct LineChartConfig {
    static let startX = 50
    static let startY = 400
    static let xStep = 30
    static let yStep = 50
}

#Preview {
    LineChart(data: .constant([
        WeatherItem(hour: "2025-02-21T00:00", temp: 10.0),
        WeatherItem(hour: "2025-02-21T01:00", temp: 12.0),
        WeatherItem(hour: "2025-02-21T02:00", temp: 11.0),
        WeatherItem(hour: "2025-02-21T03:00", temp: 12.0),
        WeatherItem(hour: "2025-02-21T04:00", temp: 13.0),
        WeatherItem(hour: "2025-02-21T05:00", temp: 15.0),
        WeatherItem(hour: "2025-02-21T06:00", temp: 17.0),
    ]))
}



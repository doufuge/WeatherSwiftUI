//
//  TableChart.swift
//  WeatherSwiftUI
//
//  Created by Johny Fu on 2025/2/21.
//

import SwiftUI

struct TableChart: View {
    @Binding var data: [WeatherItem]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                    HStack {
                        Text(item.hour)
                            .frame(width: 160)
                            .padding(.vertical, 8)
                        Color.gray
                            .frame(width: 1)
                            .frame(maxHeight: .infinity)
                        Text(String("\(item.temp) \(item.tempUnit)"))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(index % 2 == 0 ? Color(.itemBgNormal) : Color(.itemBgHighlight))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 50)
        .scrollClipDisabled()
    }
}

#Preview {
    TableChart(data: .constant([WeatherItem(hour: "AAAA", temp: 10.0), WeatherItem(hour: "AAAA", temp: 12.0)]))
}

//
// Copyright © 2022 Swift Charts Examples.
// Open Source - MIT License

import SwiftUI
import Charts

struct SingleLineOverview: View {

    var data = SalesData.last30Days

    var body: some View {
        VStack(alignment: .leading) {
            Text(ChartType.singleLine.title)
                .font(.callout)
                .foregroundStyle(.secondary)

            Chart(data, id: \.day) {
                LineMark(
                    x: .value("Day", $0.day, unit: .day),
                    y: .value("Sales", $0.sales)
                )
            }
			.accessibilityChartDescriptor(self)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: Constants.previewChartHeight)
        }
    }
}

struct SingleLine: View {
    @State private var lineWidth = 2.0
    @State private var interpolationMethod: ChartInterpolationMethod = .cardinal
    @State private var chartColor: Color = .blue
    @State private var showSymbols = false

    var body: some View {
        List {
            Section {
                Chart(SalesData.last30Days, id: \.day) {
                    LineMark(
                        x: .value("Date", $0.day),
                        y: .value("Sales", $0.sales)
                    )
                    .accessibilityLabel($0.day.formatted())
                    .accessibilityValue("\($0.sales) sold")
                    .lineStyle(StrokeStyle(lineWidth: lineWidth))
                    .foregroundStyle(chartColor)
                    .interpolationMethod(interpolationMethod.mode)
                    .symbol(Circle().strokeBorder(lineWidth: lineWidth))
                    .symbolSize(showSymbols ? 60 : 0)
                }
                .frame(height: Constants.detailChartHeight)
            }
            
            customisation
        }
        .navigationBarTitle(ChartType.singleLine.title, displayMode: .inline)
    }
    
    private var customisation: some View {
        Section {
            Stepper(value: $lineWidth, in: 1.0...20.0) {
                HStack {
                    Text("Line Width")
                    Spacer()
                    Text("\(String(format: "%.0f",lineWidth))")
                }
            }
            
            Picker("Interpolation Method", selection: $interpolationMethod) {
                ForEach(ChartInterpolationMethod.allCases) { Text($0.mode.description).tag($0) }
            }
            
            ColorPicker("Color Picker", selection: $chartColor)

            Toggle("Show Symbols", isOn: $showSymbols)
        }
    }
}

struct SingleLine_Previews: PreviewProvider {
    static var previews: some View {
        SingleLineOverview()
        SingleLine()
    }
}

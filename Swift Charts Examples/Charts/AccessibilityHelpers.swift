//
// Copyright © 2022 Swift Charts Examples.
// Open Source - MIT License

import SwiftUI

extension TimeInterval {
    var durationDescription: String {
        let hqualifier = (hours == 1) ? "hour" : "hours"
        let mqualifier = (minutes == 1) ? "minute" : "minutes"
        
        return String(format:"%d \(hqualifier) %02d \(mqualifier)", hours, minutes)
    }

    var hours: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    
    var minutes: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
}

extension Date {
    // Used for charts where the day of the week is used: visually  M/T/W etc
    // (but we want VoiceOver to read out the full day)
    var weekdayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"

        return formatter.string(from: self)
    }
}

// TODO: This should be a protocol but since the data objects are in flux this will suffice
func chartDescriptor(forSalesSeries data: [(day: Date, sales: Int)]) -> AXChartDescriptor {
    let min = data.map(\.sales).min() ?? 0
    let max = data.map(\.sales).max() ?? 0

    // A closure that takes a date and converts it to a label for axes
    let dateTupleStringConverter: (((day: Date, sales: Int)) -> (String)) = { dataPoint in
        dataPoint.day.formatted(date: .abbreviated, time: .omitted)
    }
    
    let xAxis = AXCategoricalDataAxisDescriptor(
        title: "Days",
        categoryOrder: data.map { dateTupleStringConverter($0) }
    )

    let yAxis = AXNumericDataAxisDescriptor(
        title: "Sales",
        range: Double(min)...Double(max),
        gridlinePositions: []
    ) { value in "\(Int(value)) sold" }

    let series = AXDataSeriesDescriptor(
        name: "Daily sale quantity",
        isContinuous: false,
        dataPoints: data.map {
            .init(x: dateTupleStringConverter($0), y: Double($0.sales), label: "\($0.day.weekdayString)")
        }
    )

    return AXChartDescriptor(
        title: "Sales per day",
        summary: nil,
        xAxis: xAxis,
        yAxis: yAxis,
        additionalAxes: [],
        series: [series]
    )
}

func chartDescriptor(forLocationSeries data: [LocationData.Series]) -> AXChartDescriptor {
    
    let dateStringConverter: ((Date) -> (String)) = { date in
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    // Create a descriptor for each Series object
    // as that allows auditory comparison with VoiceOver
    // much like the chart does visually and allows individual city charts to be played
    let series = data.map { dataPoint in
        AXDataSeriesDescriptor(
            name: "\(dataPoint.city)",
            isContinuous: false,
            dataPoints: dataPoint.sales.map { data in
                    .init(x: dateStringConverter(data.weekday),
                          y: Double(data.sales),
                          label: "\(data.weekday.weekdayString)")
            }
        )
    }

    // Get the minimum/maximum within each city
    // and then the limits of the resulting list
    // to pass in as the Y axis limits
    let limits: [(Int, Int)] = data.map { seriesData in
        let sales = seriesData.sales.map { $0.sales }
        let localMin = sales.min() ?? 0
        let localMax = sales.max() ?? 0
        return (localMin, localMax)
    }

    let min = limits.map { $0.0 }.min() ?? 0
    let max = limits.map { $0.1 }.max() ?? 0

    // Get the unique days to mark the x-axis
    // and then sort them
    let uniqueDays = Set( data
        .map { $0.sales.map { $0.weekday } }
        .joined() )
    let days = Array(uniqueDays).sorted()

    let xAxis = AXCategoricalDataAxisDescriptor(
        title: "Days",
        categoryOrder: days.map { dateStringConverter($0) }
    )

    let yAxis = AXNumericDataAxisDescriptor(
        title: "Sales",
        range: Double(min)...Double(max),
        gridlinePositions: []
    ) { value in "\(Int(value)) sold" }

    return AXChartDescriptor(
        title: "Sales per day",
        summary: nil,
        xAxis: xAxis,
        yAxis: yAxis,
        additionalAxes: [],
        series: series
    )
}

func chartDescriptor(forGrid data: [Grid.Point]) -> AXChartDescriptor {
    let xmin = data.map(\.x).min() ?? 0
    let xmax = data.map(\.x).max() ?? 0
    let ymin = data.map(\.y).min() ?? 0
    let ymax = data.map(\.y).max() ?? 0
    let vmin = data.map(\.val).min() ?? 0
    let vmax = data.map(\.val).max() ?? 0
    
    let xAxis = AXNumericDataAxisDescriptor(
        title: "Position",
        range: Double(xmin)...Double(xmax),
        gridlinePositions: Array(stride(from: xmin, to: xmax, by: 1)).map { Double($0) }
    ) { "X: \($0)" }

    let yAxis = AXNumericDataAxisDescriptor(
        title: "Value",
        range: Double(ymin)...Double(ymax),
        gridlinePositions: Array(stride(from: ymin, to: ymax, by: 1)).map { Double($0) }
    ) { "Y: \($0)" }
    
    let valueAxis = AXNumericDataAxisDescriptor(
        title: "Value based Color",
        range: Double(vmin)...Double(vmax),
        gridlinePositions: []
    ) { "Color: \($0)" }

    let series = AXDataSeriesDescriptor(
        name: "",
        isContinuous: false,
        dataPoints: data.map {
            .init(x: Double($0.x),
                  y: Double($0.y),
                  additionalValues: [.category($0.val.formatted(.number))])
        }
    )

    return AXChartDescriptor(
        title: "Grid Data",
        summary: nil,
        xAxis: xAxis,
        yAxis: yAxis,
        additionalAxes: [valueAxis],
        series: [series]
    )
}

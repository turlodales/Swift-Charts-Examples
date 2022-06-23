//
// Copyright © 2022 Swift Charts Examples.
// Open Source - MIT License

import SwiftUI

enum ChartCategory: String, CaseIterable, Hashable, Identifiable {
    case all
    case line
    case bar
    case area
    case range
    case heatMap
    case point
  
    var id: String { self.rawValue }
    
    var sfSymbolName: String {
        switch self {
        case .all:
            return ""
        case .line:
            return "chart.xyaxis.line"
        case .bar:
            return "chart.bar.fill"
        case .area:
            return "triangle.fill"
        case .range:
            return "trapezoid.and.line.horizontal.fill"
        case .heatMap:
            return "checkerboard.rectangle"
        case .point:
            return "point.3.connected.trianglepath.dotted"
        }
    }
}

enum ChartType: String, Identifiable, CaseIterable {
    // Line Charts
    case singleLine
    case singleLineLollipop
    case heartBeat
    case animatingLine

    // Bar Charts
    case singleBar
    case singleBarThreshold
    case twoBars
    case pyramid
    case oneDimensionalBar
    case timeSheetBar

    // Area Charts
    case areaSimple

    // Range Charts
    case rangeSimple
    case rangeHeartRate
    case candleStick

    // HeatMap Charts
    case customizeableHeatMap

    // Point Charts
    case scatter
    case vectorField

    var id: String { self.rawValue }

    var title: String {
        switch self {
        case .singleLine:
            return "Line Chart"
        case .singleLineLollipop:
            return "Line Chart with Lollipop"
        case .animatingLine:
            return "Animating Line"
        case .heartBeat:
            return "Heart Beat / ECG Chart"
        case .singleBar:
            return "Single Bar"
        case .singleBarThreshold:
            return "Single Bar with Threshold Rule Mark"
        case .twoBars:
            return "Two Bars"
        case .pyramid:
            return "Pyramid"
        case .oneDimensionalBar:
            return "One Dimensional Bar"
        case .timeSheetBar:
            return "Time Sheet Bar"
        case .areaSimple:
            return "Area Chart"
        case .rangeSimple:
            return "Range Chart"
        case .rangeHeartRate:
            return "Heart Rate Range Chart"
        case .candleStick:
            return "Candle Stick Chart"
        case .customizeableHeatMap:
            return "Customizable Heat Map"
        case .scatter:
            return "Scatter Chart"
        case .vectorField:
            return "Vector Field"
        }
    }

    var category: ChartCategory {
        switch self {
        case .singleLine, .singleLineLollipop, .heartBeat, .animatingLine:
            return .line
        case .singleBar, .singleBarThreshold, .twoBars, .pyramid, .oneDimensionalBar, .timeSheetBar:
            return .bar
        case .areaSimple:
            return .area
        case .rangeSimple, .rangeHeartRate, .candleStick:
            return .range
        case .customizeableHeatMap:
            return .heatMap
        case .scatter, .vectorField:
            return .point
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .singleLine:
            SingleLineOverview()
        case .singleLineLollipop:
            SingleLineLollipop(isOverview: true)
        case .heartBeat:
            HeartBeatOverview()
        case .animatingLine:
            AnimatingLineOverview()
        case .singleBar:
            SingleBarOverview()
        case .singleBarThreshold:
            SingleBarThresholdOverview()
        case .twoBars:
            TwoBarsOverview()
        case .candleStick:
            CandleStickChartOverview()
        case .oneDimensionalBar:
            OneDimensionalBarOverview()
        case .timeSheetBar:
            TimeSheetBarOverview()
        case .pyramid:
            PyramidChartOverview()
        case .areaSimple:
            AreaSimpleOverview()
        case .rangeSimple:
            RangeSimpleOverview()
        case .rangeHeartRate:
            HeartRateRangeChartOverview()
        case .customizeableHeatMap:
            HeatMapOverview()
        case .scatter:
            ScatterChartOverview()
        case .vectorField:
            VectorFieldOverview()
        }
    }
    
    var chartDescriptor: AXChartDescriptor {
        // This is necessary since we use images for preview/overview
        // TODO: Use protocol coonformance to remove manual switch necessity
        switch self {
        case .singleLine:
            return SingleLineOverview().makeChartDescriptor()
        case .singleLineLollipop:
            return SingleLineLollipop(isOverview: true).makeChartDescriptor()
        case .heartBeat:
            return HeartBeatOverview().makeChartDescriptor()
        case .animatingLine:
            // This one is a little odd since the Overview type contains this call
            return AnimatedChart(x: 0, isOverview: true).makeChartDescriptor()
        case .singleBar:
            return SingleBarOverview().makeChartDescriptor()
        case .singleBarThreshold:
            return SingleBarThresholdOverview().makeChartDescriptor()
        case .twoBars:
            return TwoBarsOverview().makeChartDescriptor()
        case .oneDimensionalBar:
            return OneDimensionalBarOverview().makeChartDescriptor()
        case .candleStick:
            return CandleStickChartOverview().makeChartDescriptor()
        case .timeSheetBar:
            return TimeSheetBarOverview().makeChartDescriptor()
        case .pyramid:
            return PyramidChartOverview().makeChartDescriptor()
        case .areaSimple:
            return AreaSimpleOverview().makeChartDescriptor()
        case .rangeSimple:
            return RangeSimpleOverview().makeChartDescriptor()
        case .rangeHeartRate:
            return HeartRateRangeChartOverview().makeChartDescriptor()
        case .customizeableHeatMap:
            return HeatMapOverview().makeChartDescriptor()
        case .scatter:
            return ScatterChartOverview().makeChartDescriptor()
        case .vectorField:
            return VectorFieldOverview().makeChartDescriptor()
        
        }
    }

    @ViewBuilder
    var detailView: some View {
        switch self {
        case .singleLine:
            SingleLine()
        case .singleLineLollipop:
            SingleLineLollipop(isOverview: false)
        case .heartBeat:
            HeartBeat()
        case .animatingLine:
            AnimatingLine()
        case .singleBar:
            SingleBar()
        case .singleBarThreshold:
            SingleBarThreshold()
        case .twoBars:
            TwoBars()
        case .candleStick:
            CandleStickChart()
        case .oneDimensionalBar:
            OneDimensionalBar()
        case .timeSheetBar:
            TimeSheetBar()
        case .pyramid:
            PyramidChart()
        case .areaSimple:
            AreaSimple()
        case .rangeSimple:
            RangeSimple()
        case .rangeHeartRate:
            HeartRateRangeChart()
        case .customizeableHeatMap:
            HeatMap()
        case .scatter:
            ScatterChart()
        case .vectorField:
            VectorField()
        }
    }
}

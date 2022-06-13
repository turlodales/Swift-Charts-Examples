//
// Copyright © 2022 Swift Charts Examples.
// Open Source - MIT License

import Foundation
import SwiftUI

enum ChartCategory: String, CaseIterable, Hashable, Identifiable {
    case line
    case bar
    case area
    
    var id: String { self.rawValue }
}

enum ChartType: String, Identifiable, CaseIterable {
    
    // Line Charts
    case singleLine
    
    // Bar Charts
    case singleBar
    case twoBars
    case pyramid
    
    // Area Charts
    case areaSimple
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .singleLine:
            return "Single Line"
        case .singleBar:
            return "Single Bar"
        case .twoBars:
            return "Two Bars"
        case .pyramid:
            return "Pyramid"
        case .areaSimple:
            return "Simple Area"
        }
    }
    
    var category: ChartCategory {
        switch self {
        case .singleLine:
            return .line
        case .singleBar:
            return .bar
        case .twoBars:
            return .bar
        case .pyramid:
            return .bar
        case .areaSimple:
            return .area
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .singleLine:
            LineChartSimpleOverview()
        case .singleBar:
            BarChartSimpleOverview()
        case .twoBars:
            TwoBarsSimpleOverview()
        case .pyramid:
            PyramidChartOverview()
        case .areaSimple:
            AreaChartSimpleOverview()
        }
    }
}

//
//  CustomDateField.swift
//  TSGH-Helper
//
//  Created by JimmyChao on 2024/5/30.
//

import SwiftUI
import Foundation
import UIKit

public enum DateRestriction {
    case disablePast
    case disableFuture
    case none
}

public struct STDateField: View {
    
    let placeholder: LocalizedStringKey
    var foregroundColor: Color = Color.ST_595757
    var backgroundColor: Color = Color(hex: "#FFF8E8")
    var style: STFieldStyle = .normal
    var fontWeight: Font.Weight = .regular
    
    @Binding var selectedDate: Date
    @State var dateRestriction: DateRestriction = .none
    @State var showCalendar = false
    var action: (() -> Void)? = nil
    
    public init(
        placeholder: LocalizedStringKey,
        selectedDate: Binding<Date>,
        foregroundColor: Color = Color.ST_595757,
        backgroundColor: Color = Color(hex: "#FFF8E8"),
        style: STFieldStyle = .normal,
        fontWeight: Font.Weight = .regular,
        dateRestriction: DateRestriction = .none,
        action: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._selectedDate = selectedDate
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.style = style
        self.fontWeight = fontWeight
        self._dateRestriction = State(initialValue: dateRestriction)
        self._showCalendar = State(initialValue: false)
        self.action = action
    }
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }
    
    var selectedDateInString: String {
        
        let target = formatter.string(from: selectedDate)
        guard target.count > 4 else { return target }
        let year = target.prefix(4)
        return "\(year)/**/**"
        
    }
    
    public var body: some View {
        
        VStack {
            
            HStack {
                Group {
                    if shouldShownPlaceholder() {
                        Text(placeholder)
                    } else {
                        Text(selectedDateInString)
                    }
                }
                    .padding(5)
                    .padding(.leading, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(shouldShownPlaceholder() ? .ST_595757: foregroundColor)
                    .fontWeight(self.fontWeight)
                    .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
                
                Image(systemName: "calendar")
                    .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
                    .padding(5)
                    .padding(.trailing, 8)
                    .frame(maxWidth: 35, alignment: .trailing)
            }
            .doubleIf(style == .normal, style == .original, then: { view in
                view
                    .padding(.horizontal, 5)
                    .innerShadow(.white, 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.25), lineWidth: 1)
                    }
            }, elseIf: { view in
                view
            }, else: { view in
                view
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                    .bubbleStyle(backgroundColor, 20)
            })
            .onTapGesture {
                showCalendar = true
                action?()
                print("I'm tiggered \(showCalendar)")
            }
        }
        .sheet(isPresented: $showCalendar) {
            STCalendar(
                selectedDate: $selectedDate,
                dateRistriction: dateRestriction)
            .presentationDetents([.fraction(0.65)])    
            .presentationDragIndicator(.visible)
        }
    }
    
    // Should shown placeholder
    func shouldShownPlaceholder() -> Bool {
        switch dateRestriction {
        case .disableFuture:
            return selectedDate.isAfter(Calendar.current.date(
                byAdding: .day,
                value: -1,
                to: Date.now)!)
        case .disablePast:
            return selectedDate.isBefore(Calendar.current.date(
                byAdding: .day,
                value: -1,
                to: Date.now)!)
        case .none:
            return false
        }
    }
}


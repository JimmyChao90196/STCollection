//
//  CustomDateField.swift
//  TSGH-Helper
//
//  Created by JimmyChao on 2024/5/30.
//

import SwiftUI

public enum DateRestriction {
    case disablePast
    case disableFuture
    case none
}

public struct STDateField: View {
    
    let placeholder: String
    var foregroundColor: Color = Color.ST_595757
    var style: STFieldStyle = .normal
    
    @Binding var selectedDate: Date
    @State var dateRestriction: DateRestriction = .none
    @State var showCalendar = false
    var action: (() -> Void)? = nil
    
    public init(
        placeholder: String,
        selectedDate: Binding<Date>,
        foregroundColor: Color = Color.ST_595757,
        style: STFieldStyle = .normal,
        dateRestriction: DateRestriction = .none,
        action: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._selectedDate = selectedDate
        self.foregroundColor = foregroundColor
        self.style = style
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
        formatter.string(from: selectedDate)
    }
    
    public var body: some View {
        
        VStack {
            
            HStack {
                Text(shouldShownPlaceholder() ? placeholder: selectedDateInString)
                    .padding(5)
                    .padding(.leading, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(shouldShownPlaceholder() ? .ST_595757: foregroundColor)
                    .fontWeight(.bold)
                    .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
                
                Image(systemName: "calendar")
                    .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
                    .padding(5)
                    .padding(.trailing, 8)
                    .frame(maxWidth: 35, alignment: .trailing)
            }
            .if(style == .normal) { view in
                view
                    .innerShadow(.white, 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black.opacity(0.25), lineWidth: 1)
                    }
            } else: { view in
                view
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                    .bubbleStyle(.ST_CBD8E8, 20)
            }
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


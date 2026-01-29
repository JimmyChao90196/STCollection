//
//  STCalendar.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/2.
//

import SwiftUI
import Foundation

public struct STCalendar: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedDate: Date
    @State var isShowSubmit: Bool = false
    
    var formatString: String
    var placeholder: LocalizedStringResource
    
    var dateRistriction: DateRestriction = .none
    
    public init(
            selectedDate: Binding<Date>,
            dateRistriction: DateRestriction = .none,
            formatString: String = "西元yyyy年 MM月 dd日",
            placeholder: LocalizedStringResource = "請輸入出生年月日"
        ) {
            self._selectedDate = selectedDate
            self.dateRistriction = dateRistriction
            self.formatString = formatString
            self.placeholder = placeholder
        }
    
    var adjacentNow: Date {
        Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!
    }
    
//    var formatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "西元yyyy年 MM月 dd日"
//        return formatter
//    }
    
    func formatted(_ date: Date, formatString: String = "西元yyyy年 MM月 dd日") -> String {
        let formatter = DateFormatter()
        
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        formatter.locale = .current
        
        formatter.dateFormat = formatString
        return formatter.string(from: date)
    }
    
    public var body: some View {
        VStack {
            
            Spacer().frame(height: 20)
            
            HStack(alignment: .bottom) {
                if isShowSubmit {
    
                    Text(formatted(selectedDate, formatString: formatString))
                    .customDynamicSize(font: .title3, ...DynamicTypeSize.xxLarge)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 15)
                    
                } else {
                    Text(placeholder)
                        .customDynamicSize(font: .title2, ...DynamicTypeSize.xxLarge)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 15)
                }
                
                if isShowSubmit {
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("dialog_confirm")
                            .customDynamicSize(font: .headline, ...DynamicTypeSize.xxLarge)
                            .foregroundStyle(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .bubbleStyle(.init(hex: "#C7846E"), 4)
                    }
                }
            }
            .padding(.horizontal)
            
            Group {
                switch dateRistriction {
                case .custom(let start, let end):
                    DatePicker("Title", selection: $selectedDate, in: start...end, displayedComponents: .date)
                        .frame(maxWidth: .infinity)
                        .datePickerStyle(.wheel)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                        
                    
                case .disablePast:
                    DatePicker("Title", selection: $selectedDate, in: adjacentNow..., displayedComponents: .date)
                        .frame(maxWidth: .infinity)
                        .datePickerStyle(.wheel)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                        
                        
                case .disableFuture:
                    DatePicker("Title", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .frame(maxWidth: .infinity)
                        .datePickerStyle(.wheel)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                        
                        
                case .none:
                    DatePicker("Title", selection: $selectedDate, displayedComponents: .date)
                        .frame(maxWidth: .infinity)
                        .datePickerStyle(.wheel)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                }
            }
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "zh_Hant_TW"))
            .tint(.black)
        }
        .padding(.top, 20)
        .onChange(of: selectedDate) { oldValue, newValue in
            if oldValue != newValue {
                isShowSubmit = true
            }
        }
    }
}

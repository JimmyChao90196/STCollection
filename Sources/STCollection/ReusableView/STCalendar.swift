//
//  STCalendar.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/2.
//

import SwiftUI

public struct STCalendar: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedDate: Date
    var dateRistriction: DateRestriction = .none
    
    public init(
            selectedDate: Binding<Date>,
            dateRistriction: DateRestriction = .none
        ) {
            self._selectedDate = selectedDate
            self.dateRistriction = dateRistriction
        }
    
    var adjacentNow: Date {
        Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!
    }
    
    public var body: some View {
        VStack {
            
            Spacer().frame(height: 20)
            
            HStack(alignment: .bottom) {
                Text("請輸入出生年月日")
                    .customDynamicSize(font: .title2, ...DynamicTypeSize.xxLarge)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(width: 250)
                    .padding(.top, 15)
                
                Button {
                    dismiss()
                } label: {
                    Text("提交")
                        .customDynamicSize(font: .title3, ...DynamicTypeSize.xxLarge)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .bubbleStyle(.ST_1B0851, 4)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                }
            }
            
            Group {
                switch dateRistriction {
                case .disablePast:
                    DatePicker("Title", selection: $selectedDate, in: adjacentNow..., displayedComponents: .date)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                        
                case .disableFuture:
                    DatePicker("Title", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                        
                case .none:
                    DatePicker("Title", selection: $selectedDate, displayedComponents: .date)
                        .dynamicTypeSize(...DynamicTypeSize.xLarge)
                    
                }
            }
            .labelsHidden()
            .datePickerStyle(.graphical)
            .environment(\.calendar, Calendar(identifier: .republicOfChina))
            .environment(\.locale, Locale(identifier: "zh_Hant_TW"))
            .tint(.black)
                
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(20)

    }
}

#Preview() {
    STCalendar(selectedDate: .constant(Date()))
        
}

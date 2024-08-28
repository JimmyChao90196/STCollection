//
//  STDropDownList.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI

public enum DropDownPickerState {
    case top, bottom
}

public struct STDropDownList: View {
    
    @Binding var selection: String?
    @Binding var isDroping: Bool
    var placeholder: String
    var disabledPlaceholder: String = ""
    var state: DropDownPickerState = .bottom
    var options: [String]
    @Binding var disable: Bool
    
    //@State var showDropdown = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    public init(
        selection: Binding<String?>,
        isDroping: Binding<Bool>,
        placeholder: String,
        disabledPlaceholder: String = "",
        state: DropDownPickerState = .bottom,
        options: [String],
        disable: Binding<Bool>
    ) {
        self._selection = selection
        self._isDroping = isDroping
        self.placeholder = placeholder
        self.disabledPlaceholder = disabledPlaceholder
        self.state = state
        self.options = options
        self._disable = disable
        self._zindex = State(initialValue: 1000.0)
    }
    
    @Environment(\.dynamicTypeSize) var dynamicSize
    var dynamicHeight: CGFloat {
        switch dynamicSize {
        case .xSmall: 34
        case .small: 38
        case .medium: 40
        case .large: 42
        case .xLarge: 44
        case .xxLarge: 46
        case .xxxLarge: 48
        default: 48
        }
    }
    
    var dynamicWidth: CGFloat {
        switch dynamicSize {
        case .xSmall: 160
        case .small: 180
        case .medium: 180
        case .large: 190
        case .xLarge: 210
        case .xxLarge: 230
        case .xxxLarge: 230
        default: 230
        }
    }
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(alignment: .leading, spacing: 0) {
                
                if state == .top && isDroping {
                    OptionsView()
                }
                
                HStack(spacing: 10) {
                    
                    if !disable {
                        Text(selection == nil ? placeholder : selection!)
                            .foregroundColor(selection != nil ? .ST_1B0851 : .gray.opacity(0.5))
                            .customDynamicSize(font: .title, ...DynamicTypeSize.xxxLarge)
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                    } else {
                        Text(disabledPlaceholder)
                            .foregroundColor(.ST_1B0851)
                            .customDynamicSize(font: .title, ...DynamicTypeSize.xxxLarge)
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                    }
                    
                    if !disable {
                        Image(systemName: state == .top ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .customDynamicSize(font: .caption2, ...DynamicTypeSize.xxxLarge)
                            .foregroundStyle(.ST_1B0851.opacity(0.75))
                            .rotationEffect(.degrees((isDroping ? -180 : 0)))
                            .padding(.trailing, 8)
                    }
                }
                // MARK: Title background color -
                .background(.clear)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    
                    withAnimation(.easeInOut(duration: 0.25)) {
                        // showDropdown.toggle()
                        // isDroping = showDropdown
                        isDroping.toggle()
                    }
                }
                .disabled(disable)
                .animation(.easeInOut, value: disable)
                .zIndex(10)
                
                if state == .bottom && isDroping {
                    OptionsView()
                }
            }
            .clipped()
            .padding(.all, 4)
            .padding(.vertical, 1.5)
            
            // MARK: DropDown background color -
            .background(.clear)
            .cornerRadius(3)
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
        }
        //.onChange(of: isDroping, { _, newValue in
        //    showDropdown = newValue
        //})
        // Height Adjustment
        .frame(width: dynamicWidth, height: dynamicHeight, alignment: .leading)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        VStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                        .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(selection == option ? 1 : 0)
                        .customDynamicSize(font: .callout, ...DynamicTypeSize.xLarge)
                }
                .foregroundStyle(selection == option ? Color.black : Color.gray)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .padding(.horizontal, 5)
                .background(selection == option ? .ST_90ACC6: .white)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selection = option
                        isDroping.toggle()
                        //isDroping = showDropdown
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        //.transition(.move(edge: state == .top ? .bottom : .top))
        //.transition(.move(edge: .bottom))
        .zIndex(1)
    }
}

#Preview {
    
    let options = [ "Google", "Intel", "AMD" ]
    
    return STDropDownList(
        selection: .constant(nil),
        isDroping: .constant(true),
        placeholder: "請選擇",
        options: options,
        disable: .constant(false)
    )
    
}


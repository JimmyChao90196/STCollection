//
//  ST_SegmentedBlockView.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI

public struct TabTitle: TitleProtocol {
    public var title: String
    public var id: UUID = UUID()
    public var selectedIcon: Image? = nil
    public var nonSelectedIcon: Image? = nil
    
    public init(
        title: String,
        id: UUID = UUID(),
        selectedIcon: Image? = nil,
        nonSelectedIcon: Image? = nil
    ) {
        self.title = title
        self.id = id
        self.selectedIcon = selectedIcon
        self.nonSelectedIcon = nonSelectedIcon
    }
}

public struct STSegmentedBlockView<T: TitleProtocol>: View {
    
    @Binding var selectedIndex: Int
    @Binding var previousIndex: Int
    //let tabConfig: TabConfigProtocol
    @State public var inputDatas: [T]
    var animationStyle: Animation = .bouncy(duration: 0.5, extraBounce: 0.01)
    var innerPadding: CGFloat = 5
    var innerShadow: Bool = false
    var padding: CGFloat = 0
    var radius: CGFloat = 0
    var iconSize: CGFloat = 30
    var nonSelectedBgColor: Color = .white
    var selectedBgColor: Color = .ST_706D77
    var selectedColor: Color = .white
    var nonSelectedColor: Color = .black
    var font: Font = .headline
    var dynamicSizeLock: PartialRangeThrough<DynamicTypeSize> = ...DynamicTypeSize.accessibility1
    
    public init(
        selectedIndex: Binding<Int>,
        previousIndex: Binding<Int>,
        inputDatas: [T],
        animationStyle: Animation = .bouncy(duration: 0.5, extraBounce: 0.01),
        innerPadding: CGFloat = 5,
        innerShadow: Bool = false,
        padding: CGFloat = 0,
        radius: CGFloat = 0,
        iconSize: CGFloat = 30,
        nonSelectedBgColor: Color = .white,
        selectedBgColor: Color = .ST_706D77,
        selectedColor: Color = .white,
        nonSelectedColor: Color = .black,
        font: Font = .headline,
        dynamicSizeLock: PartialRangeThrough<DynamicTypeSize> = ...DynamicTypeSize.accessibility1
    ) {
        self._selectedIndex = selectedIndex
        self._previousIndex = previousIndex
        self._inputDatas = State(initialValue: inputDatas)
        self.animationStyle = animationStyle
        self.innerPadding = innerPadding
        self.innerShadow = innerShadow
        self.padding = padding
        self.radius = radius
        self.iconSize = iconSize
        self.nonSelectedBgColor = nonSelectedBgColor
        self.selectedBgColor = selectedBgColor
        self.selectedColor = selectedColor
        self.nonSelectedColor = nonSelectedColor
        self.font = font
        self.dynamicSizeLock = dynamicSizeLock
    }
    
    @Namespace var animation
    
    public var body: some View {
        
        VStack {
            HStack(alignment: .center ,spacing: 0) {
                ForEach(inputDatas.indices, id: \.self) { index in
                    ZStack {
                        
                        HStack(spacing: 5) {
                            
                            if inputDatas[index].selectedIcon != nil {
                                
                                if isSelected(index) {
                                    inputDatas[index].selectedIcon!
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: iconSize, height: iconSize)
                                        .padding(.vertical, 5)
                                        
                                } else {
                                    inputDatas[index].nonSelectedIcon!
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: iconSize, height: iconSize)
                                        .padding(.vertical, 5)
                                }
                            }
                            
                            // Tab title
                            Text(inputDatas[index].title)
                                .customDynamicSize(font: font, dynamicSizeLock)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    isSelected(index) ?
                                    selectedColor: nonSelectedColor
                                )
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.2)
                                .padding(.horizontal, 5)
                                .shadow(color: .gray, radius: 0.5, x: 0, y: 1)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .onTapGesture {
                                    previousIndex = selectedIndex
                                    selectedIndex = index
                                }
                        }
                        .padding(.horizontal, 5)
                        .padding(.vertical, padding)
                        .background(
                            Group { // Use Group to ensure the view type is consistent
                                if isSelected(index) {
                                    selectedBgColor.clipShape(RoundedRectangle(cornerRadius: radius))
                                        .matchedGeometryEffect(id: "Tab", in: animation)
                                } else {
                                    Color.clear
                                }
                            }
                        )
                        .padding(innerPadding)
                    }
                }
            }
            .animation(animationStyle, value: selectedIndex)
            .if(innerShadow, then: { view in
                view.innerShadow(nonSelectedBgColor, radius)
                    .overlay {
                        RoundedRectangle(cornerRadius: radius).stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    }
            }, else: { view in
                view
                    .background(nonSelectedBgColor)
                    .clipShape(.rect(cornerRadius: radius))
                    .overlay {
                        RoundedRectangle(cornerRadius: radius).stroke(Color.gray.opacity(0.5), lineWidth: 2)
                    }
            })
        }
    }
    
    //MARK: - Helper function -
    private func isSelected(_ currentIndex: Int) -> Bool {
        selectedIndex == currentIndex
    }
}

#Preview {
    
    let titles = [TabTitle(title: "Yes"), TabTitle(title: "YYYY")]
    
    return STSegmentedBlockView(
        selectedIndex: .constant(0),
        previousIndex: .constant(0),
        inputDatas: titles)
}

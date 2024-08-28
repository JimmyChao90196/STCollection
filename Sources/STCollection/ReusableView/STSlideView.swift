//
//  STSlideView.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/8.
//

import SwiftUI

public struct STSlideView<T, ReturnedView: View>: View {
    
    @Binding var currentIndex: Int
    @State var inputDatas: [T]
    var configTabView: (T) -> ReturnedView
    
    public init(
          currentIndex: Binding<Int>,
          inputDatas: [T],
          configTabView: @escaping (T) -> ReturnedView
      ) {
          self._currentIndex = currentIndex
          self._inputDatas = State(initialValue: inputDatas)
          self.configTabView = configTabView
      }
    
    public var body: some View {
        
        let scrollPositionBinding = Binding<Int?>(
            get: { currentIndex },
            set: { newValue in
                if let newValue = newValue {
                    currentIndex = newValue
                }
            }
        )
        
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(inputDatas.indices, id: \.self) { index in
                    configTabView(inputDatas[index])
                        .containerRelativeFrame(.horizontal) { size, _ in
                            return size
                        }
                }
            }
        }
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: scrollPositionBinding, anchor: .center)
        .scrollIndicators(.hidden)
        .animation(.easeInOut, value: currentIndex)
        .background(.clear)
    }
}

#Preview {
    
    let tutorials = [
        "1", "2", "3"
    ]
    
    return STSlideView(
        currentIndex: .constant(0),
        inputDatas: tutorials) { unit in
            Text(unit)
                .frame(maxWidth: .infinity)
                .background(.red)
    }
}



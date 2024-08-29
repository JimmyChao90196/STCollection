//
//  STExtendableList.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/27.
//

import Foundation
import SwiftUI
import os

fileprivate let logger = Logger(subsystem: "SmartTools", category: "STList")

public struct STExtendableList<InputData, Card: View, Header: View, Footer: View>: View {
    
    // Source
    let datas: [InputData]
    let cardView: (InputData) -> Card
    let footerView: Footer
    let headerView: Header
    
    public init(
        datas: [InputData],
        cardView: @escaping (InputData) -> Card,
        @ViewBuilder headerView: () -> Header,
        @ViewBuilder footerView: () -> Footer
    ) {
        self.datas = datas
        self.cardView = cardView
        self.headerView = headerView()
        self.footerView = footerView()
    }

    public init(datas: [InputData],
         cardView: @escaping (InputData) -> Card) where Footer == Color, Header == Color {
        self.datas = datas
        self.cardView = cardView
        self.footerView = Color.clear
        self.headerView = Color.clear
    }
    
    
    public var body: some View {
        
        ScrollView {
            
            VStack(spacing: 0) {
                headerView
                    .primListRowStyle()
                    //.padding(.vertical, 10)
                    .padding(.horizontal, 2)
                
                ForEach(datas.indices, id:\.self) { index in
                    cardView(datas[index])
                        .primListRowStyle()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 2)
                }
                
                footerView
                    .primListRowStyle()
                    //.padding(.vertical, 10)
                    .padding(.horizontal, 2)
            }
        }
        .environment(\.defaultMinListRowHeight, 0)
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
        
    }
}

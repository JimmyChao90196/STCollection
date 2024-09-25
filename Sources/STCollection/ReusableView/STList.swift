//
//  STList.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/7/31.
//

import Foundation
import SwiftUI


public struct STList<InputData, Card: View, Header: View, Footer: View>: View {
    
    // Source
    var datas: [InputData]
    var initPadding: CGFloat = 16
    var cardView: (InputData) -> Card
    var footerView: Footer
    var headerView: Header
    
    var onDelete: ((IndexSet) -> Void)?
    
    public init(
        datas: [InputData],
        cardView: @escaping (InputData) -> Card,
        @ViewBuilder headerView: () -> Header,
        @ViewBuilder footerView: () -> Footer,
        onDelete: ((IndexSet) -> Void)? = nil
    ) {
        self.datas = datas
        self.cardView = cardView
        self.headerView = headerView()
        self.footerView = footerView()
        self.onDelete = onDelete
    }

    public init(
        datas: [InputData],
        cardView: @escaping (InputData) -> Card,
        onDelete: ((IndexSet) -> Void)? = nil) where Footer == Color, Header == Color {
        self.datas = datas
        self.cardView = cardView
        self.footerView = Color.clear
        self.headerView = Color.clear
        self.onDelete = onDelete
    }
    
    
    public var body: some View {
        
        List {
            headerView
                .primListRowStyle()
                .padding(.horizontal, 2)
            
            ForEach(datas.indices, id:\.self) { index in
                cardView(datas[index])
                .primListRowStyle()
                .padding(.vertical, 10)
                .padding(.horizontal, 2)
            }
            .onDelete(perform: { indexSet in
                onDelete?(indexSet)
            })
            
            footerView
                .primListRowStyle()
                .padding(.horizontal, 2)
        }
        .environment(\.defaultMinListRowHeight, 0)
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .padding(.horizontal, initPadding)
        
    }
}

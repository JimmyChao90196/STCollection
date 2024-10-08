//
//  STSelectableList.swift
//  STCollection
//
//  Created by JimmyChao on 2024/10/7.
//


import Foundation
import SwiftUI

public struct STSelectableList<InputData: Hashable, Card: View, Header: View, Footer: View>: View {
    
    // Source
    var selection: Binding<Set<InputData>>?
    var datas: [InputData]
    var initPadding: CGFloat
    var cardView: (InputData) -> Card
    var footerView: Footer
    var headerView: Header
    
    var onDelete: ((IndexSet) -> Void)?
    
    public init(
        selection: Binding<Set<InputData>>?,
        datas: [InputData],
        initPadding: CGFloat = 16,
        cardView: @escaping (InputData) -> Card,
        @ViewBuilder headerView: () -> Header,
        @ViewBuilder footerView: () -> Footer,
        onDelete: ((IndexSet) -> Void)? = nil
    ) {
        self.selection = selection
        self.datas = datas
        self.initPadding = initPadding
        self.cardView = cardView
        self.headerView = headerView()
        self.footerView = footerView()
        self.onDelete = onDelete
    }

    public init(
        selection: Binding<Set<InputData>>?,
        datas: [InputData],
        initPadding: CGFloat = 16,
        cardView: @escaping (InputData) -> Card,
        onDelete: ((IndexSet) -> Void)? = nil
    ) where Footer == Color, Header == Color {
            
        self.selection = selection
        self.datas = datas
        self.initPadding = initPadding
        self.cardView = cardView
        self.footerView = Color.clear
        self.headerView = Color.clear
        self.onDelete = onDelete
    }
    
    
    public var body: some View {
 
        
        List(selection: selection) {
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

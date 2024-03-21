//
//  AwareScrollView.swift
//
//  Created by Dominik Babić on 21.03.2024..
//

import SwiftUI

public struct AwareScrollView<Content: View>: View {
    
    @StateObject public var viewModel: AwareScrollViewModel
    
    public var content: () -> Content
    
    @State private var showChild = false
    
    public var body: some View {
        ScrollView(viewModel.shouldScroll ? viewModel.axes : [], showsIndicators: viewModel.showsIndicators) {
            if showChild {
                content()
                    .onSizeChange { newSize in
                        viewModel.contentSize = newSize
                    }
            }
        }
        .onSizeChange { newSize in
            viewModel.scrollViewSize = newSize
        }
        .onAppear {
            showChild = true
        }
    }
}

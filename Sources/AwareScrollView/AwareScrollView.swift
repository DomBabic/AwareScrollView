//
//  AwareScrollView.swift
//
//  Created by Dominik Babić on 21.03.2024..
//

import SwiftUI

public struct AwareScrollView<Content: View>: View {
    
    @StateObject public var viewModel: AwareScrollViewModel
    
    public var content: () -> Content
    
    public init(viewModel: AwareScrollViewModel, content: @escaping () -> Content) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.content = content
    }
    
    public var body: some View {
        ScrollView(viewModel.shouldScroll ? viewModel.axes : [], showsIndicators: viewModel.showsIndicators) {
            if viewModel.showChild {
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
            viewModel.showChild = true
        }
    }
}

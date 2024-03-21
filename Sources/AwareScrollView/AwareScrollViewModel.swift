//
//  AwareScrollViewModel.swift
//
//  Created by Dominik Babić on 21.03.2024..
//

import Foundation
import SwiftUI
import Combine

/// ViewModel used to handle scrollability of the `AwareScrollView`.
///
/// ViewModel observes changes to the intrinsic content size of the ScrollView,
/// as well as the size of ScrollView itself. When it is detected that the content
/// size is greater than the size of the ScrollView, scrolling will be enabled.
public class AwareScrollViewModel: ObservableObject {
    
    /// Set of cancellable objects used to store subscriptions.
    var cancellables = Set<AnyCancellable>()
    
    /// Set of axes used for ScrollView.
    var axes: Axis.Set
    
    /// Flag indicating whether or not ScrollView should show scroll indicators.
    var showsIndicators: Bool
    
    /// Flag indicating whether content should be displayed or not.
    @Published var showChild = false
    
    /// Size of the ScrollView.
    @Published var scrollViewSize: CGSize = .zero
    /// Intrinsic content size of the ScrollView.
    @Published var contentSize: CGSize = .zero
    
    /// Boolean indicating whether or not ScrollView should be allowed to scroll.
    @Published var shouldScroll = false
    
    /// Default initializer for `AwareScrollViewModel`.
    ///
    /// - Parameters:
    ///     - axes: Set of axes indicating the direction in which ScrollView can scroll.
    ///     - showsIndicators: Flag indicating whether or not ScrollView should show scroll indicators.
    public init(axes: Axis.Set = .vertical,
         showsIndicators: Bool = true) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        
        setupBinding()
    }
    
    /// Method used to setup binding for the publishers.
    ///
    /// Method uses `AwareScrollViewModel`'s publishers to determine the scrollability of the ScrollView.
    /// Based on the sizes of the ScrollView and its content, binding determines if the scrolling should be allowed.
    public func setupBinding() {
        $scrollViewSize
            .combineLatest($contentSize)
            .filter { $0.0 != .zero && $0.1 != .zero }
            .compactMap { [axes] scroll, content in
                switch axes {
                case .horizontal:
                    return content.width > scroll.width
                case .vertical:
                    return content.height > scroll.height
                case Axis.Set([]):
                    return false
                case Axis.Set([.vertical, .horizontal]):
                    return content.width > scroll.width || content.height > scroll.height
                default:
                    return false
                }
            }
            .sink { [weak self] enableScroll in
                self?.shouldScroll = enableScroll
            }
            .store(in: &cancellables)
    }
}

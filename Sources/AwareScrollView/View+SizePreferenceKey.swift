//
//  View+SizePreferenceKey.swift
//  Placeholder
//
//  Created by Dominik Babić on 03.03.2023..
//  Copyright © 2023 Teltech Systems Inc. All rights reserved.
//

import Foundation
import SwiftUI

public extension View {
    
    /// Method used to observe changes to the content size.
    /// - Parameters:
    ///     - completion: Completion block returning CGSize of a view.
    /// - Returns:
    ///     Modified View with background that observes preference change for
    ///     `SizePreferenceKey`.
    ///
    /// Use this method to observe changes to the content size.
    /// Completion block receives CGSize whenever `SizePreferenceKey` value changes.
    func onSizeChange(_ completion: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear.preference(key: SizePreferenceKey.self,
                                       value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: completion)
    }
}

/// Preference key used to observe view content size changes.
public struct SizePreferenceKey: PreferenceKey {
    public static var defaultValue: CGSize = .zero
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

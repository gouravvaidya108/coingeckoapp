//
//  Font.swift
//  CoinGecko
//
//  Created by Gourav on 25.09.2023.
//

import Foundation
import SwiftUI

extension Font {
    static func appFont(size: CGFloat) -> Font {
        return Font.custom("Arial", size: size)
    }

    static let appNavigationTitle = appFont(size: 20).weight(.bold)
    static let appTitle = appFont(size: 18).weight(.semibold)
    static let appHeadline = appFont(size: 14).weight(.semibold)
    static let appBody = appFont(size: 16).weight(.medium)
    static let appCaption = appFont(size: 14).weight(.regular)

}

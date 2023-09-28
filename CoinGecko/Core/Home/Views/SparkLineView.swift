//
//  SparkLineView.swift
//  CoinGecko
//
//  Created by Gourav on 23.09.2023.
//

import Foundation
import SwiftUI
struct SparklineView: View {
    let data: [Double]

    var body: some View {
        GeometryReader { geometry in
            sparklinePath(in: geometry.size)
                .stroke(lineColor, lineWidth: 2)
        }
        .aspectRatio(2, contentMode: .fit)
        .padding(8)
    }

    private var lineColor: Color {
        data.last.flatMap { $0 >= data.first ?? 0 } == true ? .green : .red
    }

    private func sparklinePath(in size: CGSize) -> Path {
        guard let minY = data.min(), let maxY = data.max(), minY != maxY else {
            return Path()
        }

        return Path { path in
            let stepX = size.width / CGFloat(data.count - 1)
            let normalizedData = data.map { size.height - normalize($0, minY: minY, maxY: maxY) * size.height }

            path.move(to: CGPoint(x: 0, y: normalizedData.first ?? 0))

            for (index, value) in normalizedData.dropFirst().enumerated() {
                let x = CGFloat(index + 1) * stepX // + 1 to skip the first element we already used above
                path.addLine(to: CGPoint(x: x, y: value))
            }
        }
    }

    private func normalize(_ value: Double, minY: Double, maxY: Double) -> CGFloat {
        guard minY != maxY else { return 0 }
        return CGFloat((value - minY) / (maxY - minY))
    }
}



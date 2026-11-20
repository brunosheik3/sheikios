import SwiftUI

enum AppTheme {
    static let navy = Color(hex: "07172C")
    static let blue = Color(hex: "168BFF")
    static let sky = Color(hex: "56C2FF")
    static let ink = Color(hex: "020912")
    static let muted = Color.white.opacity(0.68)
}

extension Color {
    init(hex: String) {
        let value = UInt64(hex, radix: 16) ?? 0
        self.init(
            .sRGB,
            red: Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8) & 0xFF) / 255,
            blue: Double(value & 0xFF) / 255,
            opacity: 1
        )
    }
}

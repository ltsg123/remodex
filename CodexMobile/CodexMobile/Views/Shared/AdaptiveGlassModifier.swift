import SwiftUI

// MARK: - Preference

enum GlassPreference {
    static let storageKey = "codex.useLiquidGlass"

    static var isSupported: Bool {
        return false
    }
}

// MARK: - Glass effect modifier

private struct AdaptiveGlassModifier<S: Shape>: ViewModifier {
    @AppStorage(GlassPreference.storageKey) private var glassEnabled = false
    let shape: S

    func body(content: Content) -> some View {
        let _ = glassEnabled
        content.background(.thinMaterial, in: shape)
    }
}

// MARK: - Navigation bar modifier

private struct AdaptiveNavigationBarModifier: ViewModifier {
    @AppStorage(GlassPreference.storageKey) private var glassEnabled = false

    func body(content: Content) -> some View {
        let _ = glassEnabled
        content
    }
}

// MARK: - Toolbar item fallback (glass OFF or iOS < 26)

private struct AdaptiveToolbarItemModifier<S: Shape>: ViewModifier {
    @AppStorage(GlassPreference.storageKey) private var glassEnabled = false
    let shape: S

    func body(content: Content) -> some View {
        let _ = glassEnabled
        let _ = shape
        content
    }
}

// MARK: - View extensions

enum AdaptiveGlassStyle {
    case regular
}

extension View {
    func adaptiveGlass(_ style: AdaptiveGlassStyle, in shape: some Shape) -> some View {
        let _ = style
        return modifier(AdaptiveGlassModifier(shape: shape))
    }

    func adaptiveGlass(in shape: some Shape) -> some View {
        modifier(AdaptiveGlassModifier(shape: shape))
    }

    func adaptiveNavigationBar() -> some View {
        modifier(AdaptiveNavigationBarModifier())
    }

    func adaptiveToolbarItem(in shape: some Shape) -> some View {
        modifier(AdaptiveToolbarItemModifier(shape: shape))
    }
}

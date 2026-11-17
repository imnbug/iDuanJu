import SwiftUI
import UIKit

/// Floating tab capsule placement. The redesign keeps the capsule 26 pt above the physical bottom.
/// The old -8 pt padding only matches a 34 pt home indicator. Later SDKs, iPad, and extra system
/// insets report a different bottom inset, so the offset is derived from that inset.
enum TabCapsuleLayout {
    /// 48 pt row plus 6 pt of padding on each side.
    static let barHeight: CGFloat = 60
    static let edgeGap: CGFloat = 26
    /// Gap above the capsule. Together with a 34 pt inset this is the previous 72 pt clearance.
    static let contentGap: CGFloat = 20
    /// First frame, before a window exists. Matches the previous iPhone layout.
    static let legacyPhoneInset: CGFloat = 34

    static func bottomPadding(bottomInset: CGFloat) -> CGFloat {
        edgeGap - bottomInset
    }

    static func contentClearance(bottomInset: CGFloat) -> CGFloat {
        max(0, barHeight + edgeGap - bottomInset) + contentGap
    }
}

/// Player controls are laid out in a full-screen layer. If SwiftUI reports a zero inset while
/// UIKit still has one (seen with newer safe-area bars), keep the larger edge so controls stay
/// clear of the status bar, home indicator, and landscape sensor housing.
enum PlayerSafeArea {
    static func resolve(swift: EdgeInsets, window: UIEdgeInsets) -> EdgeInsets {
        EdgeInsets(top: max(swift.top, window.top),
                   leading: max(swift.leading, window.left),
                   bottom: max(swift.bottom, window.bottom),
                   trailing: max(swift.trailing, window.right))
    }
}

enum ActiveWindowScene {
    static func scene() -> UIWindowScene? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        return scenes.first { $0.activationState == .foregroundActive } ?? scenes.first
    }

    static func safeInsets() -> UIEdgeInsets {
        guard let scene = scene() else { return .zero }
        let window = scene.windows.first(where: \.isKeyWindow) ?? scene.windows.first
        return window?.safeAreaInsets ?? .zero
    }

    static func bottomInset() -> CGFloat {
        guard let scene = scene() else { return TabCapsuleLayout.legacyPhoneInset }
        let window = scene.windows.first(where: \.isKeyWindow) ?? scene.windows.first
        guard let window else { return TabCapsuleLayout.legacyPhoneInset }
        return window.safeAreaInsets.bottom
    }
}

extension View {
    /// Inline title on the page colour. iOS 26 and later otherwise use a transparent bar and
    /// scroll content under the title. Screens that already hide the bar stay hidden.
    func stvInlineTitle() -> some View {
        navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(STVTheme.bg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }

    /// Opaque sheet, scrollable when a detent is too short, keyboard can be dragged away.
    /// Does not change detents or corner radius chosen by the caller.
    func stvSheetChrome() -> some View {
        presentationBackground(STVTheme.sheet)
            .stvSheetKeyboard()
    }

    func stvSheetKeyboard() -> some View {
        presentationContentInteraction(.scrolls)
            .scrollDismissesKeyboard(.interactively)
    }
}

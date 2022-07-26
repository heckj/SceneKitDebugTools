//
//  PasteboardHelpers.swift
//
//
//  Created by Joseph Heck on 1/18/22.
//

import Foundation

#if os(macOS)
    import AppKit
    @discardableResult
    /// Writes a string value into the general pasteboard.
    func writeStringToPasteboard(_ value: String) -> Bool {
        NSPasteboard.general.clearContents()
        return NSPasteboard.general.setData(value.data(using: .utf8), forType: .string)
    }
#endif

#if os(iOS)
    import UIKit
    /// Writes a string value into the general pasteboard.
    func writeStringToPasteboard(_ value: String) {
        UIPasteboard.general.setValue(value, forPasteboardType: "public.plain-text")
    }
#endif

#if os(tvOS) || os(watchOS)
    func writeStringToPasteboard(_: String) {}
#endif

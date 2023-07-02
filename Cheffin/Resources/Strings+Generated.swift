// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Localizable.strings
  ///   Cheffin
  /// 
  ///   Created by Adryan Eka Vandra on 23/06/23.
  internal static let appName = S.tr("Localizable", "appName", fallback: "Cheffin")
  /// ====================== BON-APETIT PAGE ======================
  internal static let bonApetit = S.tr("Localizable", "bonApetit", fallback: "Bon Apetit!")
  /// Congratulations on successfully making your %@!
  internal static func congratulationMessage(_ p1: Any) -> String {
    return S.tr("Localizable", "congratulationMessage", String(describing: p1), fallback: "Congratulations on successfully making your %@!")
  }
  /// Essential Utensils
  internal static let essentialUtensils = S.tr("Localizable", "essentialUtensils", fallback: "Essential Utensils")
  /// ====================== RECIPE PAGE ======================
  internal static let ingredients = S.tr("Localizable", "ingredients", fallback: "Ingredients")
  /// ====================== Failure ======================
  internal static let recipeFailure = S.tr("Localizable", "recipeFailure", fallback: "We encountered error while fetching the recipes, please refresh the page.")
  /// Step-By-Step
  internal static let stepByStep = S.tr("Localizable", "stepByStep", fallback: "Step-By-Step")
  /// Step-By-Step Mode
  internal static let stepByStepMode = S.tr("Localizable", "stepByStepMode", fallback: "Step-By-Step Mode")
  /// ====================== STEP-BY-STEP PAGE ======================
  internal static func stepOf(_ p1: Int, _ p2: Int) -> String {
    return S.tr("Localizable", "stepOf", p1, p2, fallback: "%d of %d")
  }
  /// Take a picture
  internal static let takeAPicture = S.tr("Localizable", "takeAPicture", fallback: "Take a picture")
  /// try saying
  internal static let trySaying = S.tr("Localizable", "trySaying", fallback: "try saying")
  /// Utensils
  internal static let utensils = S.tr("Localizable", "utensils", fallback: "Utensils")
  /// "%@"
  internal static func voiceCommand(_ p1: Any) -> String {
    return S.tr("Localizable", "voiceCommand", String(describing: p1), fallback: "\"%@\"")
  }
  /// ====================== HOME PAGE ======================
  internal static let welcomeToCheffin = S.tr("Localizable", "welcomeToCheffin", fallback: "Welcome to Cheffin!")
  /// What do you want to cook today?
  internal static let whatDoYouWantToCookToday = S.tr("Localizable", "whatDoYouWantToCookToday?", fallback: "What do you want to cook today?")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

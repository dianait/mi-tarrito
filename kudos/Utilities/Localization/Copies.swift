import Foundation
import SwiftUI

extension String {
    var localized: String {
        return LanguageManager.shared.localizedString(for: self)
    }
}

enum Copies {
    private static let minScreenWidth = CGFloat(380)
    static func viewTitle(screenWidth: CGFloat) -> String {
        screenWidth < minScreenWidth ? "celebrate_title_short".localized : "celebrate_title_long".localized
    }

    static func viewDecription(screenWidth: CGFloat) -> String {
        screenWidth < minScreenWidth ? "view_description_short".localized : "view_description_long".localized
    }

    static func editDescription(screenWidth: CGFloat) -> String {
        screenWidth < minScreenWidth ? "edit_description_short".localized : "edit_description_long".localized
    }

    static var editTitle: String {
        return "edit_title".localized
    }

    static var aboutTitle: String {
        return "about_title".localized
    }

    static var setingsTitle: String {
        return "settings_title".localized
    }

    enum LanguageSettingsView {
        static var title: String {
            return "select_language".localized
        }
    }

    enum ConfirmationView {
        static var title: String {
            return "confirmation_title".localized
        }

        static var description: String {
            return "confirmation_description".localized
        }

        static var button: String {
            return "confirmation_button".localized
        }
    }

    enum StickisView {
        static var accomplishmentExample1: String {
            return "accomplishment_example1".localized
        }

        static var accomplishmentExample2: String {
            return "accomplishment_example2".localized
        }

        static var accomplishmentExample3: String {
            return "accomplishment_example3".localized
        }
    }

    enum StickiesViewOverView {
        static var textEditorPlaceHolder: String {
            return "text_editor_placeholder".localized
        }
    }

    enum Colors: String, CaseIterable {
        case orange
        case yellow
        case green
        case blue
    }

    enum Carrusel {
        enum EmptyState {
            static var title: String {
                return "carousel_empty_title".localized
            }

            static var description: String {
                return "carousel_empty_description".localized
            }

            static var benefit1: String {
                return "carousel_empty_benefit1".localized
            }

            static var benefit2: String {
                return "carousel_empty_benefit2".localized
            }

            static var benefit3: String {
                return "carousel_empty_benefit3".localized
            }

            static var addNewButton: String {
                return "carousel_empty_add_button".localized
            }
        }
    }

    enum AboutMe {
        static var title: String {
            return "about_me_title".localized
        }

        static var description: String {
            return "about_me_description".localized
        }

        enum Privacy {
            static var title: String {
                return "privacy_title".localized
            }

            static var description: String {
                return "privacy_description".localized
            }
        }

        enum Timeline {
            static var title: String {
                return "timeline_title".localized
            }

            private enum Step1 {
                static var title: String {
                    return "step1_title".localized
                }

                static var description: String {
                    return "step1_description".localized
                }
            }

            private enum Step2 {
                static var title: String {
                    return "step2_title".localized
                }

                static var description: String {
                    return "step2_description".localized
                }
            }

            private enum Step3 {
                static var title: String {
                    return "step3_title".localized
                }

                static var description: String {
                    return "step3_description".localized
                }
            }

            private enum Step4 {
                static var title: String {
                    return "step4_title".localized
                }

                static var description: String {
                    return "step4_description".localized
                }
            }

            static var steps: [(title: String, description: String, icon: String)] {
                return [
                    (Step1.title, Step1.description, "lightbulb.fill"),
                    (Step2.title, Step2.description, "brain.head.profile"),
                    (Step3.title, Step3.description, "bird.fill"),
                    (Step4.title, Step4.description, "iphone.gen3"),
                ]
            }
        }

        enum Footer {
            static var title: String {
                return "footer_title".localized
            }

            static var socialLinks: String {
                return "footer_social_links".localized
            }
        }
    }

    enum ErrorView {
        static var title: String {
            return "error_view_title".localized
        }

        static var message: String {
            return "error_view_message".localized
        }

        static var description: String {
            return "error_view_description".localized
        }
    }
}

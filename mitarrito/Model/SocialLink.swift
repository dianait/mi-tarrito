import Foundation

struct SocialLink {
    let name: String
    let iconName: String
    let url: URL
}

let socialLinks: [SocialLink] = [
    SocialLink(
        name: "GitHub",
        iconName: "github",
        url: URL(string: "https://github.com/dianait")!
    ),
    SocialLink(
        name: "BlueSky",
        iconName: "bluesky",
        url: URL(string: "https://bsky.app/profile/dianait.dev")!
    ),
    SocialLink(
        name: "LinkedIn",
        iconName: "linkedin",
        url: URL(string: "https://www.linkedin.com/in/dianahdezsoler/")!
    ),
]

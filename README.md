# DripKit

The Swift Package that interacts with the API and serves the required outfit data to the client.

## Installation

### Swift Package Manager

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. It is in early development, but WoofKit supports its use on supported platforms.

Once you have your Swift package set up, adding DripKit as a dependency is as easy as adding it to the dependencies value of your Package.swift.

dependencies: [
    .package(url: "https://github.com/arvindravi/DripKit.git")
]

## Usage

1. Import DripKit 

```swift
import DripKit
```

2. Fetch a list of Winter Outfits

```swift
let outfits = try await DripKit.shared.fetchWinterOutfits()
```

## Contributing
Pull requests are welcome.

## License
[MIT](https://choosealicense.com/licenses/mit/)


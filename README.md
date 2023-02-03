# Gloabl Fish Watch

GloablFishWatch is an open source APIClient with ergonomic swift bindings around the globalfishingwatch.org API.

More info: https://globalfishingwatch.org/our-apis/documentation#get-all-events-post-endpoint

# Installation

To use use Gloabl Fish Watch simply add it to your project as a SPM module.

# Requirements

The GloablFishWatch codebase supports iOS and requires Xcode 10.0 or newer. The CareKit framework has a Base SDK version of 11.0 and supprts accessing the API data with a handler. It also provides methods Combine's async/await architecture.

# Demo

The Package contains a demo called FishDemo. To run the demo generate an API Key from [Global Fish Watch](https://globalfishingwatch.org/our-apis/tokens) and replce `let apiKey = "UPDATE ME"` with your API key then build and run.

# Getting Started

### Installation: SPM

GloablFishWatch can be installed via SPM. Create a new Xcode project and navigate to `File > Swift Packages > Add Package Dependency`. Enter the url `https://github.com/mmroz/GloablFishWatch` and tap `Next`. Choose the `main` branch, and on the next screen, check off the packages as needed.

### Event

https://globalfishingwatch.org/our-apis/documentation#get-one-by-event-id

UIKit:

```swift
public func event(id: String, dataset: EventsApiDataSet, completion: @escaping ((Result<Event, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func event(id: String, dataset: EventsApiDataSet) async -> Result<Event, GlobalFishWatchError>
```

### All Events

https://globalfishingwatch.org/our-apis/documentation#get-all-events-post-endpoint

UIKit:

```swift
public func allEvents(limit: Int, offset: Int, sort: EventSort?, datasets: Set<EventsApiDataSet>, vessels: [String]?, types: Set<EventType>?, endDate: Date?, startDate: Date?, confidences: [Int]?, encounterTypes: Set<EventEncounterType>?, completion: @escaping ((Result<EventListResponse, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func allEvents(limit: Int, offset: Int, sort: EventSort?, datasets: Set<EventsApiDataSet>, vessels: [String]?, types: Set<EventType>?, endDate: Date?, startDate: Date?, confidences: [Int]?, encounterTypes: Set<EventEncounterType>?) async -> Result<EventListResponse, GlobalFishWatchError>
```

### Vessel Basic Search

https://globalfishingwatch.org/our-apis/documentation#basic-search

UIKit:

```swift
public func vesselSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, suggestFields: [String]?, queryFields: [String]?, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func vesselSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, suggestFields: [String]?, queryFields: [String]?) async -> Result<VesselSearchResponse, GlobalFishWatchError>
```

### Vessel Advanced Search

https://globalfishingwatch.org/our-apis/documentation#advanced-search

UIKit:

```swift
public func vesselAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func vesselAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String) async -> Result<VesselSearchResponse, GlobalFishWatchError>
```

### Vessel Advanced Search

https://globalfishingwatch.org/our-apis/documentation#advanced-search

UIKit:

```swift
public func vesselAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func vesselAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String) async -> Result<VesselSearchResponse, GlobalFishWatchError>
```

### Vessel

https://globalfishingwatch.org/our-apis/documentation#get-vessel-by-id

UIKit:

```swift
func vessel(id: String, dataset: VesselApiDataSet, completion: @escaping ((Result<Vessel, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func vessel(id: String, dataset: VesselApiDataSet) async -> Result<Vessel, GlobalFishWatchError>
```

### Vessels

https://globalfishingwatch.org/our-apis/documentation#get-list-of-vessels-filtered-by-ids

UIKit:

```swift
public func vessels(ids: [String], datasets: Set<VesselApiDataSet>, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void))
```

Async:

```swift
public func vessels(ids: [String], datasets: Set<VesselApiDataSet>) async -> Result<Vessel, GlobalFishWatchError>
```

# Getting Help <a name="getting-help"></a>

GitHub is our primary forum for GloablFishWatch. Feel free to open up issues about questions, problems, or ideas.

# DogGalleryApp
A Flutter-based project with the BLoC pattern and Repository pattern

**Project structure overview:**

![screenshot](assets/images/project_structure.png){:height="200px" width="100px"}.

**Explanation of each component:**
* Bloc (Business Logic Component): Handles app logic & state transitions in response to user actions (e.g., button press to fetch dog image).
* Repository: Acts as a middle layer between the domain logic and the data layer. It hides the data source implementation (API, local DB, etc.) from the business logic.
* Service: Handles real API calls (networking). In Clean Architecture, this is called a Remote Data Source.
* Model: Represents structured data passed through your app. In Clean Architecture, the term "Entity" is used in the Domain Layer (logic-focused), while "Model" is often used for raw API parsing in the Data Layer.

**Lifecycle and state flow of BLoC:**
[User Action]

↓
[ImageBloc.add(GetRandomImage)]

↓
[on<GetRandomImage> → Calls UseCase]

↓
[UseCase calls Repository → API request]

↓
[Repository returns ResponseModel]

↓
[ImageBloc emits ImageLoaded]

↓
[UI receives new state and rebuilds]
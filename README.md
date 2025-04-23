# Spendid
### Your personal finance and budget tracking app.

## Architecture
**Clean Layered Architecture and MVVM**

<p>
<img src= /repo-assets/cleanlayer.png width="400">
</p>

### Layers
* **Domain Layer** = Entities, Use Cases and Repository Protocols
* **Data Layer** = DTOs, Mappers and Repository Implementations
* **Presentation Layer (MVVM)** = ViewModels and SwiftUI Views

## Used Concepts
* [Coordinator Pattern](Spendid/Presentation/Modules/Home/HomeCoordinator.swift)
* [Data Transfer Objects (DTO)](Spendid/Data/DTOs/BudgetDTO.swift)
* SwiftUI Views with UIKit Navigation
* [Dependency Container](https://github.com/exproot/DependencyContainer) using Service-Locator Pattern

## Requirements
* iOS version 15.6+
* Swift 6.0

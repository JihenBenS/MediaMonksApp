# MediaMonksApp

## Compatibility
- Xcode: 13.2.1
- Deployment target: 15.0

## Project Overview
- SwiftUI
- Combine
- Async/Await

## Viper Architecture Overview

![ViperArchitecture (1)](https://user-images.githubusercontent.com/99616722/154881679-b5d3d742-6764-4b6e-8584-f9431e2aa127.png)

- SwiftUI View.
- Interactor: A class that mediates between the presenter and the data. It takes direction from the presenter.
- Presenter: The “traffic cop” of the architecture, directing data between the view and interactor.
- Entity: Models.
- Router or coordinator: controls navigation, instantiating the next screen and its components.

## External Dependencies
- KingFisher 
- Pods are already added to the git project.

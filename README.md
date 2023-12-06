# Restaurant Table Reservation App 🍽️
## Overview
This Swift UIkit app serves as the front-end for a table reservation system. More details about BE [here](https://github.com/tatkagore/booking-v-2).

App implements the Model-View-Presenter (MVP) architecture to manage the table reservation system. It interacts with a Node.js backend built with Express and PostgreSQL, providing a structured approach to handling user interactions, business logic, and data management.

### MVP Architecture
The app is structured around the Model-View-Presenter architecture, which divides responsibilities as follows:
- **Model:** Represents data entities and manages the interaction with the backend API for data retrieval and manipulation.
- **View:** Displays the user interface and communicates user actions to the presenter.
- **Presenter:** Acts as an intermediary between the model and view, handling user inputs, updating the model, and updating the view accordingly.

## Features
- **Reservation Management:** Users can view, create, update, and delete reservations through a well-defined MVP structure.
- **Backend Connectivity:** Utilizes the MVP pattern to connect seamlessly with the Node.js backend via RESTful API endpoints for efficient data operations.


### Backend Integration
The app seamlessly integrates with the backend created using Node.js, Express, and PostgreSQL. It leverages the backend's API endpoints for functionalities like creating, updating, and deleting reservations.


## Technologies Used
- Swift
- UIKit
- Networking Libraries (e.g., URLSession, Alamofire)
- JSON Parsing

## How to Use
### Requirements:
- iOS device or simulator
- Connection to the internet

### Setup Steps:
1. Clone or download this repository: [GitHub - tatkagore/booking-v-2](https://github.com/tatkagore/booking-v-2).
2. Open the project in Xcode.
3. Ensure the backend server is running and accessible.
4. Update the app's configurations (e.g., API endpoint URLs) if necessary.
5. Build and run the app on a simulator or device.

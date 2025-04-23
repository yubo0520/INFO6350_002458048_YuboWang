# HyperGarageSale

A simple mobile application built with Flutter and Firebase for listing and browsing used items, simulating a digital garage sale.

## Features

*   **User Authentication:**
    *   Email/Password registration and login.
    *   Google Sign-in (currently Android only).
*   **Browse Posts:** View a list of all items posted for sale, ordered by creation date.
*   **Create Posts:** Add new items with title, price, description, and up to 4 images (from camera or gallery).
*   **View Post Details:** See detailed information about an item, including a swipeable image carousel and full description.
*   **Image Handling:** Upload images to Firebase Storage, view images with basic error/loading states.

## Technology Stack

*   **Frontend:** Flutter
*   **Backend:** Firebase
    *   **Authentication:** Manages user sign-up and sign-in.
    *   **Firestore:** NoSQL database for storing post and user data.
    *   **Storage:** Stores uploaded images for posts.





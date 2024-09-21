# Rize-Task

## Project Overview 📝

This repository contains the code for the Rize Mobile Engineer Intern Task, a Flutter-based mobile application designed to manage job postings. The task is aimed at assessing Flutter development skills through the creation of a simplified Jobs Page app.

[Click here to see App Video](https://firebasestorage.googleapis.com/v0/b/pythoncli-e6c14.appspot.com/o/RPReplay_Final1726887607.mov?alt=media&token=60b48c5a-ab90-45b9-9138-9b05eebef9dc)

## Features 🚀

The application includes the following features:

- **Add New Job Post**: Users can create new job posts using mock data or a simple form.
- **View Job Post List**: Users can view a list of all job posts.
- **Delete Job Post**: Users can remove job posts.
- **Job Details Modal**: Users can view detailed information about a job post in a modal.
- **Search by Title**: Users can search for job posts by title.

## Additional Features 👍🏻

- **Scroll-Based Loading (Simplified Pagination)**: The app loads more jobs as the user scrolls to the bottom.
- **Responsive Design**: The app is optimized for both portrait and landscape orientations.
- **State Management**: State management is handled using `setState()` or any preferred state management solution.

## Technical Specifications 💻

- **Platform**: Flutter
- **Language**: Dart
- **Data Storage**: Mock data (no backend required)
- **State Management**: `setState()` or any preferred state management solution

## Getting Started 🚀

To run this project locally, follow these steps:

### Clone the Repository

```bash
git clone https://github.com/e7gx/Rize-Task.git
```

### Navigate to the Project Directory

```bash
cd Rize-Task
```

### Run the Application

```bash
flutter run
```

## Project Structure

```plaintext
lib/
├── main.dart                   # Entry point of the application
├── view/
│   ├── screens/
│   │   ├── jobs/               # Contains screens related to job functionalities
│   │   ├── jobs/widgets/       # Contains reusable widgets for job-related features
├── controller/
│   ├── theme/                  # Contains theme-related files for colors and styles
│   ├── helpers/                # Contains helper functions and extensions
├── chat/                       # Contains chat-related functionalities
├── model/                       # Contains job_model-related functionalities 
├── assets/                     # Contains images and other asset files
```

## Packages

```yaml
dependencies:
    cupertino_icons: ^1.0.8
    lottie: ^3.1.2
    flutter_native_splash: ^2.4.1
    fl_chart: ^0.68.0
    http: ^1.2.2
    typewritertext: ^3.0.8
    flutter_dotenv: ^5.1.0
    introduction_screen: ^3.1.14
    shared_preferences: ^2.3.2
    google_nav_bar: ^5.0.6
    flutter_launcher_icons: ^0.13.1
    intl: ^0.19.0
    smooth_page_indicator: ^1.2.0+3
    flutter_screenutil: ^5.9.3
    flutter_svg: ^2.0.10+1
    readmore: ^3.0.0
```

## AI Chat Integration

To enable the AI chat feature, you need to create a `.env` file in the root directory of the project and add your OpenAI API key:

```plaintext
OPENAI_API_KEY=your_openai_api_key_here
```

Make sure to replace `your_openai_api_key_here` with your actual OpenAI API key.

# Login
Demonstration of MVVM Pattern leveraging Dependency Injection

This project is based upon the Ray Wenderlich book Advanced iOS App Architecture
Project is working through a version the MVVM Project working only on implementing the Login logic
Right now the project only displays a Red screen when run

To install you will need to have Pods installed

# Install Instructions
Run Pod install to install dependencies

# State Types
There are state types in the app MainState and OnboardingState. These are used to determine which controller and associated view to the user. Example Welcome displays the welcome screen with buttons to choose where in the app to go next (Sign In or Sign Up)

# Dependency Containers
Currently there are two AppDependencyContainer and OnboardingDependencyContainer. Both assemble and configure the different UI View Controllers associate with part of the app. AppDependencyContainer is concerned with the MainViewController and  and associated LaunchingViewController, OnboardingViewController, and SignedInViewController. OnboardingDependencyContainer is concerned with the dependent WelcomeViewController, SignInViewController and SignUpViewController.

# Base Types
The Common UIKit contains the root level items that the app inherits from that provide common functionality. BaseView contains the common methods for a UIView. BaseViewController has common methods for displaying a controller. BaseNavigationController contains all the common methods for displaying the navigation controller views. NavigationAction provides a means to determine if a view has been displayed or is to be displayed

# Open Issue
There currently a non-breaking error "Unbalanced calls to begin/end appearance transitions for <Login.MainViewController: 0x104e859a0>."

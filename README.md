# Login
Demonstration of MVVM Pattern leveraging Dependency Injection

This project is based upon the Ray Wenderlich book Advanced iOS App Architecture
Project. I am working through a version the MVVM Project working only on implementing the Login logic
Right now the project takes you to the welcome screen with sign up and sign in buttons

To install you will need to have Pods installed

# Install Instructions
Run Pod install to install dependencies

# State Types
There are state types in the app MainState and OnboardingState. These are used to determine which controller and associated view to the user. Example Welcome displays the welcome screen with buttons to choose where in the app to go next (Sign In or Sign Up)

# Dependency Containers
Currently there are two AppDependencyContainer and OnboardingDependencyContainer. Both assemble and configure the different UI View Controllers associate with part of the app. AppDependencyContainer is concerned with the MainViewController and  and associated LaunchingViewController, OnboardingViewController, and SignedInViewController. OnboardingDependencyContainer is concerned with the dependent WelcomeViewController, SignInViewController and SignUpViewController.

# Base Types
The Common UIKit contains the root level items that the app inherits from that provide common functionality. BaseView contains the common methods for a UIView. BaseViewController has common methods for displaying a controller. BaseNavigationController contains all the common methods for displaying the navigation controller views. NavigationAction provides a means to determine if a view has been displayed or is to be displayed.

# Themes
Added theme for light and dark as well as support to change colors based upon the dark or light theme selected in Settings on the IPhone. This does not change the theme if the application is running but will change if you shut down the app and start again. More to do there.

# Button Layer Styles
You cannot put the style properties into the theme so created a common Button struct to contain them so they can be reused. 

# Text Field Styles
Now have a UITextFieldExtensions class that handles formatting text fields to have underlines and to be able to control the color of placeholder text

# Color
Also created primary color in struct Color which matches the logo and Icon colors


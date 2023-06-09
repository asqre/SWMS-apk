# Smart Waste Management System (SWMS)

The Smart Waste Management System (SWMS) is a project that aims to provide real-time status and data of dustbins through various sensors such as Arduino, GSM, and ultrasonic sensors. Additionally, the system utilizes the shortest path algorithm in a directed acyclic graph to optimize the collection routes of the dustbins. The SWMS app allows users to locate and view the dustbins on Google Maps, providing a comprehensive waste management solution.

A new Flutter project.

Our team has been working hard, and soon we will share with you our newest app: SWMS apk update.
With this app, you'll be able to manage your surrounding wastes like never before. 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### To execute live application, kindly proceed with the installation process of the Android package file located at the following directory: 
                      swms/SWMS-apk/build/app/outputs/flutter-apk/app-release.apk,
on your Android device.

## Features

- Real-time monitoring of dustbin status and data
- Integration of Arduino, GSM, and ultrasonic sensors for data collection
- Optimized collection routes using the shortest path algorithm
- SWMS app for dustbin visualization on Google Maps
- User-friendly interface for easy navigation and interaction
- Notification system for alerts and updates on dustbin status
- Historical data analysis for performance evaluation and future improvements
- Scalable architecture to accommodate additional dustbins and sensors

## Installation and Setup

To install and set up the SWMS, please follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/your-username/swms.git
```

2. Install the required dependencies. Ensure you have the necessary packages installed for Arduino, GSM, and ultrasonic sensors as specified in the project documentation.

3. Connect the sensors to the Arduino board following the provided circuit diagram.

4. Configure the Arduino board and GSM module according to the project specifications and connect them to the appropriate pins.

5. Set up the SWMS app on your mobile device by downloading the SWMS APK file and installing it.

6. Launch the SWMS app and grant necessary permissions (such as location access) for proper functioning.

7. Ensure a stable internet connection is available for real-time data transmission.

## Usage

The SWMS project consists of the following components:

1. **Arduino and Sensors**: The Arduino board is connected to the ultrasonic sensors and GSM module. It collects data from the sensors and transmits it to the SWMS server for processing.

2. **SWMS Server**: The server receives data from the Arduino and processes it to determine the status and optimal collection routes of the dustbins. It also provides data for the SWMS app to visualize the dustbins on Google Maps.

3. **SWMS App**: The mobile app allows users to view the dustbins on Google Maps, monitor their status, and receive notifications. It provides an intuitive interface for interacting with the system and accessing real-time data.

## Hardware Interface

![image](https://github.com/asqre/SWMS-apk/assets/62792214/81a82bfe-5cbb-4a9a-873f-5406a2b7af51)

## Application Interface

![image](https://github.com/asqre/SWMS-apk/assets/62792214/16b55a21-00ac-48e2-a193-9c83db0212f6)
![image](https://github.com/asqre/SWMS-apk/assets/62792214/68830357-2171-43c1-b0d1-b84e689b598f)
![WhatsApp Image 2023-06-10 at 4 32 27 AM](https://github.com/asqre/SWMS-apk/assets/62792214/fe50c8f2-022c-42f5-af65-8407e3e2a1aa)


![image](https://github.com/asqre/SWMS-apk/assets/62792214/d31c8031-ae3a-4e62-be8f-df018842dc54)
![image](https://github.com/asqre/SWMS-apk/assets/62792214/223901b7-368a-40d4-9935-addd5495b7d3)
![image](https://github.com/asqre/SWMS-apk/assets/62792214/04a1948f-0e9f-47d4-a882-fbf10ed62c60)


To use the SWMS:

1. Ensure that the Arduino board and sensors are properly connected to dustbin and powered on.

2. Launch the SWMS app on your mobile device and sign in using your credentials.

3. The app will display the dustbins' locations on Google Maps along with their real-time status.

4. To view optimized collection routes, select the desired area or region on the app, and the shortest path algorithm will calculate and display the optimal routes.

5. Users can also receive notifications and alerts regarding the dustbin status, such as when a dustbin is full and needs emptying.

6. The app allows users to interact with the system, report issues, or request a collection through the provided interface.

## Future Enhancements

The Smart Waste Management System has potential for further enhancements and improvements. Some suggested future enhancements include:

- Integration of additional sensors for more accurate data collection, such as fill-level sensors or temperature sensors.
- Integration with machine learning algorithms to predict and optimize dustbin collection schedules based on historical data and other factors like weather conditions or special events.
- Implementation of a centralized management system to monitor multiple SWMS installations and provide comprehensive analytics and reporting.
- Development of a web-based dashboard for administrators to monitor and manage the SWMS system, generate reports, and configure

## Contact

If you have any questions or suggestions, feel free to contact us at [amitanand.asqre@gmail.com]

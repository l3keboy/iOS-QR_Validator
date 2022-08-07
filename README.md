# iOS QR Validator
QR Validator is an app which enables you to scan QR-Codes and check the safety of the corresponding URL (Using the Google Safe Browsing API). When a URL is seen as safe, this URL can be opened (or copied, depending on your preferences). When an URL is unsafe, an explanation will be given.<br>
Tested with iOS 15.0 and above with iPhone 8 and newer!

<br>

## QR Validator features
The QR Validator app has different features listed below (in no particular order):
- Scan QR codes;
- Detect links from QR code metadata (display if no link is found);
- Validate the safety of links (using Google Safe Browsing API);
- Choose to either automatically open a safe URL or display a screen;
- Choose between in-app browser or switch to Safari;
- Select the types of vulnerabilities to check for;

<br>

## Using the app
The app is currently not available in the app store. If you want to use this app there are a couple steps you need to follow[^1]:
1. Fork and Clone (or just download) this repository;
2. Open the app project using Xcode;
3. Create a new file called **secrets.plist**;
4. Get a Google Safe Browsing API key (please refer to the following [Google Safe Browsing documentation](https://developers.google.com/safe-browsing));
5. Add a new entry in the, at step 3, created **secrets.plist** file. The **Key** name must be: *googleSafeBrowsingAPIKey* - The **Type** must be *string* and the **Value** must be the, at step 4, created API key;
6. Connect your iPhone to the MacBook;
7. Build the project to your (connected) iPhone by pressing the **play (▷)** button (see the image below!);

![BuildingTheApp](/assets/BuildingTheApp.png)

<br>

## TimeIt Screens preview
![Permissions](/assets/permissions.png)
![SettingsView](/assets/settingsView.png)
![HelpView](/assets/helpView.png)

<br>

## License
This code is developed under the [MIT License](https://opensource.org/licenses/MIT). The license can be found here: [LICENSE](LICENSE)

[^1]: MacOS and Xcode are required!
//
//  File.swift
//  
//
//  Created by Enrico Maricar on 11/09/24.
//

import Foundation

class InfoPlistGenerator {
    func generateInfoPlist(appName: String, bundleId: String, platform: String, deploymentTarget: String, outputFolder: String) {
        let plistContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>CFBundleName</key>
            <string>$(PRODUCT_NAME)</string>
            <key>CFBundleIdentifier</key>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
            <key>CFBundleVersion</key>
            <string>$(CURRENT_PROJECT_VERSION)</string>
            <key>CFBundleShortVersionString</key>
            <string>$(MARKETING_VERSION)</string>
            <key>CFBundleExecutable</key>
            <string>$(EXECUTABLE_NAME)</string>
            <key>CFBundlePackageType</key>
            <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
            <key>LSRequiresIPhoneOS</key>
            <true/>
            <key>UILaunchStoryboardName</key>
            <string>LaunchScreen</string>
            <key>UISupportedInterfaceOrientations</key>
            <array>
                <string>UIInterfaceOrientationPortrait</string>
                <string>UIInterfaceOrientationLandscapeLeft</string>
                <string>UIInterfaceOrientationLandscapeRight</string>
            </array>
            <key>UISupportedInterfaceOrientations~ipad</key>
            <array>
                <string>UIInterfaceOrientationPortrait</string>
                <string>UIInterfaceOrientationPortraitUpsideDown</string>
                <string>UIInterfaceOrientationLandscapeLeft</string>
                <string>UIInterfaceOrientationLandscapeRight</string>
            </array>
            <key>UILaunchScreen</key>
            <dict/>
            <key>UIAppFonts</key>
            <array/>
            <key>NSAppTransportSecurity</key>
            <dict>
                <key>NSAllowsArbitraryLoads</key>
                <true/>
            </dict>
            <key>UIApplicationSceneManifest</key>
            <dict>
                <key>UIApplicationSupportsMultipleScenes</key>
                <true/>
                <key>UISceneConfigurations</key>
                <dict>
                    <key>UIWindowSceneSessionRoleApplication</key>
                    <array>
                        <dict>
                            <key>UISceneConfigurationName</key>
                            <string>Default Configuration</string>
                            <key>UISceneDelegateClassName</key>
                            <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                            <key>UIStoryboardName</key>
                            <string>Main</string>
                        </dict>
                    </array>
                </dict>
            </dict>
            <key>UIViewControllerBasedStatusBarAppearance</key>
            <false/>
            <key>UIStatusBarStyle</key>
            <string>UIStatusBarStyleLightContent</string>
            <key>CFBundleDevelopmentRegion</key>
            <string>$(DEVELOPMENT_LANGUAGE)</string>
        </dict>
        </plist>
        """
        
        let plistFilePath = "\(outputFolder)/Info.plist"
        
        do {
            try plistContent.write(toFile: plistFilePath, atomically: true, encoding: .utf8)
            print("Generated Info.plist at: \(plistFilePath)")
        } catch {
            print("Gagal menulis Info.plist: \(error)")
        }
    }

}

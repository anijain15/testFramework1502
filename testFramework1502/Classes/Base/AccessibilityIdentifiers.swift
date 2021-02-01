//
//  AccessibilityIdentifiers.swift
//  Wynk MusicUITests
//
//  Created by B0209134 on 01/07/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest


public struct AccessibilityIdentifiers{
    
    public struct CommonTabs {
        public static let radioTabButton = "Radio"
    }
    
    public struct HomePage {
        
        public static let retry:XCUIElement =   app.staticTexts["Oops, something went wrong. Please try again."]
        
        public static let miniPlayerPauseButton = app.buttons["miniplayer pause"]
        public static let miniPlayerPlayButton = app.buttons["miniplayer play"]
        public static let removeAddButton:XCUIElement = app.tables.buttons["removeAds"]
        public static let viewAllSettings:XCUIElement = app.tables.staticTexts["View All Settings"]
        public static let retryButton:XCUIElement = app.buttons["Retry"]
        public static let retryButtonOnHomePage:XCUIElement = app.buttons["retry"]
        public static let skipButton:XCUIElement = app.buttons["Skip"]
        public static let crossButtonPlayListBanner = app.buttons["crossbutton"]
        public static let featureBanner = app.staticTexts["Wynk Top Picks"]
        public static let myPersonalStationBanner = app.staticTexts["My Personal Station"]
        public static let more = app.staticTexts.matching(NSPredicate(format:"label CONTAINS 'More'")).element(boundBy: 1)
        public static let miniPlayerSongTitle = app.staticTexts["miniplayer_songTitle"]
        public static let downloadAllButton = app.tables.children(matching: .button).element(boundBy: 0)
        public static let playButtonOnSingleCell = app.buttons.matching(NSPredicate(format: "label CONTAINS 'play'")).element(boundBy: 0)
        public static let moreCount = app.staticTexts.matching(NSPredicate(format:"label CONTAINS 'More'")).count
        
    }
    
    public struct interstitialPageOrBanner {
        public static let awesomeButton:XCUIElement = app.buttons["Awesome!"]
    }
    
    
    public struct BottomTabs {
        public static let homeTabButton = "home_tabbaritem"
        public static let myMusicTabButton = "my_music_tabbaritem"
        public static let radioTabButton = "radio_tabbaritem"
        public static let updatesTabButton = "updates_tabbaritem"
        public static let myAccountTabButton = "my_account_tabbaritem"
        public static let wynkStageButton = ""
        
    }
    
    public struct Registration{
        public static let skipButton = "Skip"
        public static let phoneNumberInputField = "signup_phonenumber_textfield"
        public static let otpInputField = "signup_verify_pin_textfield"
        public static let verifyPin:XCUIElement = app.buttons["Verify PIN"]
        public static let sendVerificationPinButton:XCUIElement = app.buttons["Send Verification PIN"]
    }
    
    public struct Settings{
        public static let registerAndPayButton = "Register Now and Pay"
        public static let myProfile:XCUIElement = app.staticTexts["My Profile"]
        public static let backButtonOnHeader:XCUIElement = app.buttons["listScreenBackRed"]
        public static let resetAppButton:XCUIElement = app.staticTexts["Reset App"]
        public static let okayOnAlertAfterReset:XCUIElement = app.buttons["Okay"]
        public static let saveOnMyProfile:XCUIElement = app.buttons["ViewMore"]
    }
    
    public struct Common{
        public static let htIconAtTopRight = "hellotuneDefault"
        public static let congratsPopup = "Congratulations"
        public static let searchIcon = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Search'")).element(boundBy: 0)
    }
    
    public struct HelloTune{
        public static let htManagementScreenInfoButton = "hellotune Info"
        public static let htManagementScreenPopupContinueButton = "Continue"
        public static let htManagementScreenTopCardActivateOrExtendButton = "htmanagement_topcard_activateButton"
        public static let htManagementScreenTopCardOverflowButton = "htmanagement_topcard_overflowButton"
    }
    
    public struct Player{
        public static let songNameLabel = "player_songtitleLabel"
        public static let miniPlayerSongTitleLabel = "miniplayer_songTitle"
        public static let leftSeekTimeText = "player_leftSongTimeLabel"
        public static let rightSeekTimeText = "player_rightSongTimeLabel"
        public static let helloTuneButton = "HelloTune"
        public static let helloTuneActivationPopupSongNameLabel = "player_hellotunepopup_songTitleLabel"
        public static let helloTuneActivationPopupActivateOrExtendButton = "player_hellotunepopup_activateButton"
        public static let pauseButton:XCUIElement = app.tables.buttons["player2 pause"]
        public static let playButton:XCUIElement = app.tables.buttons["player2 play"]
        public static let playAllButton:XCUIElement = app.tables.children(matching: .button).element(boundBy: 1)
        public static let queueButtonForScrolling = app.tables.cells.containing(.button, identifier: "Queue").children(matching: .button).element(boundBy: 0)
        public static let queueButton = app.buttons["Queue"]
        public static let navigationButton = app.buttons["navigationbar_overflowButton"]
        public static let clearQueueButton = app.buttons["Clear queue"]
        public static let clearButton = app.buttons["Clear"]
        public static let nextButton:XCUIElement = app.tables.buttons["player2 next"]
        public static let previousButton:XCUIElement = app.tables.buttons["player2 previous"]
    }
    
    public struct Radio{
        public static let personalStationPlayButton = "Radio Play"
        public static let myStationText = "My Station"
    }
    
    public struct RadioPlayer{
        public static let stopButton = "radioPlayerStop"
    }
    
    public struct Ads {
        public static let adsPage = app.staticTexts["Advertisement"]
    }
    
    public struct MyMusic {
        public static let downloads = app.staticTexts["Download"]
        public static let downloadedTextMsg  = app.staticTexts["Downloaded"]
        public static let createPlaylist  = app.staticTexts["Create Playlist"]
        public static let noSongDownloadedTextMsg =  app.staticTexts["No Downloaded Songs"]
        public static let sideMenu = app.navigationBars["My Music"].buttons["overflow white"]
        public static let removeSongs = app.sheets.scrollViews.otherElements.buttons["Remove Songs"]
        public static let multiSelectOption =  app.buttons["multiselect empty"]
        public static let deleteButton =  app.buttons["player delete"]
        public static let removeSongPopUp  = app.alerts["Wynk Music"].scrollViews.otherElements.buttons["Remove Songs"]
        public static let whiteCross = app.buttons["closeWhite"]
       // public static let enterPlaylistNameField =
    }
    
    public struct SearchPage{
        public static let searchTextField = "search_textfield"
        public static let searchKeyBoardButton = "Search"
        public static let moreOnSearch = app.staticTexts.matching(NSPredicate(format:"label CONTAINS 'More'")).element(boundBy: 0)
        public static let downloadButtonOnUniSearchPage = app.buttons.matching(NSPredicate(format:"label CONTAINS 'downloadIcon blue'")).element(boundBy: 0)
        public static let unFinishedDownloadButtonOnUniSearchPage = app.buttons.matching(NSPredicate(format:"label CONTAINS 'errorIcon'")).element(boundBy: 0)
        public static let finishedDownloadIconOnUniSearchPage = app.buttons.matching(NSPredicate(format:"label CONTAINS 'redArrow'")).element(boundBy: 0)
    }
    
    public struct CreatePlaylist{
        public static let downloadedTabOnUserPlaylist = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Downloaded'")).element(boundBy: 0)
        public static let saveButtonOnUserPlaylist = app.buttons.matching(NSPredicate(format: "label CONTAINS 'ViewMore'")).element(boundBy: 0)
        public static let radioButtonToSelectASongInCreatePlaylist = app.tables.cells.children(matching: .button).element(boundBy: 0)
        public static let enterPlaylistNameTextField = app.textFields["Enter playlist name"]
         public static let saveButtonCreatePlaylist = app.buttons["Save"]
    }
}



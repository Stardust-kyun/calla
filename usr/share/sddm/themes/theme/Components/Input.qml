//
// This file is part of Sugar Dark, a theme for the Simple Display Desktop Manager.
//
// Copyright 2018 Marian Arlt
//
// Sugar Dark is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Sugar Dark is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Sugar Dark. If not, see <https://www.gnu.org/licenses/>.
//

import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Column {
    id: inputContainer
    Layout.fillWidth: true

    property Control exposeLogin: loginButton
    property bool failed

    // USERNAME INPUT
    Item {
        id: usernameField

        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        ComboBox {

            id: selectUser

            width: parent.height
            height: parent.height
            anchors.left: parent.left
            z: 2

            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"
            hoverEnabled: true
            onActivated: {
                username.text = currentText
            }

            delegate: ItemDelegate {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                contentItem: Text {
                    text: model.realName != "" ? model.realName : model.name
                    font.pointSize: root.font.pointSize * 0.8
                    font.capitalization: Font.Capitalize
                    color: selectUser.highlightedIndex === index ? config.BackColor : root.palette.highlight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                highlighted: parent.highlightedIndex === index
                background: Rectangle {
                    color: selectUser.highlightedIndex === index ? root.palette.highlight : "transparent"
                }
            }

            indicator: Button {
                    id: usernameIcon
                    width: selectUser.height * 0.8
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: selectUser.height * 0.125
                    icon.height: parent.height * 0.25
                    icon.width: parent.height * 0.25
                    enabled: false
                    icon.color: root.palette.text
                    icon.source: Qt.resolvedUrl("../Assets/User.svgz")
            }

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            popup: Popup {
                y: parent.height - username.height / 3
                rightMargin: config.ForceRightToLeft == "true" ? root.padding + usernameField.width / 2 : undefined
                width: usernameField.width
                implicitHeight: contentItem.implicitHeight
                padding: 10

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight + 20
                    model: selectUser.popup.visible ? selectUser.delegateModel : null
                    currentIndex: selectUser.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    radius: config.RoundCorners / 2
                    color: config.BackColor
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 0
                        radius: 100
                        samples: 201
                        cached: true
                        color: "#88000000"
                    }
                }

                enter: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1 }
                }
            }

            states: [
                State {
                    name: "pressed"
                    when: selectUser.down
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: Qt.lighter(root.palette.highlight, 1.1)
                    }
                },
                State {
                    name: "hovered"
                    when: selectUser.hovered
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: Qt.lighter(root.palette.highlight, 1.2)
                    }
                },
                State {
                    name: "focused"
                    when: selectUser.visualFocus
                    PropertyChanges {
                        target: usernameIcon
                        icon.color: root.palette.highlight
                    }
                }
            ]

            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "color, border.color, icon.color"
                        duration: 150
                    }
                }
            ]

        }

        TextField {
            id: username
            text: config.ForceLastUser == "true" ? selectUser.currentText : null
            font.capitalization: Font.Capitalize
            anchors.centerIn: parent
            height: root.font.pointSize * 3
            width: parent.width
            placeholderText: config.TranslateUsernamePlaceholder || textConstants.userName
            selectByMouse: true
            horizontalAlignment: TextInput.AlignHCenter
            renderType: Text.QtRendering
            background: Rectangle {
                color: "transparent"
                border.color: root.palette.text
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }
            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: password
            z: 1

            states: [
                State {
                    name: "focused"
                    when: username.activeFocus
                    PropertyChanges {
                        target: username.background
                        border.color: root.palette.highlight
                    }
                    PropertyChanges {
                        target: username
                        color: root.palette.highlight
                    }
                }
            ]
        }

    }

    // PASSWORD INPUT
    Item {
        id: passwordField
        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        TextField {
            id: password
            anchors.centerIn: parent
            height: root.font.pointSize * 3
            width: parent.width
            focus: config.ForcePasswordFocus == "true" ? true : false
            selectByMouse: true
            echoMode: revealSecret.checked ? TextInput.Normal : TextInput.Password
            placeholderText: config.TranslatePasswordPlaceholder || textConstants.password
            horizontalAlignment: TextInput.AlignHCenter
            passwordCharacter: "•"
            passwordMaskDelay: config.ForceHideCompletePassword == "true" ? undefined : 1000
            renderType: Text.QtRendering
            background: Rectangle {
                color: "transparent"
                border.color: root.palette.text
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }
            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: revealSecret
        }

        states: [
            State {
                name: "focused"
                when: password.activeFocus
                PropertyChanges {
                    target: password.background
                    border.color: root.palette.highlight
                }
                PropertyChanges {
                    target: password
                    color: root.palette.highlight
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color"
                    duration: 150
                }
            }
        ]
    }

    // SHOW/HIDE PASS
    Item {
        id: secretCheckBox
        height: root.font.pointSize * 7
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        CheckBox {
            id: revealSecret
            width: parent.width
            hoverEnabled: true

            indicator: Rectangle {
                id: indicator
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 3
                anchors.leftMargin: 4
                implicitHeight: root.font.pointSize
                implicitWidth: root.font.pointSize
                color: "transparent"
                border.color: root.palette.text
                border.width: parent.visualFocus ? 2 : 1
                Rectangle {
                    id: dot
                    anchors.centerIn: parent
                    implicitHeight: parent.width - 6
                    implicitWidth: parent.width - 6
                    color: root.palette.text
                    opacity: revealSecret.checked ? 1 : 0
                }
            }

            contentItem: Text {
                id: indicatorLabel
                text: config.TranslateShowPassword || "Show Password"
                anchors.verticalCenter: indicator.verticalCenter
                anchors.verticalCenterOffset: 0
                horizontalAlignment: Text.AlignLeft
                anchors.left: indicator.right
                anchors.leftMargin: indicator.width / 2
                font.pointSize: root.font.pointSize * 0.8
                color: root.palette.text
            }

            Keys.onReturnPressed: toggle()
            KeyNavigation.down: loginButton

            background: Rectangle {
                color: "transparent"
                border.width: parent.visualFocus ? 1 : 0
                border.color: parent.visualFocus ? root.palette.text : "transparent"
                height: parent.visualFocus ? 2 : 0
                width: (indicator.width + indicatorLabel.contentWidth + indicatorLabel.anchors.leftMargin + 2)
                anchors.top: indicatorLabel.bottom
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.topMargin: 8
            }
        }

        states: [
            State {
                name: "pressed"
                when: revealSecret.down
                PropertyChanges {
                    target: revealSecret.contentItem
                    color: Qt.darker(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: dot
                    color: Qt.darker(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: indicator
                    border.color: Qt.darker(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: revealSecret.background
                    border.color: Qt.darker(root.palette.highlight, 1.1)
                }
            },
            State {
                name: "hovered"
                when: revealSecret.hovered
                PropertyChanges {
                    target: indicatorLabel
                    color: Qt.lighter(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: indicator
                    border.color: Qt.lighter(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: dot
                    color: Qt.lighter(root.palette.highlight, 1.1)
                }
                PropertyChanges {
                    target: revealSecret.background
                    border.color: Qt.lighter(root.palette.highlight, 1.1)
                }
            },
            State {
                name: "focused"
                when: revealSecret.visualFocus
                PropertyChanges {
                    target: indicatorLabel
                    color: root.palette.highlight
                }
                PropertyChanges {
                    target: indicator
                    border.color: root.palette.highlight
                }
                PropertyChanges {
                    target: dot
                    color: root.palette.highlight
                }
                PropertyChanges {
                    target: revealSecret.background
                    border.color: root.palette.highlight
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "color, border.color, opacity"
                    duration: 150
                }
            }
        ]

    }

    // ERROR FIELD
    Item {
        height: root.font.pointSize * 2.3
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        Label {
            id: errorMessage
            width: parent.width
            text: failed ? config.TranslateLoginFailed || textConstants.loginFailed + "!" : keyboard.capsLock ? textConstants.capslockWarning : null
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: root.font.pointSize * 0.8
            font.italic: true
            color: root.palette.text
            opacity: 0
            states: [
                State {
                    name: "fail"
                    when: failed
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                },
                State {
                    name: "capslock"
                    when: keyboard.capsLock
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 100
                    }
                }
            ]
        }
    }

    // LOGIN BUTTON
    Item {
        id: login
        height: root.font.pointSize * 3
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            id: loginButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: config.TranslateLogin || textConstants.login
            height: root.font.pointSize * 3
            implicitWidth: parent.width
            enabled: username.text != "" && password.text != "" ? true : false
            hoverEnabled: true

            contentItem: Text {
                text: parent.text
                color: "#444"
                font.pointSize: root.font.pointSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: 0.5
            }

            background: Rectangle {
                id: buttonBackground
                color: "white"
                opacity: 0.2
                radius: config.RoundCorners || 0
            }

            states: [
                State {
                    name: "pressed"
                    when: loginButton.down
                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.darker(root.palette.highlight, 1.1)
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                        color: "#444"
                    }
                },
                State {
                    name: "hovered"
                    when: loginButton.hovered
                    PropertyChanges {
                        target: buttonBackground
                        color: root.palette.highlight
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                        color: "#444"
                    }
                },
                State {
                    name: "focused"
                    when: loginButton.visualFocus
                    PropertyChanges {
                        target: buttonBackground
                        color: root.palette.highlight
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                        color: "#444"
                    }
                },
                State {
                    name: "enabled"
                    when: loginButton.enabled
                    PropertyChanges {
                        target: buttonBackground;
                        color: root.palette.text;
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem;
                        opacity: 1
                    }
                }
            ]

            transitions: [
                Transition {
                    from: ""; to: "enabled"
                    PropertyAnimation {
                        properties: "opacity, color";
                        duration: 500
                    }
                },
                Transition {
                    from: "enabled"; to: ""
                    PropertyAnimation {
                        properties: "opacity, color";
                        duration: 300
                    }
                }
            ]

            Keys.onReturnPressed: clicked()
            onClicked: sddm.login(username.text, password.text, sessionSelect.selectedSession)
        }
    }

    // SESSION SELECT
    SessionButton {
        id: sessionSelect
        textConstantSession: textConstants.session
    }

    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            failed = true
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}

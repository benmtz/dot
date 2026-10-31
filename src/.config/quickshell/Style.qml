pragma Singleton
import QtQuick

QtObject {
    readonly property color backgroundColor: "#00000000"
    readonly property int fontSizeLarge: 20
    readonly property int basePadding: 10
    readonly property int unit: 8
    readonly property QtObject text: QtObject {
      property color foreground: "{< glob.white >}"
      property color background: "#00000000"
      property string family: "{< font.name >}"
      property int pointSize: 12
    }
}

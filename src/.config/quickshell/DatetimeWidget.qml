import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import "topConsumers.js" as TopConsumers


PanelWindow {
    id: root
    color: "#00000000"
    anchors {
        top: true
        left: true
    }

    margins {
        top: 0
        left: 10
    }



  implicitWidth: 200
  implicitHeight: 120

    WlrLayershell.layer: WlrLayer.Bottom
    exclusionMode: ExclusionMode.Ignore


    Text {
      id: clock
      color: Style.text.foreground
      font.family: Style.text.family
      font.pointSize: 46

      Process {
        id: clockProcess
        command: ["date", "+%R"]
        stdout: StdioCollector {
          onStreamFinished: clock.text = this.text
        }
      }

      Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clockProcess.running = true
      }
    }
}

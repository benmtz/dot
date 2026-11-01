
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Rectangle {
  id: root

  readonly property int refreshIntervalMs: 1000
  property string usagePercent: ""

  color: Style.text.background

  implicitWidth: statusLine.implicitWidth
  implicitHeight: statusLine.implicitHeight

  Process {
    id: meminfo
    command: ["/bin/bash", "-c","awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf \"%.1f%%\\n\", ((t-a)/t)*100}' /proc/meminfo"]
    stdout: StdioCollector {
      onStreamFinished: usagePercent = text.trim()
    }
  }

  Timer {
    interval: root.refreshIntervalMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      meminfo.running = true
    }
  }

    Text {
      id: statusLine
      text: `\uefc5 ${root.usagePercent}`
      color: Style.text.foreground
      font.family: Style.text.family
      font.pointSize: Style.text.pointSize
    }
}

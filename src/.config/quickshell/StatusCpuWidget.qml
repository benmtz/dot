import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Rectangle {
  id: root

  readonly property int refreshIntervalMs: 1000
  property string usagePercent: ""
  property string temperatureCelsius: ""

  implicitWidth: statusLine.implicitWidth
  implicitHeight: statusLine.implicitHeight

  color: Style.text.background

  Process {
    id: cpuStat
    command: [
      "/bin/bash",
      "-c",
      "top -bn2 -d 0.1 | grep '%Cpu' | tail -n1 | sed -E 's/.*, *([0-9.]+) id.*/\\1/' | awk '{print 100 - $1 \"%\"}'"
    ]
    stdout: StdioCollector {
      onStreamFinished: root.usagePercent = text.trim()
    }
  }

  Process {
    id: cpuTemperature
    command: ["/bin/bash", "-c", "sensors -j | jq '.\"coretemp-isa-0000\".\"Package id 0\".temp1_input'"]
    stdout: StdioCollector {
      onStreamFinished: root.temperatureCelsius = text.trim()
    }
  }

  Timer {
    interval: root.refreshIntervalMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      cpuStat.running = true
      cpuTemperature.running = true
    }
  }

  Text {
    id: statusLine
    text: `\uf4bc ${root.usagePercent} \uf2c7 ${root.temperatureCelsius}°C`
    color: Style.text.foreground
    font.family: Style.text.family
  }
}

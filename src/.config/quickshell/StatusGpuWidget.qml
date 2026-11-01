import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Rectangle {
  id: root
  readonly property int refreshIntervalMs: 1000
  readonly property int topConsumerCount: 3
  property int usagePercent: 0
  property int temperatureCelsius: 0
  property var topConsumerList: []

  /** Updates usage and temperature from one "utilization, temperature" CSV line of nvidia-smi. */
  function updateStats(csvLine) {
    const [utilization, temperature] = csvLine.trim().split(/,\s*/).map(Number)
    usagePercent = utilization
    temperatureCelsius = temperature
  }

  implicitWidth: statusLine.implicitWidth
  implicitHeight: statusLine.implicitHeight
  color: Style.text.background

  Process {
    id: nvidiaSmi
    command: ["nvidia-smi", "--query-gpu=utilization.gpu,temperature.gpu", "--format=csv,noheader,nounits"]
    stdout: StdioCollector {
      onStreamFinished: root.updateStats(text)
    }
  }

  Timer {
    interval: root.refreshIntervalMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      nvidiaSmi.running = true
    }
  }

    Text {
      id: statusLine
      text: `\udb82\udc40 ${root.usagePercent}% ${root.temperatureCelsius}°C`
      anchors.fill: parent
      color: Style.text.foreground
      font.family: Style.text.family
      font.pointSize: Style.text.pointSize
    }
}

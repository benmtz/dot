import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

PanelWindow {
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

  /** Updates topConsumerList from `nvidia-smi pmon` output, locating columns by header name since their order varies across driver versions. */
  function updateTopConsumers(pmonText) {
    const lineList = pmonText.trim().split("\n")
    const columnList = lineList[0].replace(/^#\s*/, "").split(/\s+/)
    const smIndex = columnList.indexOf("sm")
    const commandIndex = columnList.indexOf("command")
    topConsumerList = lineList
      .filter(line => !line.startsWith("#"))
      .map(line => {
        const fieldList = line.trim().split(/\s+/)
        return { name: fieldList[commandIndex], usagePercent: parseInt(fieldList[smIndex]) || 0 }
      })
      .sort((first, second) => second.usagePercent - first.usagePercent)
      .slice(0, topConsumerCount)
  }

  anchors {
    top: true
    right: true
  }
  margins {
    right: 20
  }

  implicitWidth: 200
  implicitHeight: 120
  color: Style.text.background

  WlrLayershell.layer: WlrLayer.Bottom
  exclusionMode: ExclusionMode.Ignore

  Process {
    id: nvidiaSmi
    command: ["nvidia-smi", "--query-gpu=utilization.gpu,temperature.gpu", "--format=csv,noheader,nounits"]
    stdout: StdioCollector {
      onStreamFinished: root.updateStats(text)
    }
  }

  Process {
    id: nvidiaSmiProcesses
    command: ["nvidia-smi", "pmon", "--count", "1", "--select", "u"]
    stdout: StdioCollector {
      onStreamFinished: root.updateTopConsumers(text)
    }
  }

  Timer {
    interval: root.refreshIntervalMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      nvidiaSmi.running = true
      nvidiaSmiProcesses.running = true
    }
  }

  Column {
    Text {
      text: `\udb82\udc40 ${root.usagePercent}% ${root.temperatureCelsius}°C`
      color: Style.text.foreground
      font.family: Style.text.family
    }

    TopConsumerList {
      consumerList: root.topConsumerList
    }
  }
}

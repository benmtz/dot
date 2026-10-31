import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import "topConsumers.js" as TopConsumers

PanelWindow {
  id: root

  readonly property int refreshIntervalMs: 1000
  readonly property int topConsumerCount: 3
    readonly property int padding: 10
  property int usagePercent: 0
  property var topConsumerList: []

  /** Updates usagePercent from MemTotal and MemAvailable, so reclaimable cache counts as free. */
  function updateUsage(meminfoText) {
    const kilobytesByKey = meminfoText.trim().split("\n").reduce((result, line) => {
      const [key, value] = line.split(/:\s+/)
      result[key] = parseInt(value)
      return result
    }, {})
    const usedKilobytes = kilobytesByKey.MemTotal - kilobytesByKey.MemAvailable
    usagePercent = Math.round(100 * usedKilobytes / kilobytesByKey.MemTotal)
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
    id: meminfo
    command: ["grep", "-E", "^(MemTotal|MemAvailable):", "/proc/meminfo"]
    stdout: StdioCollector {
      onStreamFinished: root.updateUsage(text)
    }
  }

  Process {
    id: topRamConsumers
    command: ["sh", "-c", `ps -eo %mem,comm --sort=-%mem --no-headers | head -${root.topConsumerCount}`]
    stdout: StdioCollector {
      onStreamFinished: root.topConsumerList = TopConsumers.parseValueNameLines(text)
    }
  }

  Timer {
    interval: root.refreshIntervalMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      meminfo.running = true
      topRamConsumers.running = true
    }
  }

  Column {
    Text {
      text: `\uefc5 ${root.usagePercent}%`
      color: Style.text.foreground
      font.family: Style.text.family
      font.pointSize: Style.text.pointSize
    }

    TopConsumerList {
      consumerList: root.topConsumerList
    }
  }
}

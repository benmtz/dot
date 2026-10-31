import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import "topConsumers.js" as TopConsumers

PanelWindow {
  id: root

  readonly property int refreshIntervalMs: 1000
  readonly property int milliDegreesPerDegree: 1000
  readonly property int topConsumerCount: 3
  readonly property real topSampleSeconds: 0.5
  property real previousTotal: 0
  property real previousIdle: 0
  property int usagePercent: 0
  readonly property int padding: 10
  property int temperatureCelsius: 0
  property var topConsumerList: []

  /** Updates usagePercent from the busy/idle delta since the previous /proc/stat sample. */
  function updateUsage(statLine) {
    const [user, nice, system, idle, iowait, irq, softirq, steal] = statLine.trim().split(/\s+/).slice(1).map(Number)
    const idleTotal = idle + iowait
    const total = user + nice + system + idleTotal + irq + softirq + steal
    const totalDelta = total - previousTotal
    const idleDelta = idleTotal - previousIdle
    previousTotal = total
    previousIdle = idleTotal
    if (totalDelta <= 0) {
      return
    }
    usagePercent = Math.round(100 * (totalDelta - idleDelta) / totalDelta)
  }

  anchors {
    top: true
    right: true
  }
  margins {
    top: 50
    right: 20
  }

  implicitWidth: 200
  implicitHeight: 120
  color: Style.text.background

  WlrLayershell.layer: WlrLayer.Bottom
  exclusionMode: ExclusionMode.Ignore

  Process {
    id: cpuStat
    command: ["head", "-1", "/proc/stat"]
    stdout: StdioCollector {
      onStreamFinished: root.updateUsage(text)
    }
  }

  Process {
    id: cpuTemperature
    command: ["sh", "-c", "cat \"$(dirname \"$(grep -lx x86_pkg_temp /sys/class/thermal/thermal_zone*/type)\")/temp\""]
    stdout: StdioCollector {
      onStreamFinished: root.temperatureCelsius = Math.round(Number(text) / root.milliDegreesPerDegree)
    }
  }

  Process {
    id: topCpuConsumers
    command: ["sh", "-c", `top -b -n 2 -d ${root.topSampleSeconds} -o %CPU | awk '/^top -/ { frame++ } frame == 2 && $1 ~ /^[0-9]+$/ { value = $9; $1 = $2 = $3 = $4 = $5 = $6 = $7 = $8 = $9 = $10 = $11 = ""; sub(/^ +/, ""); print value, $0 }' | head -${root.topConsumerCount}`]
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
      cpuStat.running = true
      cpuTemperature.running = true
      topCpuConsumers.running = true
    }
  }

  Column {
    anchors {
      margins: root.padding
    }

    Text {
      text: `\uf4bc ${root.usagePercent}% \uf2c7 ${root.temperatureCelsius}°C`
      color: Style.text.foreground
      font.family: Style.text.family
    }

    TopConsumerList {
      consumerList: root.topConsumerList
    }
  }
}

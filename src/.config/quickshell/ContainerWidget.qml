import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

PanelWindow {
  id: root

  readonly property int refreshIntervalMs: 5000
  readonly property int padding: 10
  property var containerList: []

  /** Updates containerList from "id name" lines of `docker ps`. */
  function updateContainers(dockerPsText) {
    containerList = dockerPsText.trim().split("\n").filter(line => line.length > 0).map(line => {
      const [id, name] = line.split(" ")
      return { id: id, name: name }
    })
  }

  anchors {
    top: true
    right: true
  }
  margins {
    right: 20
  }

  implicitWidth: 200
  implicitHeight: containerColumn.implicitHeight + 2 * root.padding
  color: Style.backgroundColor

  WlrLayershell.layer: WlrLayer.Bottom
  exclusionMode: ExclusionMode.Ignore

  Process {
    id: dockerPs
    command: ["docker", "ps", "--format", "{{.ID}} {{.Names}}"]
    stdout: StdioCollector {
      onStreamFinished: root.updateContainers(text)
    }
  }

  Timer {
    interval: root.refreshIntervalMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: dockerPs.running = true
  }

  Column {
    id: containerColumn

    anchors {
      left: parent.left
      right: parent.right
      margins: root.padding
    }

    Text {
      text: `\uf4b7 ${root.containerList.length}`
      color: Style.text.foreground
      font.family: Style.text.family
    }

    Repeater {
      model: root.containerList

      Row {
        required property var modelData

        width: containerColumn.width
        spacing: root.padding

        Text {
          width: parent.width - containerId.width - parent.spacing
          text: modelData.name
          elide: Text.ElideRight
          color: Style.text.foreground
          font.family: Style.text.family
        }

        Text {
          id: containerId
          text: modelData.id
          color: Style.text.foreground
          font.family: Style.text.family
        }
      }
    }
  }
}
